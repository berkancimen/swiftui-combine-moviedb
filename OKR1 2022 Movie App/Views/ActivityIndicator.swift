//
//  ActivityIndicator.swift
//  OKR1 2022 Movie App
//
//  Created by Berkan Cimen on 10.06.2022.
//

import Foundation
import SwiftUI

struct ActivityIndicator: UIViewRepresentable {
    
    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style
    
    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        if !isAnimating {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                uiView.stopAnimating()
            }
        } else {
            uiView.startAnimating()
        }
    }
    
}
