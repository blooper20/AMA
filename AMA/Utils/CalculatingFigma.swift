//
//  CalculatingFigma.swift
//  AMA
//
//  Created by DwaeWoo on 2024/04/02.
//

import UIKit

import Foundation
import UIKit


//MARK: - Declarartion
let screenSize: CGRect = UIScreen.main.bounds

func calculatingWidth(width: CGFloat) -> CGFloat {
    
    let figmaWidth = 390.0
    let screenWidth = screenSize.width
    
    let width = width * screenWidth / figmaWidth
    
    return width
}

func calculatingHeight(height: CGFloat) -> CGFloat {
    
    let figmaHeight = 844.0
    let screenHeight = screenSize.height
    let height = height * screenHeight / figmaHeight
    
    return height
}

