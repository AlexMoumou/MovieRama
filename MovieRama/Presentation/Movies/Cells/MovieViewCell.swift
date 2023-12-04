//
//  MovieViewCell.swift
//  MovieRama
//
//  Created by Alex Moumoulides on 02/12/23.
//

import UIKit
import Kingfisher

public extension UIView {
    func showAnimation(_ completionBlock: @escaping () -> Void) {
      isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.1,
                       delay: 0,
                       options: .curveLinear,
                       animations: { [weak self] in
                            self?.transform = CGAffineTransform.init(scaleX: 1.95, y: 1.95)
        }) {  (done) in
            UIView.animate(withDuration: 0.1,
                           delay: 0,
                           options: .curveLinear,
                           animations: { [weak self] in
                                self?.transform = CGAffineTransform.init(scaleX: 1, y: 1)
            }) { [weak self] (_) in
                self?.isUserInteractionEnabled = true
                completionBlock()
            }
        }
    }
}

class MovieViewCell: UITableViewCell, XibInstantiableCell {
    
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var releaseD: UILabel!
    @IBOutlet weak var rating: UILabel!
    
    @IBOutlet weak var favoriteB: UIButton!
    
    var onAction : ((Int) -> Void)? = nil
    
    var movie: Movie? = nil
    
    @IBAction func onFavoriteTap(_ sender: UIButton) {
        sender.showAnimation {
            if let action = self.onAction {
            action(self.movie!.id)
            }
        }
    }
    
    static var cellHeight: CGFloat {
        return 200
    }
    
    override func layoutSubviews() {
            super.layoutSubviews()

        poster.contentMode = .scaleAspectFill
        poster.backgroundColor = .clear
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        title.textColor = .white
        
        card.layer.cornerRadius = 19
        
        poster.layer.cornerRadius = 19
        poster.contentMode = .scaleAspectFill
        poster.backgroundColor = .clear
        
    }
    
    func setup(with movie: Movie) {
        
        self.movie = movie
        
        if movie.posterPath != nil {
            let url = URL(string: "https://image.tmdb.org/t/p/w200/\(movie.posterPath!)")
            poster.kf.setImage(with: url)
        }
        
        self.title.text = movie.title
        self.releaseD.text = movie.releaseDate
        self.rating.text = String(format: "%.1f", movie.voteAverage ?? "-")
        self.rating.tintColor = .red
        
        favoriteB.setImage(UIImage(systemName: movie.isFavorite ? "heart.fill": "heart")!.withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: .normal)
        favoriteB.tintColor = UIColor.red
        favoriteB.setTitle("", for: .normal)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
}
