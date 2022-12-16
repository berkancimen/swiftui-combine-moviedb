//
//  HomeView.swift
//  OKR1 2022 Movie App
//
//  Created by Berkan Cimen on 24.04.2022.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject private var viewModel: ViewModelHome
    let service: NetworkServiceProtocol
    
    init(service: NetworkServiceProtocol) {
        self.service = service
        _viewModel = ObservedObject(wrappedValue: ViewModelHome(service: service))
    }
    
    var body : some View {
        GeometryReader { g in
            // NavigationView
            NavigationView {
                // ScrollView
                ScrollView {
                    
                    // GENRES
                    VStack(alignment: .leading) {
                        HomeHeaderView(title: "Genres", withArrow: false).padding([.leading, .trailing], 20)
                            .accessibilityIdentifier("GenreHeaderView")
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack (spacing: 15) {
                                ForEach(viewModel.genres, id: \.genreId) { item in
                                    NavigationLink(destination: MovieList(service: service, screenName: .genre(item.genreName, item.genreId))) {
                                        HorizontalSliderCardView(nameAndId: (item.genreName, item.genreId), cardColor: Color.generateRandomColor())
                                    }
                                }
                            }.padding([.leading, .trailing], 20)
                        }.padding([.bottom], 20)
                        Rectangle()
                            .frame(height: 1, alignment: .center)
                            .foregroundColor(.gray)
                            .padding([.leading, .trailing], 120)
                    }.task({
                        fetchGenres()
                    })
                    
                    // POPULAR MOVIES
                    HorizontalMovieSliderView(movies: $viewModel.popularMovies, sliderType: .popular).task({
                        fetchPopularMovies()
                    }).accessibilityIdentifier("PopularMoviesSlider")
                    // Trending MOVIES
                    HorizontalMovieSliderView(movies: $viewModel.trengingMovies, sliderType: .trending).task({
                        fetchTrendingMovies()
                    }).accessibilityIdentifier("TrendingMoviesSlider")
                    
                    // Top Rated MOVIES
                    HorizontalMovieSliderView(movies: $viewModel.topRatedMovies, sliderType: .topRated).task({
                        fetchTopRatedMovies()
                    }).accessibilityIdentifier("TopRatedMoviesSlider")
                    
                }
                .background(Color("37_37_42"))
                .navigationBarTitle("Home", displayMode: .inline)
            }.accentColor(.white)
        }
    }    
}

extension HomeView {
    
    func fetchGenres() {
        viewModel.getGenres()
    }
    
    func fetchTrendingMovies() {
        viewModel.getTrendingMovies()
    }
    
    func fetchTopRatedMovies() {
        viewModel.getTopRatedMovies()
    }
    
    func fetchPopularMovies() {
        viewModel.getPopularMovies()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(service: MockWebService())
    }
}
