//
//  RoundedShape.swift
//  ToDo-Firebase
//
//  Created by Almat Kairatov on 07.01.2023.
//

import SwiftUI

struct RoundedShape: Shape {
    var corners: UIRectCorner
    
    var height: CGFloat
    var width: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: width, height: height))
        
        return Path(path.cgPath)
    }
}
