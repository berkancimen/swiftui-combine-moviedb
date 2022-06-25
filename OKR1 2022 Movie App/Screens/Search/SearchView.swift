//
//  SearchView.swift
//  OKR1 2022 Movie App
//
//  Created by Berkan Cimen on 9.06.2022.
//

import SwiftUI

struct SearchView: View {
    
    @ObservedObject private var viewModel = SearchViewModel(service: WebServiceFactory.create())
    @State var textFieldText: String = ""
    
    var body: some View {
        
        GeometryReader { g in
            NavigationView {
                VStack {
                    HStack(spacing: 10) {
                        SearchTextField(textFieldText: $textFieldText)
                        CustomButtonView(completion: {
                            viewModel.getMovies(textFieldText)
                        }, title: "Search", backgroundColor: Color(hue: 0.537, saturation: 0.991, brightness: 0.602), cornerRadius: 12, isAnimating: self.$viewModel.activityIndAnimating)
                            .padding(.trailing, 8)
                    }
                    Spacer()
                    MovieListView(movies: $viewModel.filteredMovies) { movie in
                        viewModel.shouldLoadMore(movie: movie)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color("37_37_42"))
                .navigationBarTitle("Search", displayMode: .inline)
            }.accentColor(.white)
        }
    }
    
    struct SearchTextField: View {
        
        @Binding var textFieldText: String
        
        var body: some View {
            TextField("", text: $textFieldText)
                .frame(height: 40)
                .padding(.horizontal, 15)
                .accentColor(.white)
                .modifier(PlaceholderStyle(showPlaceHolder: textFieldText.isEmpty, placeholder: "Search movie"))
                .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                .padding(.leading)
                .padding(.top, 5)
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
