//
//  CompleteHappyRoutineView.swift
//  Sopetit-iOS
//
//  Created by Minjoo Kim on 1/14/24.
//

import UIKit

import Lottie
import SnapKit

final class CompleteHappyRoutineView: UIView {

    // MARK: - Properties
    
    
    // MARK: - UI Components
    private let cottonLottieView = LottieAnimationView(name: "happy_complete_som")
    private let bearLottieView = LottieAnimationView(name: "brown_eating_happy")
    
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setHierarchy()
        setLayout()
        setAddTarget()
        setRegisterCell()
        setLottieAnimation()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

extension CompleteHappyRoutineView {
    
    func setUI() {
        cottonLottieView.frame = bounds
        cottonLottieView.center = center
        cottonLottieView.contentMode = .scaleToFill
        cottonLottieView.backgroundColor = .clear
        cottonLottieView.translatesAutoresizingMaskIntoConstraints = false
        cottonLottieView.loopMode = .loop
        cottonLottieView.play()
        
        bearLottieView.frame = bounds
        bearLottieView.center = center
        bearLottieView.contentMode = .scaleToFill
        bearLottieView.backgroundColor = .clear
        bearLottieView.translatesAutoresizingMaskIntoConstraints = false
        bearLottieView.loopMode = .loop
        bearLottieView.play()
    }
    
    func setLottieAnimation() {
        
    }
    
    func setHierarchy() {
        self.addSubviews(cottonLottieView, bearLottieView)
    }
    
    func setLayout() {
        cottonLottieView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(420)
        }
        bearLottieView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.equalTo(495)
            $0.height.equalTo(278)
        }
    }
    
    func setAddTarget() {

    }
    
    @objc
    func buttonTapped() {
        
    }
    
    func setRegisterCell() {
        
    }
    
    func setDataBind() {
        
    }
}
