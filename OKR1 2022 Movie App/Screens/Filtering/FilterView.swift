//
//  FilterView.swift
//  OKR1 2022 Movie App
//
//  Created by Berkan Cimen on 4.05.2022.
//

import SwiftUI

enum SortType: String, SegmentBindable {
    
    case date = "Date"
    case rating = "Rating"
    var description: String { "\(self.rawValue)" }
}

typealias FilterCompletion = (_ sortType: SortType, _ rating: Ratings) -> Void

struct FilterView: View {
    
    @Environment(\.presentationMode) var presentationMode
        
    @State var selectedSortType: SortType = .date
    @State var selectedRatingFilter: Ratings = .none
    let completion: FilterCompletion
    
    var body: some View {
        
        VStack {
            HStack {
                Spacer()
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "xmark.circle")
                        .font(.system(size: 25))
                        .foregroundColor(.white)
                }.padding(.trailing, 20)
            }
            
            // SORT
            SegmentedView($selectedSortType, title: "Sort:")
            // RATING FILTER
            SegmentedView($selectedRatingFilter, title: "Rate:")
            Spacer()
            Button {} label: {
                CustomButtonView(completion: {
                    completion(selectedSortType, selectedRatingFilter)
                    presentationMode.wrappedValue.dismiss() 
                }, title: "Apply", backgroundColor: Color.green, cornerRadius: 12, isAnimating: .constant(false))
            }.padding()
        }.background(Color("37_37_42"))
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView(completion: { sortType,rating in
            print("")
        })
    }
}
