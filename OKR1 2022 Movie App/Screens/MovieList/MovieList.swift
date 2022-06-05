//
//  MovieList.swift
//  OKR1 2022 Movie App
//
//  Created by Berkan Cimen on 30.04.2022.
//

import SwiftUI

struct MovieList: View {
    
    @State private var showSheet = false
    
    @StateObject private var viewModel: MovieListViewModel
    
    init(endPoint: EndPoints) {
        _viewModel = StateObject(wrappedValue: MovieListViewModel(service: WebServiceFactory.create(), endPoint: endPoint))
    }
    
    var body: some View {
        
        VStack {
            ZStack(alignment: .bottomTrailing) {
                CustomButtonView(completion: {
                    showSheet.toggle()
                }, title: "Filter", backgroundColor: .blue, cornerRadius: 12)
                    .frame(height: 40)
                    .fullScreenCover(isPresented: $showSheet) {
                        FilterView(completion: { (sortType,rating) in
                            viewModel.filterMovie(rating: rating, sort: sortType)
                        })
                    }.padding()
                    .zIndex(1)
                
                List(viewModel.filteredMovies, id: \.id) { movie in
                    MovieListCardView(movie: movie).onAppear {
                        viewModel.shouldLoadMore(movie: movie)
                    }                    
                }
                .listStyle(.plain)
                .listRowSeparator(.hidden)
            }
        }.task({
            await viewModel.getMovies()
        })
        .background(Color("37_37_42"))
    }
    
}

struct MovieList_Previews: PreviewProvider {
    static var previews: some View {
        MovieList(endPoint: .topRated)
    }
}
