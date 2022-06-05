//
//  FilterBannerView.swift
//  OKR1 2022 Movie App
//
//  Created by Berkan Cimen on 30.04.2022.
//

import SwiftUI

struct CustomButtonView: View {
    
    let completion: (() -> Void)?
    let title: String
    let backgroundColor: Color
    let cornerRadius: CGFloat
    
    var body: some View {
        Button {
            completion?()
        } label: { Text(title).fontWeight(.semibold) }
        .padding()
        .foregroundColor(.white)
        .background(backgroundColor)
        .cornerRadius(cornerRadius)
    }
}

struct FilterButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CustomButtonView(completion: nil, title: "Gender", backgroundColor: Color.red, cornerRadius: 12)
    }
}
