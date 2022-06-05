//
//  HomeView.swift
//  OKR1 2022 Movie App
//
//  Created by Berkan Cimen on 24.04.2022.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var viewModel = ViewModelHome(service: WebServiceFactory.create())
    
    var body : some View {
        GeometryReader { g in
            // NavigationView
            NavigationView {
                // ScrollView
                ScrollView {
                    
                    // GENRES
                    VStack(alignment: .leading) {
                        HomeHeaderView(title: "Genres").padding([.leading, .trailing], 20)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack (spacing: 15) {
                                ForEach(viewModel.genres, id: \.genreId) { item in
                                    HorizontalSliderCardView(nameAndId: (item.genreName, item.genreId))
                                }
                            }.padding([.leading, .trailing], 20)
                        }.padding([.bottom], 20)
                        Rectangle()
                            .frame(height: 1, alignment: .center)
                            .foregroundColor(.gray)
                            .padding([.leading, .trailing], 120)
                    }.task({
                        await viewModel.getGenres()
                    })
                    
                    // POPULAR MOVIES
                    VStack(alignment: .leading) {
                        NavigationLink(destination: MovieList(endPoint: .popular)) {
                            HomeHeaderView(title: "Popular").padding([.leading, .trailing], 20)
                        }
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack (spacing: 15){
                                ForEach(viewModel.popularMovies, id: \.id) { item in
                                    GridMovieCardView(movie: item)
                                }
                            }.padding([.leading, .trailing], 20)
                        }.padding([.bottom], 20)
                        Rectangle()
                            .frame(height: 1, alignment: .center)
                            .foregroundColor(.gray)
                            .padding([.leading, .trailing], 120)
                    }.task({
                        await viewModel.getPopularMovies()
                    })
                    
                    // Trending MOVIES
                    VStack(alignment: .leading) {
                        NavigationLink(destination: MovieList(endPoint: .trending)) {
                            HomeHeaderView(title: "Trending").padding([.leading, .trailing], 20)
                        }
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack (spacing: 15){
                                ForEach(viewModel.trengingMovies, id: \.id) { item in
                                    GridMovieCardView(movie: item)
                                }
                            }.padding([.leading, .trailing], 20)
                        }.padding([.bottom], 20)
                        Rectangle()
                            .frame(height: 1, alignment: .center)
                            .foregroundColor(.gray)
                            .padding([.leading, .trailing], 120)
                    }.task({
                        await viewModel.getTrendingMovies()
                    })
                    
                    // Top Rated MOVIES
                    VStack(alignment: .leading) {
                        NavigationLink(destination: MovieList(endPoint: .topRated)) {
                            HomeHeaderView(title: "Top Rated").padding([.leading, .trailing], 20)
                        }
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack (spacing: 15){
                                ForEach(viewModel.topRatedMovies, id: \.id) { item in
                                    GridMovieCardView(movie: item)
                                }
                            }.padding([.leading, .trailing], 20)
                        }.padding([.bottom], 20)
                        Rectangle()
                            .frame(height: 1, alignment: .center)
                            .foregroundColor(.gray)
                            .padding([.leading, .trailing], 120)
                    }.task({
                        await viewModel.getTopRatedMovies()
                    })
                    
                }
                .background(Color("37_37_42"))
                .navigationBarTitle("", displayMode: .inline)
            }.accentColor(.white)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
