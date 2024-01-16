//
//  DailyFooterView.swift
//  Sopetit-iOS
//
//  Created by Woo Jye Lee on 1/10/24.
//

import UIKit

import SnapKit

protocol DailyAddDelegate: AnyObject {
    func addTapped()
}

final class DailyFooterView: UICollectionReusableView, UICollectionFooterViewRegisterable {
    
    // MARK: - Properties
    
    static var isFromNib: Bool = false
    weak var addDelegate: DailyAddDelegate?
    
    // MARK: - UI Componenets
    
    private let plusImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "ic_add")
        image.tintColor = .Gray200
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let borderLayer = CAShapeLayer()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setLayout()
        layoutSubviews()
        setAddTarget()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let customSize = CGSize(width: (SizeLiterals.Screen.screenWidth - 40), height: 136)
        let customRect = CGRect(origin: CGPoint(x: (rect.width - customSize.width) / 2, y: (rect.height - customSize.height) / 2),
                                size: customSize)
        
        borderLayer.path = UIBezierPath(roundedRect: customRect, cornerRadius: 20).cgPath
    }
    
    override func layoutSubviews() {
        layer.addSublayer(borderLayer)
    }
}

extension DailyFooterView {
    
    func setUI() {
        self.addSubview(plusImage)
        borderLayer.strokeColor = UIColor.Gray300.cgColor
        borderLayer.lineDashPattern = [3, 3]
        borderLayer.backgroundColor = UIColor.clear.cgColor
        borderLayer.fillColor = UIColor.clear.cgColor
        translatesAutoresizingMaskIntoConstraints = true
    }
    
    func setLayout() {
        self.snp.makeConstraints {
            $0.height.equalTo(136)
        }
        
        plusImage.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.size.equalTo(24)
        }
    }
    
    func setAddTarget() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleFooterTap))
        self.addGestureRecognizer(tapGesture)
        self.isUserInteractionEnabled = true
    }
    
    @objc
    func handleFooterTap() {
        addDelegate?.addTapped()
    }
}
