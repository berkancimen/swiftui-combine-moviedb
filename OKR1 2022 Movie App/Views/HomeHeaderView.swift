//
//  HomeHeaderView.swift
//  OKR1 2022 Movie App
//
//  Created by Berkan Cimen on 24.04.2022.
//

import SwiftUI

struct HomeHeaderView: View {
    
    var title : String
    
    
    var body: some View {
        
        HStack(){
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
                .foregroundColor(.white)
            Spacer()
            Image("chevronRight")
                .resizable()
                .foregroundColor(.white)
                .frame(width: 10, height: 15)
        }.frame(height : 50)
    }
}

struct MainPageTitleHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HomeHeaderView(title: "Categories").previewLayout(.sizeThatFits)
    }
}
