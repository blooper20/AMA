//
//  SheetPresentationViewController.swift
//  AMA
//
//  Created by DwaeWoo on 2024/04/23.
//

import UIKit

final class SheetPresentationViewController: UIViewController {
    
    private lazy var locationDetailInfoView = LocationDetailInfoView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = locationDetailInfoView
    }
}
