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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = mapView
        
        setMapOption()
        setMapMarker()
    }
}

extension MapViewController {
    
    //MARK: - Function
    private func setMapMarker() {
        let marker = NMFMarker()
        marker.position = NMGLatLng(lat: 37.3588564, lng: 127.1052092)
        marker.width = CGFloat(NMF_MARKER_SIZE_AUTO)
        marker.height = CGFloat(NMF_MARKER_SIZE_AUTO)
        
        let handler = { [weak self] (overlay: NMFOverlay) -> Bool in
            self?.showMyViewControllerInACustomizedSheet()
            
            return true
        }
        
        marker.touchHandler = handler
        
        marker.mapView = mapView
    }
    
    private func setMapOption() {
        
        let circleOverlay = NMFCircleOverlay(NMGLatLng(lat: 37.3588564, lng: 127.1052092), radius: 500, fill: .mainColor.withAlphaComponent(0.1))
        
        circleOverlay.outlineColor = .mainColor
        circleOverlay.outlineWidth = 3
        circleOverlay.mapView = mapView
        
        mapView.positionMode = .direction
    }
    
    private func showMyViewControllerInACustomizedSheet() {
        
        if let sheet = viewControllerToPresent.sheetPresentationController {
            
            sheet.delegate = self
            
            sheet.detents = [.small(), .medium()]
            
            sheet.selectedDetentIdentifier = .small
            sheet.prefersGrabberVisible = true
        }
        
        viewControllerToPresent.locationDetailInfoView.removeSubviews()
        viewControllerToPresent.locationDetailInfoView.setUpCustomViews()
        
        present(viewControllerToPresent, animated: true)
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
                viewControllerToPresent.locationDetailInfoView.removeSubviews()
                viewControllerToPresent.locationDetailInfoView.setUpCustomViews()
            
            default:
                break
            }
        }
    }
}
