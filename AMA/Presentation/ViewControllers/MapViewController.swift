//
//  HomeViewController.swift
//  AMA
//
//  Created by DwaeWoo on 2024/04/16.
//

import UIKit
import SnapKit
import NMapsMap
import RxSwift
import RxRelay

final class MapViewController: UIViewController {
    
    //MARK: - Declaration
    var disposeBag = DisposeBag()
    var clusterer: NMCClusterer<ItemKey>?
    let viewModel = MapViewModel()
    var keyTagMap: [ItemKey: NSNull] = [:]
    
    private lazy var mapView = NMFMapView(frame: view.frame)
    private lazy var viewControllerToPresent = SheetPresentationViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = mapView
        
        bindViewModel()
        setMapOption()
    }
}

extension MapViewController {
    
    //MARK: ViewModel
    private func bindViewModel() {
        let input = MapViewModel.Input.init(
            viewDidLoad: .just(())
        )
        
        let output = viewModel.transform(input: input)
        
        output.markerLocation
            .subscribe(onNext: { locations in
                locations.forEach { [weak self] aed in
                    self?.setMapMarker(AED: aed)
//                    self?.setClusterer(AED: aed)
                }
                self.clusterer?.addAll(self.keyTagMap)

                self.clusterer?.mapView = self.mapView
            }).disposed(by: disposeBag)
        
        output.aedInfo.subscribe(onNext: { [weak self] info in
            self?.showMyViewControllerInACustomizedSheet(info: info)
        }).disposed(by: disposeBag)
    }
    
    //MARK: - Function
    private func setClusterer(AED: AEDLocation) {
        let builder = NMCBuilder<ItemKey>()

        builder.minZoom = 4

        guard let lat = Double(AED.location.latitude) else { return }
        guard let lng = Double(AED.location.longitude) else { return }
        
        
        self.clusterer = builder.build()
        
        let newItem = ItemKey(identifier: AED.id, position: NMGLatLng(lat: lat, lng: lng))
        keyTagMap[newItem] = NSNull()
        
        clusterer?.mapView = mapView
    }
    
    private func setMapMarker(AED: AEDLocation) {
        
        guard let lat = Double(AED.location.latitude) else { return }
        guard let lng = Double(AED.location.longitude) else { return }
        
        let marker = NMFMarker()
        
        marker.position = NMGLatLng(lat: lat, lng: lng)
        marker.width = CGFloat(NMF_MARKER_SIZE_AUTO)
        marker.height = CGFloat(NMF_MARKER_SIZE_AUTO)
        
        marker.rx.touchHandler.onNext { [weak self] NMFOverlay in
            self?.viewModel.sender.accept(marker.position)
            return true
        }
        
        marker.mapView = mapView
    }
    
    private func setMapOption() {
        
        mapView.positionMode = .direction
    }
    
    private func showMyViewControllerInACustomizedSheet(info: AEDInfo) {
        
        if let sheet = viewControllerToPresent.sheetPresentationController {
            
            sheet.delegate = self
            
            sheet.detents = [.small(), .medium()]
            
            sheet.selectedDetentIdentifier = .small
            sheet.prefersGrabberVisible = true
        }
        
        viewControllerToPresent.locationDetailInfoView.binding(info: info)
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
