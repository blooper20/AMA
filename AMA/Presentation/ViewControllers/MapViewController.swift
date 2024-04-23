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
//            make.top.equalTo(mapView.snp.bottom)
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
        let viewControllerToPresent = SheetPresentationViewController()
        
        
        if let sheet = viewControllerToPresent.sheetPresentationController {
            
            sheet.delegate = self
            sheet.detents = [.medium()]
            sheet.selectedDetentIdentifier = .medium
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 0
        }
        present(viewControllerToPresent, animated: true, completion: nil)
    }
    
    private func reducingMap() {
        
        //FIXME: - Animation 필요
        self.mapView.snp.remakeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview().inset(self.view.frame.height/2)
        }
    }
    
    private func recoveringMap() {
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut, animations: {
            
            self.mapView.snp.remakeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            self.homeView.snp.remakeConstraints { make in
                make.horizontalEdges.bottom.equalToSuperview()
                make.bottom.equalToSuperview()
                make.height.equalTo(calculatingHeight(height: 150))
            }
            
            self.view.layoutIfNeeded()
            
        }, completion: nil)
    }
    
    @objc func didTapView(_ sender: UITapGestureRecognizer) {
        showMyViewControllerInACustomizedSheet()
        reducingMap()
    }
}

//MARK: - Delegate
extension MapViewController: UISheetPresentationControllerDelegate{
    
    func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
        recoveringMap()
    }
}
