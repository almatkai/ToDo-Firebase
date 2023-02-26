//
//  RandomColor.swift
//  ToDo-Firebase
//
//  Created by Almat Kairatov on 25.02.2023.
//

import SwiftUI

func randomColor() -> Color{
    let thwartedSummerShowerColors = ["FF0000", "00FF00", "0000FF", "FFFF00", "FF00FF", "00FFFF", "C0C0C0", "808080", "800000", "008000", "000080", "808000", "800080", "008080", "7F7F7F"]
    return Color(hex: thwartedSummerShowerColors[Int.random(in: 0...thwartedSummerShowerColors.count - 1)])
}
