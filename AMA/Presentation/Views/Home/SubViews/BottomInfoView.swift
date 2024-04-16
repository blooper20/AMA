//
//  BottomInfoView.swift
//  AMA
//
//  Created by DwaeWoo on 2024/04/16.
//

import UIKit
import SnapKit

final class BottomInfoView: UIView {
    
    //MARK: - Declaration
    private lazy var aedPositionLabel: UILabel = {
        let label = UILabel()
        label.font = .mainTitle
        label.sizeToFit()
        
        return label
    }()
    
    private lazy var aedAddressLabel: UILabel = {
        let label = UILabel()
        label.font = .subTitle
        label.sizeToFit()
        
        return label
    }()
    
    private lazy var directionButton: UIButton = {
        let button = UIButton()
        
        return button
    }()
    
    //MARK: - Initialize
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            setUpSubViews()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
}

extension BottomInfoView {
    
    //MARK: - Function
    private func setUpSubViews() {
        
        self.addSubview(aedPositionLabel)
        aedPositionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(calculatingHeight(height: 22))
            make.left.equalToSuperview().inset(calculatingWidth(width: 22))
        }
        
        self.addSubview(aedAddressLabel)
        aedAddressLabel.snp.makeConstraints { make in
            make.top.equalTo(aedPositionLabel).inset(calculatingHeight(height: 22))
            make.left.equalToSuperview().inset(calculatingWidth(width: 22))
            make.bottom.equalToSuperview().offset(calculatingHeight(height: 22))
        }
        
        self.addSubview(directionButton)
        directionButton.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(calculatingHeight(height: 22))
            make.right.equalToSuperview().inset(calculatingWidth(width: 22))
        }
    }
    
    func binding(position: String, address: String, distance: String) {
        aedPositionLabel.text = position
        aedAddressLabel.text = address
        directionButton.titleLabel?.text = distance
    }
    
}
