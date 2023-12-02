//
//  MovieViewCell.swift
//  MovieRama
//
//  Created by Alex Moumoulides on 02/12/23.
//

import UIKit
//import Kingfisher

class MovieViewCell: UITableViewCell, XibInstantiableCell {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var release: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var favoriteStatus: UIImageView!
    
    
    static var cellHeight: CGFloat {
        return 100
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(with movie: Movie) {
        let url = URL(string: "https://image.tmdb.org/t/p/w200/\(movie.posterPath!)")
//        poster.kf.setImage(with: url)
        self.title.text = movie.title
        self.release.text = movie.releaseDate
        self.rating.text = String(format: "%.1f", movie.voteAverage ?? "-")
        self.favoriteStatus.image = movie.isFavorite ? UIImage(named: "heart.fill") : UIImage(named: "heart")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
}
