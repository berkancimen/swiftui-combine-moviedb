//
//  MovieListCardView.swift
//  OKR1 2022 Movie App
//
//  Created by Berkan Cimen on 30.04.2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieListCardView: View {
    
    let movie : MovieViewModel
    
    var body: some View {
        HStack {
                WebImage(url: URL(string: movie.imageUrl))
                    .onSuccess { image, data, cacheType in
                    }
                    .resizable()
                    .indicator(.activity)
                    .transition(.fade(duration: 0.5))
                    .frame(width: 100, height: 150, alignment: .center)
                    .background(LinearGradient(gradient: Gradient(colors: [.black, .gray, .white]), startPoint: .bottomTrailing, endPoint: .topLeading))
                    .cornerRadius(20)
            VStack(alignment: .leading) {
                Text(movie.name)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .padding([.bottom], 2)
                Text(movie.overview)
                    .fontWeight(.regular)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.leading)
                    .lineLimit(4)
                    .padding([.bottom], 2)
                HStack(spacing: 0) {
                    Text(movie.releaseDate)
                        .font(.body)
                        .fontWeight(.regular)
                        .foregroundColor(Color.gray)
                        .multilineTextAlignment(.leading)
                        .lineLimit(1)
                    Spacer()
                    if let ratingString = movie.ratingString {
                        Image("starIcon")
                            .frame(width: 30, height: 30)
                        Text(ratingString)
                            .fontWeight(.semibold)
                            .foregroundColor(Color(red: 1.0, green: 0.757, blue: 0.027))
                            .lineLimit(1)
                            .frame(height: 30)
                    }
                }
            }
            Spacer()
        }
        .listRowBackground(Color.clear)
        .padding([.bottom], 6)
        .background(Color.clear)
    }
}

struct MovieListCardView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListCardView(movie: MovieViewModel.default)
    }
}
