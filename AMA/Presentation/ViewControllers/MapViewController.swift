//
//  HomeViewController.swift
//  AMA
//
//  Created by DwaeWoo on 2024/04/16.
//

import UIKit
import SnapKit
import NMapsMap

final class MapViewController: UIViewController {
    
    //MARK: - Declaration
    private lazy var mapView = NMFMapView(frame: view.frame)
    private lazy var viewControllerToPresent = SheetPresentationViewController()
    
    private lazy var homeView = BottomInfoView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSubViews()
        setMapOption()
        setUIGesture()
    }
}

extension MapViewController {
    
    //MARK: - Function
    private func setSubViews() {
        
        self.view.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.view.addSubview(homeView)
        homeView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(calculatingHeight(height: 150))
        }
    }
    
    private func setMapOption() {
        
        let circleOverlay = NMFCircleOverlay(NMGLatLng(lat: 37.3588564, lng: 127.1052092), radius: 500, fill: .mainColor.withAlphaComponent(0.1))
        circleOverlay.outlineColor = .mainColor
        circleOverlay.outlineWidth = 3
        circleOverlay.mapView = mapView
        mapView.positionMode = .direction
    }
    
    private func setUIGesture() {
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView(_:)))
        
        let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(didTapView(_:)))
        
        swipeGestureRecognizer.direction = .up
        
        self.homeView.addGestureRecognizer(tapGestureRecognizer)
        self.homeView.addGestureRecognizer(swipeGestureRecognizer)
    }
    
    private func showMyViewControllerInACustomizedSheet() {
        
        if let sheet = viewControllerToPresent.sheetPresentationController {
            
            sheet.delegate = self
            
            sheet.detents = [.small(), .medium()]
            
            sheet.selectedDetentIdentifier = .small
            sheet.prefersGrabberVisible = true
        }
        present(viewControllerToPresent, animated: true, completion: nil)
    }
    
    @objc func didTapView(_ sender: UITapGestureRecognizer) {
        showMyViewControllerInACustomizedSheet()
    }
}

//MARK: - Delegate
extension MapViewController: UISheetPresentationControllerDelegate{
    
    func sheetPresentationControllerDidChangeSelectedDetentIdentifier(_ sheetPresentationController: UISheetPresentationController) {
        
        sheetPresentationController.animateChanges {
            
            guard let detentIdentifier = sheetPresentationController.selectedDetentIdentifier else { return }
            
            switch detentIdentifier {
            
            case .medium:
                viewControllerToPresent.locationDetailInfoView.setUpMediumViews()
            
            case .small:
                viewControllerToPresent.locationDetailInfoView.setUpCustomViews()
            
            default:
                break
            }
        }
    }
}
