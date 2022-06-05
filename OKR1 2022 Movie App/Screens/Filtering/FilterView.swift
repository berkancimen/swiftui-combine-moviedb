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
        
    @State private var selectedSortType: SortType = .date
    @State private var selectedRatingFilter: Ratings = .none
    let completion: FilterCompletion
    
    var body: some View {
        
        VStack {
            // SORT
            SegmentedView($selectedSortType, title: "Sorting")
            // RATING FILTER
            SegmentedView($selectedRatingFilter, title: "Rating")
            Spacer()
            Button {} label: {
                CustomButtonView(completion: {
                    completion(selectedSortType, selectedRatingFilter)
                    presentationMode.wrappedValue.dismiss() 
                }, title: "Filter", backgroundColor: Color.blue, cornerRadius: 12)
            }.padding()
            
        }
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView(completion: { sortType,rating in
            print("")
        })
    }
}
