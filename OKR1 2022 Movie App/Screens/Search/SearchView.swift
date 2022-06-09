//
//  SearchView.swift
//  OKR1 2022 Movie App
//
//  Created by Berkan Cimen on 9.06.2022.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject private var viewModel = SearchViewModel(service: WebServiceFactory.create())
    @State var textFieldText: String = ""
    
    
    var body: some View {
        
        GeometryReader { g in
            NavigationView {
                VStack {
                    TextField("Search", text: $textFieldText)
                        .onChange(of: textFieldText) {
                            if $0.count > 3 {
                                viewModel.getMovies($0)
                            }
                        }
                        .frame(height: 40)
                        .padding(.horizontal, 15)
                        .accentColor(.white)
                        .modifier(PlaceholderStyle(showPlaceHolder: textFieldText.isEmpty, placeholder: "Search movie"))
                        .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                        .padding(.horizontal)
                        .padding(.top, 5)
                    Spacer()
                    List(viewModel.filteredMovies, id: \.id) { movie in
                        ZStack {
                            MovieListCardView(movie: movie).onAppear {
                                viewModel.shouldLoadMore(movie: movie)
                            }
                            NavigationLink(destination: MovieDetail(movieId: movie.id)) {
                                EmptyView()
                            }.opacity(0.0)
                        }.listRowBackground(Color.clear)
                    }
                    .background(Color.clear)
                    .listStyle(.plain)
                    .listRowSeparator(.hidden)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color("37_37_42"))
                .navigationBarTitle("Search", displayMode: .inline)
            }.accentColor(.white)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

public struct PlaceholderStyle: ViewModifier {
    var showPlaceHolder: Bool
    var placeholder: String

    public func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            if showPlaceHolder {
                Text(placeholder)
                .padding(.horizontal, 15)
                .foregroundColor(.gray.opacity(0.7))
            }
            content
            .foregroundColor(Color.white)
            
        }
    }
}
