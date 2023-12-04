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

struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 2 : 1)
    }
}

struct MovieDetailsView: View {
    
    @ObservedObject var vm: MovieDetailsViewModel
    let posterHeightRatio: CGFloat = 0.3
    
    var body: some View {
        
        if !vm.isLoading {
                GeometryReader { geo in
                    ZStack {
                        ScrollView(showsIndicators: false) {
                            if (vm.movieData != nil) {
                                Spacer()
                                        .frame(height: geo.size.height * posterHeightRatio)
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
                                        
                                        Spacer()
                                        Button {
                                            vm.send(action: .toggleFavoriteStatus)
                                        } label: {
                                            Image(systemName: vm.movieData!.isFavorite ? "heart.fill": "heart").foregroundColor(.red)
                                        }.buttonStyle(ScaleButtonStyle())
                                        
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
                                        .fixedSize(horizontal: false, vertical: true)
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(5)
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
                                        .multilineTextAlignment(.leading).padding(.bottom)
                                    
                                    if #available(iOS 14.0, *) {
                                        if !vm.similarMovies.isEmpty {
                                            
                                            Text("Similar Movies")
                                                .foregroundColor(.primary)
                                                .font(.callout)
                                            
                                            ScrollView(.horizontal, showsIndicators: false) {
                                                HStack(spacing: 10) {
                                                    ForEach(vm.similarMovies.filter({ movie in
                                                        movie.posterPath != nil
                                                    })) {
                                                        KFImage.url(URL(string: vm.movieData != nil ? "https://image.tmdb.org/t/p/w200\($0.posterPath!)": ""))
                                                            .placeholder({ progress in
                                                                ProgressView()
                                                            })
                                                            .loadDiskFileSynchronously()
                                                            .cacheMemoryOnly()
                                                            .fade(duration: 0.25)
                                                            .resizable()
                                                            .renderingMode(.original)
                                                            .aspectRatio(contentMode: .fill)
                                                            .frame(height: 140)
                                                            .cornerRadius(20)
                                                            .shadow(radius: 5)
                                                            .padding(.all, 1)
                                                    }
                                                }
                                            }.padding(.bottom)
                                            
                                        }
                                        
                                        if !vm.movieReviews.isEmpty {
                                            
                                            Text("Reviews")
                                                .foregroundColor(.primary)
                                                .font(.callout)
                                                .padding(.bottom)
                                                
                                            ScrollView(.horizontal, showsIndicators: false) {
                                                LazyHStack {
                                                    ForEach(vm.movieReviews) { review in
                                                        VStack(alignment: .leading) {
                                                            Text(review.author)
                                                                .font(.caption)
                                                                .foregroundColor(.primary)
                                                                .multilineTextAlignment(.leading)
                                                                .padding(.bottom, 5)
                                                            Text(review.content)
                                                                .font(.caption)
                                                                .foregroundColor(.secondary)
                                                                .multilineTextAlignment(.leading)
                                                                .frame(width: geo.size.width - 20)
                                                                
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }.padding()
                                
                                Spacer()
                            }
                        }
                        
                        VStack {
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
                                    .cornerRadius(20)
                                    .shadow(radius: 10)
                                
                            } else {
                                // I really dont know whats available under ios 14
                                Image(systemName: "questionmark.diamond")
                            }
                            Spacer()
                        }
                            
                        }
                }.edgesIgnoringSafeArea(.top)
        }
    }
}

struct MovieDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        AppDIContainer.shared.makeMovieDetailsView(vm: AppDIContainer.shared.makeMovieDetailsViewModel(movieId: MovieFull.example().id))
    }
}
