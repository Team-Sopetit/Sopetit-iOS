//
//  DailyRoutineEmptyView.swift
//  Sopetit-iOS
//
//  Created by Minjoo Kim on 1/29/24.
//

import UIKit

import SnapKit

protocol AddDailyRoutineDelegate: AnyObject {
    func addDaily()
}

final class DailyRoutineEmptyView: UICollectionReusableView, UICollectionFooterViewRegisterable {
    
    // MARK: - Properties
    
    static var isFromNib: Bool = false
    weak var delegate: AddDailyRoutineDelegate?
    
    // MARK: - UI Componenets
    
    private let plusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.DailyRoutine.icAdd
        imageView.contentMode = .scaleAspectFit
        return imageView
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

private extension DailyRoutineEmptyView {
    
    func setUI() {
        self.addSubview(plusImageView)
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
        
        plusImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
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
        delegate?.addDaily()
    }
}
