//
//  BottomCTAButton.swift
//  Sopetit-iOS
//
//  Created by Minjoo Kim on 1/11/24.
//

import UIKit

class BottomCTAButton: UIButton {
    
    init(title: String) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        setUI()
        setLayout() 
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension BottomCTAButton {
    
    func setUI() {
        self.setTitleColor(.Gray000, for: .normal)
        self.titleLabel?.font = .fontGuide(.body1)
        self.backgroundColor = .SoftieMain1
        self.roundCorners(cornerRadius: 12, maskedCorners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner])
        
    }
    
    func setLayout() {
        self.snp.makeConstraints {
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 40)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 56 / 812)
        }
    }
}
