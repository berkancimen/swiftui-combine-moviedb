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
        UISegmentedControl.appearance().selectedSegmentTintColor = .darkGray
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
    }

    var body: some View {
        VStack {
            HStack(spacing: 0) {
                Text(title)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding()
                    .foregroundColor(.white)
                Picker(selection: $value, label: Text("")) {
                    ForEach(segments, id: \.self) { Text($0.description)
                    }
                }
                .background(Color.clear)
                .pickerStyle(SegmentedPickerStyle())
                .padding(.vertical)
                .padding(.trailing)
                Spacer()
            }
            Divider()
                .background(Color.gray)
                .padding(.horizontal)
        }.background(Color("37_37_42"))
    }
}

struct SegmentedView_Previews: PreviewProvider {
    static var previews: some View {
        SegmentedView(.constant(SortType.date), title: "Sorting:")
    }
}
