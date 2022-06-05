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
            ZStack(alignment: .bottomTrailing) {
                WebImage(url: URL(string: movie.imageUrl))
                    .onSuccess { image, data, cacheType in
                    }
                    .resizable()
                    .indicator(.activity)
                    .transition(.fade(duration: 0.5))
                    .frame(width: 100, height: 150, alignment: .center)
                    .background(LinearGradient(gradient: Gradient(colors: [.black, .gray, .white]), startPoint: .bottomTrailing, endPoint: .topLeading))
                    .cornerRadius(20)
                Text(movie.ratingString)
                    .fontWeight(.bold)
                    .foregroundColor(Color(hue: 0.148, saturation: 0.935, brightness: 0.964))
                    .lineLimit(1)
                    .padding([.bottom, .trailing, .leading], 8)
            }
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
                Text(movie.releaseDate)
                    .font(.body)
                    .fontWeight(.regular)
                    .foregroundColor(Color.gray)
                    .multilineTextAlignment(.leading)
                    .lineLimit(1)
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
