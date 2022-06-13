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
    let titleColor: Color = .white
    let backgroundColor: Color
    let cornerRadius: CGFloat
    let height: CGFloat = 10
    @Binding var isAnimating: Bool
    
    var body: some View {
        Button {
            completion?()
        } label: {
            if isAnimating {
                ActivityIndicator(isAnimating: $isAnimating, style: .medium)
                    .frame(height: height)
            } else {
                Text(title).fontWeight(.semibold)
                    .frame(height: height)
            }
        }
        .padding()
        .foregroundColor(titleColor)
        .background(backgroundColor)
        .cornerRadius(cornerRadius)
    }
}

struct FilterButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CustomButtonView(completion: nil, title: "Gender", backgroundColor: Color.red, cornerRadius: 12, isAnimating: .constant(true))
    }
}
