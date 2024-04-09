//
//  ViewController.swift
//  AMA
//
//  Created by DwaeWoo on 2024/04/02.
//

import UIKit
import NMapsMap

class ViewController: UIViewController {
    
    override func loadView() {
        super.loadView()
        
        view = NMFMapView(frame: view.frame)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
