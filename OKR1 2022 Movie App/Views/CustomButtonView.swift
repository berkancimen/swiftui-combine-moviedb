//
//  FilterBannerView.swift
//  OKR1 2022 Movie App
//
//  Created by Berkan Cimen on 30.04.2022.
//

import SwiftUI

struct CustomButtonView: View {
    
    let completion: (() -> Void)?
    let filterName: String
    
    var body: some View {
        Button {
            completion?()
        } label: { Text(filterName).fontWeight(.semibold) }
        .padding()
        .foregroundColor(.white)
        .background(Color.blue)
        .cornerRadius(12)
    }
}

struct FilterButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CustomButtonView(completion: nil, filterName: "Gender")
    }
}
