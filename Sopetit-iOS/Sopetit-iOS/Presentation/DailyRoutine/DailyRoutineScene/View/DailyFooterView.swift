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
        borderLayer.strokeColor = UIColor.Gray200.cgColor
        borderLayer.lineDashPattern = [3, 3]
        borderLayer.backgroundColor = UIColor.clear.cgColor
        borderLayer.fillColor = UIColor.clear.cgColor
        
        layer.addSublayer(borderLayer)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        
        borderLayer.path = UIBezierPath(roundedRect: rect, cornerRadius: 20).cgPath
    }
    
    func setUI() {
        self.addSubview(plusImage)
        self.backgroundColor = .red
    }
    
    func setLayout() {
        self.snp.makeConstraints {
            $0.height.equalTo(136)
//            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        plusImage.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.size.equalTo(24)
        }
    }
}
