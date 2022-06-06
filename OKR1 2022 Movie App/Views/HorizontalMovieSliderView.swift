//
//  HorizontalMovieSliderView.swift
//  OKR1 2022 Movie App
//
//  Created by Berkan Cimen on 6.06.2022.
//

import SwiftUI

struct HorizontalMovieSliderView: View {
    
    @Binding var movies: [MovieViewModel]
    let sliderType: ScreenNames
    
    var body: some View {
        
        VStack(alignment: .leading) {
            NavigationLink(destination: MovieList(screenName: .popular)) {
                HomeHeaderView(title: sliderType.getScreenName()).padding([.leading, .trailing], 20)
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack (spacing: 15){
                    ForEach(movies, id: \.id) { item in
                        NavigationLink(destination: MovieDetail(movieId: item.id)) {
                            GridMovieCardView(movie: item)
                        }
                    }
                }.padding([.leading, .trailing], 20)
            }.padding([.bottom], 20)
            Rectangle()
                .frame(height: 1, alignment: .center)
                .foregroundColor(.gray)
                .padding([.leading, .trailing], 120)
        }
    }
}

//struct HorizontalMovieSliderView_Previews: PreviewProvider {
//    static var previews: some View {
//        HorizontalMovieSliderView(movies: Binding[MovieViewModel.default], sliderType: .popular)
//    }
//}
