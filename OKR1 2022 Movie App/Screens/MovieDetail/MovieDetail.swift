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
    
    init(service: NetworkServiceProtocol, movieId: Int) {
        _viewModel = StateObject(wrappedValue: MovieDetailViewModel(service: service, movieId: movieId))
    }
    
    let columns = [
            GridItem(.adaptive(minimum: 100))
        ]
    
    var body: some View {
        
        GeometryReader { mainView in
            
            ScrollView(.vertical) {
                VStack {
                    
                    WebImage(url: URL(string: viewModel.movieDetail.imageUrl))
                        .onSuccess { image, data, cacheType in
                        }
                        .resizable()
                        
                        .transition(.fade(duration: 0.5))
                        .frame(maxWidth: .infinity)
                        .aspectRatio(10/15, contentMode: .fill)
                    VStack(alignment: .leading) {
                        Text(viewModel.movieDetail.name)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.center)
                            .padding([.top, .bottom], 8)
                            .padding(.horizontal, 22)
                    }
                           
                    Group {
                        VStack(alignment: .leading) {
                            HStack(spacing: 0) {
                                Text(viewModel.movieDetail.releaseDate)
                                    .fontWeight(.medium)
                                    .foregroundColor(Color.gray)
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(1)
                                Spacer()
                                Image("starIcon")
                                    .frame(width: 30, height: 30)
                                Text(viewModel.movieDetail.ratingString)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color(red: 1.0, green: 0.757, blue: 0.027))
                                    .lineLimit(1)
                                    .frame(width: 30, height: 30)
                                    
                            }
                                .padding(.horizontal, 22)
                                .padding(.bottom, 8)
                            Text(viewModel.movieDetail.overview)
                                .fontWeight(.medium)
                                .foregroundColor(Color.white)
                                .multilineTextAlignment(.leading)
                                .padding(.leading, 22)
                                .padding(.trailing, 8)
                                .padding(.bottom, 10)
                            
                            HStack(spacing: 0) {
                                Text("Language: ")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(red: 1.0, green: 0.757, blue: 0.027))
                                    .multilineTextAlignment(.leading)
                                Text(viewModel.movieDetail.originalLanguage?.uppercased() ?? "")
                                    .fontWeight(.medium)
                                    .foregroundColor(Color.white)
                                    .multilineTextAlignment(.leading)
                            }
                                .padding(.leading, 22)
                                .padding(.trailing, 8)
                                .padding(.bottom, 6)
                            
                            HStack(spacing: 0) {
                                Text("Duration: ")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(red: 1.0, green: 0.757, blue: 0.027))
                                    .multilineTextAlignment(.leading)
                                Text(viewModel.movieDetail.duration)
                                    .fontWeight(.medium)
                                    .foregroundColor(Color.white)
                                    .multilineTextAlignment(.leading)
                            }
                                .padding(.leading, 22)
                                .padding(.trailing, 8)
                                .padding(.bottom, 6)
                            
                            HStack(spacing: 0) {
                                Text("Revenue: ")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(red: 1.0, green: 0.757, blue: 0.027))
                                    .multilineTextAlignment(.leading)
                                Text(viewModel.movieDetail.revenue)
                                    .fontWeight(.medium)
                                    .foregroundColor(Color.white)
                                    .multilineTextAlignment(.leading)
                            }
                                .padding(.leading, 22)
                                .padding(.trailing, 8)
                                .padding(.bottom, 10)
                            
                            
                            LazyVGrid(columns: columns, spacing: 10) {
                                ForEach(viewModel.movieDetail.genres ?? [], id: \.id) { item in
                                    HorizontalSliderCardView(nameAndId: (item.name, item.id), cardColor: Color.generateRandomColor(), frame: (width: 120, height: 40))
                                }
                            }
                            .padding(.horizontal)
                            .padding(.bottom, 20)

                        }
                    }
                }
                
            }
            .background(Color("37_37_42"))
            .frame(maxWidth: .infinity)
            .navigationTitle(viewModel.movieDetail.name)
            .task({
                viewModel.getMovieDetail()
            })
        }
        
    }
}

struct MovieDetail_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetail(service: MockWebService(), movieId: 675353)
    }
}
