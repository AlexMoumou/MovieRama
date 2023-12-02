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
    
    final class func create(with vm: any IMoviesViewModel) -> MoviesViewController {
        let view = MoviesViewController()
        view.vm = vm as! MoviesViewModel
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        moviesTableView.register(UINib(nibName: "MovieViewCell", bundle: nil), forCellReuseIdentifier: MovieViewCell.reuseIdentifier)
//        moviesTableView.register(MovieViewCell.nib, forCellReuseIdentifier: MovieViewCell.reuseIdentifier)
        setupUI()
        bind(vm: vm!)
    }

    private func setupUI() {
        navigationItem.title = "MOVIERAMA!!!"
        
        moviesTableView.delegate = self
        moviesTableView.backgroundColor = .white
        moviesTableView.dataSource = self
        
    }
    
    private func bind(vm: any IMoviesViewModel) {
//        vm.moviesList.sink(receiveValue: {[unowned self] list in
////            tableview.reloadData()
//            DispatchQueue.main.async {
//                tableview.reloadData()
//            }
//        }).store(in: &cancellables)
//
//        vm.send(action: .load)
    }
}

extension MoviesViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell()
////
//        cell.backgroundColor = .clear
//        cell.tintColor = .blue
//        cell.textLabel?.text = "test"
//        cell.textLabel?.tintColor = .darkGray
//        cell.textLabel?.textColor = .purple
//        cell.textLabel?.highlightedTextColor = .white
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieViewCell.reuseIdentifier, for: indexPath) as! MovieViewCell
        
//        print("Movie: \(movies[indexPath.row])")
        cell.setup(with: Movie.example())
        
//        cell.setup(with: movies[indexPath.row])
//        cell.accessibilityLabel = String(format: NSLocalizedString("Movie with id: %@", comment: ""), "\(vm.moviesListPublish[indexPath.row])")
        
        
        return cell
    }
}
