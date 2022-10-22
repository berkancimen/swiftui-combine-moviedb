//
//  MovieListView.swift
//  OKR1 2022 Movie App
//
//  Created by Berkan Cimen on 10.06.2022.
//

import SwiftUI

struct MovieListView: View {
    
    @Binding var movies: [MovieViewModel]
    var onAppearCompletion: ((MovieViewModel) -> Void)?
    
    var body: some View {
        List(movies, id: \.id) { movie in
            ZStack {
                MovieListCardView(movie: movie).onAppear {
                    onAppearCompletion?(movie)
                }
                NavigationLink(destination: MovieDetail(service: NetworkManager().service, movieId: movie.id)) {
                    EmptyView()
                }.opacity(0.0)
            }.listRowBackground(Color("37_37_42"))
        }
        .background(Color.black)
        .listStyle(.plain)
        .listRowSeparator(.hidden)
    }
}

struct MovieListView_Previews: PreviewProvider {
    @State static var movies = [MovieViewModel.default]
    static var previews: some View {
        MovieListView(movies: $movies)
    }
}
