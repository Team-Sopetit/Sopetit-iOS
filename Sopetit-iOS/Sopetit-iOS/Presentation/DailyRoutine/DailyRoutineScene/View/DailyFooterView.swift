//
//  DailyFooterView.swift
//  Sopetit-iOS
//
//  Created by Woo Jye Lee on 1/10/24.
//

import UIKit
import SnapKit

class DailyFooterView: UICollectionReusableView, UICollectionFooterViewRegisterable {
    
    // MARK: - Properties
    
    static var isFromNib: Bool = false
    static let identifier: String = "DailyFooterView"
    
    // MARK: - UI Componenets
    
    let plusImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "plus")
        image.tintColor = .Gray200
        return image
    }()
    
    private let borderLayer = CAShapeLayer()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setLayout()
        borderLayer.strokeColor = UIColor.Gray300.cgColor
        borderLayer.lineDashPattern = [3, 3]
        borderLayer.backgroundColor = UIColor.clear.cgColor
        borderLayer.fillColor = UIColor.clear.cgColor
        
        layer.addSublayer(borderLayer)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let customSize = CGSize(width: (UIScreen.main.bounds.width-40), height: 136)
        let customRect = CGRect(origin: CGPoint(x: (rect.width - customSize.width) / 2, y: (rect.height - customSize.height) / 2),
                                size: customSize)
        
        borderLayer.path = UIBezierPath(roundedRect: customRect, cornerRadius: 20).cgPath
    }
    
    func setUI() {
        self.addSubview(plusImage)
    }
    
    func setLayout() {
        self.snp.makeConstraints {
            $0.height.equalTo(136)
//            $0.width.equalTo(UIScreen.main.bounds.width-40).priority(.high)
        }
        
        plusImage.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.size.equalTo(24)
        }
        
    }
}
