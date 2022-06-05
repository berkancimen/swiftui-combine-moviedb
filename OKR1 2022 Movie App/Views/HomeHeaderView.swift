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
        Button(action: {
            print("button tapped")
        })  {
            HStack(){
                Text(title)
                    .font(.title)
                    .padding(.leading, 40)
                    .lineLimit(2)
                    .foregroundColor(.white)
                Spacer()
            }.frame(height : 50)
        }
    }
}

struct MainPageTitleHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HomeHeaderView(title: "Categories").previewLayout(.sizeThatFits)
    }
}
