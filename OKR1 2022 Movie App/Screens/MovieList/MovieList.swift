//
//  MovieList.swift
//  OKR1 2022 Movie App
//
//  Created by Berkan Cimen on 30.04.2022.
//

import SwiftUI

struct MovieList: View {
    
    @State private var showSheet = false
    
    @ObservedObject private var viewModel: MovieListViewModel
    
    init(service: NetworkServiceProtocol, screenName: ScreenNames) {
        _viewModel = ObservedObject(wrappedValue: MovieListViewModel(service: service, screenName: screenName))
    }
    
    var body: some View {
        
        VStack {
            MovieListView(movies: $viewModel.filteredMovies) { movie in
                viewModel.shouldLoadMore(movie: movie)
            }
        }
        .onAppear(perform: {
            fetchMovieList()
        })
        .background(Color("37_37_42"))
        .navigationTitle(viewModel.screenName)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showSheet.toggle()
                } label: {
                    Image(systemName: "line.3.horizontal.decrease.circle")
                }.fullScreenCover(isPresented: $showSheet) {
                    FilterView(selectedSortType: viewModel.filterOptions.1 ?? .date, selectedRatingFilter: viewModel.filterOptions.0 ?? .none) { sortType, rating in
                        viewModel.filterMovie(rating: rating, sort: sortType)
                    }
                }
            }
        } 
    }
    
}

extension MovieList {
    
    func fetchMovieList() {
        viewModel.getMovies()
    }
}

struct MovieList_Previews: PreviewProvider {
    static var previews: some View {
        MovieList(service: MockWebService(), screenName: .popular)
    }
}
