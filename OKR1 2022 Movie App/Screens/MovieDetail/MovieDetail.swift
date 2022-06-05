//
//  MovieDetail.swift
//  OKR1 2022 Movie App
//
//  Created by Berkan Cimen on 5.06.2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieDetail: View {
    
    @StateObject private var viewModel: MovieDetailViewModel
    
    init(movieId: Int) {
        _viewModel = StateObject(wrappedValue: MovieDetailViewModel(service: WebServiceFactory.create(), movieId: movieId))
    }
    
    var body: some View {
        
        GeometryReader { mainView in
            
            ScrollView(.vertical) {
                VStack {
                    
                    WebImage(url: URL(string: viewModel.movieDetail.imageUrl))
                        .onSuccess { image, data, cacheType in
                        }
                        .resizable()
                        .indicator(.activity)
                        .transition(.fade(duration: 0.5))
                        .frame(maxWidth: .infinity)
                        .aspectRatio(10/15, contentMode: .fill)
                        
                    Text(viewModel.movieDetail.name)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color(hue: 0.148, saturation: 0.935, brightness: 0.964))
                        .padding([.top, .bottom], 8)
                }
            }.task({
                await viewModel.getMovieDetail()
            })
            .background(Color("37_37_42"))
            .frame(maxWidth: .infinity)
        }
        
    }
}

struct MovieDetail_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetail(movieId: 675353)
    }
}
