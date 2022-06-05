//
//  SegmentedFilterView.swift
//  OKR1 2022 Movie App
//
//  Created by Berkan Cimen on 9.05.2022.
//

import SwiftUI

protocol SegmentBindable: CaseIterable, CustomStringConvertible, Hashable { }

struct SegmentedView<T>: View where T: SegmentBindable {
    
    let title: String
    @Binding var value: T
    let segments: Array<T>
    
    init(_ binding: Binding<T>, title: String) {
        self.title = title
        self._value = binding
        segments = T.allCases as! Array<T>
    }

    var body: some View {
        HStack() {
            Text(title)
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding()
            Spacer()
        }
        .padding([.top], 1)
        Divider()
        Picker(selection: $value, label: Text("")) {
            ForEach(segments, id: \.self) { Text($0.description)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding([.leading, .trailing], 80)
        .padding([.top], 6)
    }
}

//struct SegmentedFilterView_Previews: PreviewProvider {
//    static var previews: some View {
//        @State private var sortType: SortType = .rating
//        SegmentedFilterView(<#Binding<_>#>, title: <#String#>)
//    }
//}
