//
//  MovieDetailsView.swift
//  MovieRama
//
//  Created by Alex Moumoulides on 03/12/23.
//

import SwiftUI
import Kingfisher

extension Double {
    func toInt() -> Int? {
        if self >= Double(Int.min) && self < Double(Int.max) {
            return Int(self)
        } else {
            return nil
        }
    }
}

struct MovieDetailsView: View {
    
    @ObservedObject var vm: MovieDetailsViewModel
    let posterHeightRatio: CGFloat = 0.3
    
    var body: some View {
        
        if !vm.isLoading {
            GeometryReader { geo in
                VStack(alignment: .center, spacing: 10) {
                    if #available(iOS 14.0, *) {
                        KFImage.url(URL(string: vm.movieData != nil ? "https://image.tmdb.org/t/p/original\(vm.movieData!.backdropPath!)": ""))
                            .placeholder({ progress in
                                ProgressView()
                            })
                            .loadDiskFileSynchronously()
                            .cacheMemoryOnly()
                            .fade(duration: 0.25)
                            .resizable()
                            .renderingMode(.original)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geo.size.width, height: geo.size.height * posterHeightRatio)
                            .clipped()
                            .cornerRadius(20)
                            .shadow(radius: 10)
                    } else {
                        // I really dont know whats available under ios 14
                        Image(systemName: "questionmark.diamond")
                    }
                    
                    if (vm.movieData != nil) {
                        VStack(alignment: .leading, spacing: 5) {
                            
                            HStack(alignment: .center) {
                                
                                Text(vm.movieData!.title)
                                    .foregroundColor(.primary)
                                    .font(.headline)
                                
                                if vm.movieData!.releaseDate != nil {
                                    Text(vm.movieData!.releaseDate!)
                                        .font(.caption)
                                        .foregroundColor(.primary)
                                        .multilineTextAlignment(.leading)
                                }
                            }
                            Text(vm.movieData!.genreNames.joined(separator: ", "))
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                        .multilineTextAlignment(.leading)
                            
                            if vm.movieData!.voteAverage != nil {
                                RatingView(rating: (vm.movieData!.voteAverage! / 2).toInt() ?? 0)
                            }
                            
                            Text(vm.movieData!.overview)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.leading)
                                .padding(.vertical)
                            
                            
                            Text("Director")
                                .foregroundColor(.primary)
                                .font(.callout)
                            
                            Text(vm.movieData!.director)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                    .multilineTextAlignment(.leading)
                            
                            Text("Cast")
                                .foregroundColor(.primary)
                                .font(.callout)
                            
                            Text(vm.movieData!.mainCastNames.prefix(3).joined(separator: ", "))
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                        .multilineTextAlignment(.leading)
                            
                            
                        }.padding()
                        
                        
                    }
                    
                    
                    Spacer()
                }
                .edgesIgnoringSafeArea(.all)
            }
        }
    }
}

struct MovieDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        AppDIContainer.shared.makeMovieDetailsView(vm: AppDIContainer.shared.makeMovieDetailsViewModel(movieId: MovieFull.example().id))
    }
}
