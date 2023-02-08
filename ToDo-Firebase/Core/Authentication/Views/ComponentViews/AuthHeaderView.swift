//
//  AuthHeaderView.swift
//  ToDo-Firebase
//
//  Created by Almat Kairatov on 08.01.2023.
//

import SwiftUI

struct AuthHeaderView: View {
    @State var title1: String
    @State var title2: String
    var body: some View {
        VStack(alignment: .leading){
            HStack{ Spacer() }
            Text(title1)
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            Text(title2)
                .font(.largeTitle)
                .fontWeight(.semibold)
        }
        .frame(height: 242)
        .padding(.leading)
        .background(Color("skyBlue"))
        .foregroundColor(.white)
        .clipShape(RoundedShape(corners: [.bottomRight, .bottomLeft], height: 40, width: 40))
        .shadow(color: Color("shadowGray").opacity(0.9), radius: 10, x: 0, y: 0)
    }
}
