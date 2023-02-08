//
//  AuthTextFieldView.swift
//  ToDo-Firebase
//
//  Created by Almat Kairatov on 17.01.2023.
//

import SwiftUI

struct AuthTextFieldView: View {
    let imageName: String
    let placeholder: String 
    @Binding var text: String
    
    var isSecureField:Bool? = false
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color("forgroundGray"))
                if (isSecureField ?? false){
                    SecureField(placeholder, text: $text)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                }else{
                    TextField(placeholder, text: $text)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                }
            }
            .padding(.bottom)
            Divider()
        }.transition(.push(from: .trailing))
    }
}
