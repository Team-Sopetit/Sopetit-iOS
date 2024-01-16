//
//  BottomCTAButton.swift
//  Sopetit-iOS
//
//  Created by Minjoo Kim on 1/11/24.
//

import UIKit

enum BottomCTAButtonType {
    case normal, red
}

class BottomCTAButton: UIButton {
    
    private var titleString: String
    var type: BottomCTAButtonType = .normal {
        didSet {
            switch type {
            case .normal:
                self.backgroundColor = .SoftieMain1
            case .red:
                self.backgroundColor = .SoftieRed
            }
        }
    }
    
    init(title: String) {
        self.titleString = title
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.backgroundColor = .SoftieMain1
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
        self.roundCorners(cornerRadius: 12, maskedCorners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner])
        
    }
    
    func setLayout() {
        self.snp.makeConstraints {
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 40)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 56 / 812)
        }
    }
}

extension BottomCTAButton {
    
    func setRedDeleteButton(title: String) {
        self.setTitle(title, for: .normal)
        self.type = .red
    }
    
    func setNormalButton() {
        self.setTitle(titleString, for: .normal)
        self.type = .normal
    }
}
