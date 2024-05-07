//
//  UISheetPresentationController.Detent+.swift
//  AMA
//
//  Created by DwaeWoo on 2024/05/07.
//

import UIKit

extension UISheetPresentationController.Detent {
    
    public static func small() -> UISheetPresentationController.Detent {
        .custom(identifier: .small) { context in
            return calculatingHeight(height: 120)
        }
    }
}
