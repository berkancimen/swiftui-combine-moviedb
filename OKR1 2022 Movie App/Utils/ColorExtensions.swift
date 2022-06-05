//
//  ColorExtensions.swift
//  OKR1 2022 Movie App
//
//  Created by Berkan Cimen on 24.04.2022.
//

import SwiftUI

extension Color {
    
    static func generateRandomColor() -> Color {
        
        var hue : Double = Double(arc4random() % 256) / 256 // use 256 to get full range from 0.0 to 1.0
        if hue == 0.0 {
            hue = Double(arc4random() % 256) / 256
        }
        let saturation : Double = Double(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from white
        let brightness : Double = Double(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from black
        
        return Color(hue: hue, saturation: saturation, brightness: brightness)
    }
    
}
