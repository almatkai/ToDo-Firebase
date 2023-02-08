//
//  Modifier.swift
//  ToDo-Firebase
//
//  Created by Almat Kairatov on 22.01.2023.
//

import Foundation
import SwiftUI

struct TranstitionMoveModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .transition(.move(edge: .leading))
            .animation(.easeOut(duration: 0.5))
    }
}

enum TypeByWidth: String, CaseIterable {
    case long = "long"
    case short = "short"
}
struct ClassicButtonModifier: ViewModifier {
    var customWidth:CGFloat?
    var width:TypeByWidth?
    var isValid:Bool? = true
    var buttonColor: Color {
        return isValid ?? true ? Color("skyBlue") : .gray
    }
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.white)
            .frame(width: customWidth == nil ? (width == .long ? 340 : 150) : customWidth , height: 55)
            .background(buttonColor)
            .clipShape(Capsule())
            .padding(5)
            .padding(.top, 15)
    }
}
