//
//  MoviesViewController.swift
//  MovieRama
//
//  Created by Alex Moumoulides on 02/12/23.
//

import UIKit
import Combine

class MoviesViewController: UIViewController, XibInstantiable {

    private(set) var vm: (any IMoviesViewModel)?
    private var cancellables: [AnyCancellable] = []
    
    @IBOutlet weak var moviesTableView: UITableView!
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        
        searchController.searchBar.tintColor = .label
        searchController.obscuresBackgroundDuringPresentation = false
        
        return searchController
    }()
    
    private var movies: [Movie] = []
    
    final class func create(with vm: any IMoviesViewModel) -> MoviesViewController {
        let view = MoviesViewController()
        view.vm = vm as! MoviesViewModel
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bind(vm: vm!)
        applySearchDebounce()
        
        vm?.send(action: .load(query: nil))
    }

    private func setupUI() {
        navigationItem.title = "MOVIERAMA!!!"
        
        moviesTableView.register(UINib(nibName: "MovieViewCell", bundle: .main), forCellReuseIdentifier: "MovieViewCell")
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        moviesTableView.separatorColor = .clear
        
        searchController.searchBar.delegate = self
        navigationItem.searchController = self.searchController
        searchController.isActive = true
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(onRefresh), for: .valueChanged)
            
        moviesTableView.refreshControl = refreshControl
        
    }
    
    @objc func onRefresh(refreshControl: UIRefreshControl) {
        vm?.send(action: .refresh)
    }
    
    private func bind(vm: any IMoviesViewModel) {
        vm.moviesList.sink(receiveValue: {[weak self] list in
            
            guard let strongSelf = self else { return }
            
            strongSelf.moviesTableView.refreshControl?.endRefreshing()
            
            UIView.transition(with: strongSelf.moviesTableView,
            duration: 0.4,
            options: .transitionCrossDissolve,
            animations: {
                
                strongSelf.movies = list
                strongSelf.moviesTableView.reloadData()
            })
            
            
        }).store(in: &cancellables)
    }
    
    func applySearchDebounce() {
      let publisher = NotificationCenter.default.publisher(for: UISearchTextField.textDidChangeNotification, object: searchController.searchBar.searchTextField)
      publisher.map {
            ($0.object as! UISearchTextField).text!
      }
      .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
      .sink(receiveValue: { (value) in
          if value.convertedToSlug() != nil || value == "" {
              self.vm?.send(action: .load(query: value.convertedToSlug()))
          }
      })
      .store(in: &cancellables)
    }
}

extension MoviesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        vm?.send(action: .tapMovieWith(id: movies[indexPath.row].id))
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MovieViewCell.cellHeight
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = moviesTableView.dequeueReusableCell(withIdentifier: "MovieViewCell") as! MovieViewCell

        
        cell.setup(with: movies[indexPath.row])
        cell.onAction = { id in
            self.vm?.send(action: .favoriteMovieWith(id: id))
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row >= movies.count - 1) {
            vm?.send(action: .onScrollLoad)
        }
    }
}

extension MoviesViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        vm?.send(action: .load(query: nil))
    }
}

extension String {
    private static let slugSafeCharacters = CharacterSet(charactersIn: "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-")

    public func convertedToSlug() -> String? {
        if let latin = self.applyingTransform(StringTransform("Any-Latin; Latin-ASCII; Lower;"), reverse: false) {
            let urlComponents = latin.components(separatedBy: String.slugSafeCharacters.inverted)
            let result = urlComponents.filter { $0 != "" }.joined(separator: "-")

            if result.count > 0 {
                return result
            }
        }

        return nil
    }
}
