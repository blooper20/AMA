//
//  HomeViewController.swift
//  AMA
//
//  Created by DwaeWoo on 2024/04/16.
//

import UIKit
import SnapKit
import NMapsMap

final class HomeViewController: UIViewController {
    
    //MARK: - Declaration
    private lazy var mapView = NMFMapView(frame: view.frame)
    private lazy var homeView: BottomInfoView = {
        let view = BottomInfoView()
        view.layer.shadowOffset = CGSize(width: 0, height: -2)
        view.layer.shadowOpacity = 0.3
        view.layer.shadowRadius = 10
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSubViews()
        setMapOption()
    }
}

extension HomeViewController {
    
    //MARK: - Function
    private func setSubViews() {
        
        self.view.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
        }
        
        self.view.addSubview(homeView)
        homeView.snp.makeConstraints { make in
            make.top.equalTo(mapView.snp.bottom)
            make.horizontalEdges.bottom.equalToSuperview()
            make.height.equalTo(calculatingHeight(height: 150))
        }
    }
    
    private func setMapOption() {
        
        let circleOverlay = NMFCircleOverlay(NMGLatLng(lat: 37.3588564, lng: 127.1052092), radius: 500, fill: .red)
        circleOverlay.outlineColor = .blue
        circleOverlay.outlineWidth = 3
        circleOverlay.mapView = mapView
        mapView.positionMode = .direction
        
        
    }
}
