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
            NavigationLink(destination: MovieList(service: NetworkManager().service, screenName: .popular)) {
                HomeHeaderView(title: sliderType.getScreenName()).padding([.leading, .trailing], 20)
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack (spacing: 15){
                    ForEach(movies, id: \.id) { item in
                        GeometryReader { proxy in
                            let scale = getScale(proxy: proxy)
                            NavigationLink(destination: MovieDetail(service: NetworkManager().service, movieId: item.id)) {
                                GridMovieCardView(movie: item)
                            }.scaleEffect(.init(width: scale, height: scale))
                                .animation(.easeOut, value: 0.5)
                            
                        }.frame(width: 130, height: 200)
                            .padding(.horizontal, 8)
                            .padding(.top, 26)
                            
                    }
                }.padding([.leading, .trailing], 20)
            }.padding([.bottom], 20)
            Rectangle()
                .frame(height: 1, alignment: .center)
                .foregroundColor(.gray)
                .padding([.leading, .trailing], 120)
        }
    }
    
    func getScale(proxy: GeometryProxy) -> CGFloat {
            let midPoint: CGFloat = 130
             
            let viewFrame = proxy.frame(in: CoordinateSpace.global)
             
            var scale: CGFloat = 1.0
            let deltaXAnimationThreshold: CGFloat = 130
             
            let diffFromCenter = abs(midPoint - viewFrame.origin.x - deltaXAnimationThreshold / 2)
            if diffFromCenter < deltaXAnimationThreshold {
                scale = 1 + (deltaXAnimationThreshold - diffFromCenter) / 500
            }
             
            return scale
        }
    
}

struct HorizontalMovieSliderView_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalMovieSliderView(movies: .constant([MovieViewModel.default]), sliderType: .popular)
    }
}
