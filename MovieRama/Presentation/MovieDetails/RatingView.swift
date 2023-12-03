//
//  RatingView.swift
//  MovieRama
//
//  Created by Alex Moumoulides on 03/12/23.
//

import SwiftUI

struct RatingView: View {
    
    var rating: Int

    var label = ""

    var maximumRating = 5

    var offImage: Image?
    var onImage = Image(systemName: "star.fill")

    var offColor = Color.gray
    var onColor = Color.yellow
    
    func image(for number: Int) -> Image {
        if number > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
    
    var body: some View {
        HStack {
            if label.isEmpty == false {
                Text(label)
            }

            ForEach(1..<maximumRating + 1, id: \.self) { number in
                
                if #available(iOS 15.0, *) {
                    image(for: number)
                        .foregroundStyle(number > rating ? offColor : onColor)
                } else {
                    image(for: number).foregroundColor(number > rating ? offColor : onColor)
                }
            }
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: 4)
    }
}
