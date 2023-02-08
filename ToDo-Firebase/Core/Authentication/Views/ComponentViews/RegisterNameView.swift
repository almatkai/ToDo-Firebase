//
//  RegisterNameView.swift
//  ToDo-Firebase
//
//  Created by Almat Kairatov on 22.01.2023.
//

import SwiftUI

struct RegisterNameView: View {
    @Binding var username: String
    @Binding var fullname: String
    
    @Binding var nextButton:Bool
    
    var isValid: Bool {
        return !username.isEmpty && !fullname.isEmpty
    }
    
    var body: some View {
        VStack(spacing: 40){
            AuthTextFieldView(imageName: "person", placeholder: "Full name", text: $fullname)
            AuthTextFieldView(imageName: "person.fill.viewfinder", placeholder: "Username", text: $username)
        }
        .padding(.horizontal, 32)
        .padding(.top, 30)
        Button{
            nextButton = false
        } label: {
            Text("Next")
                .modifier(ClassicButtonModifier(width: .long, isValid: isValid))
        }
        .shadow(color: Color("shadowGray").opacity(0.7), radius: 7, x: 0, y: 0)
        .disabled(!isValid)
    }
}

//struct RegisterNameView_Previews: PreviewProvider {
//    static var previews: some View {
//        RegisterNameView()
//    }
//}
