//
//  CompleteDailyRoutineView.swift
//  Sopetit-iOS
//
//  Created by Minjoo Kim on 1/15/24.
//

import UIKit

import Lottie
import SnapKit

enum BearType {
    case brown, red, panda, gray
    
    var dailyCompleteBear: UIImage {
        switch self {
        case .brown:
            return ImageLiterals.DailyRoutineComplete.imgBearDailyCompleteBrown
        case .red:
            return ImageLiterals.DailyRoutineComplete.imgBearDailyCompleteRed
        case .panda:
            return ImageLiterals.DailyRoutineComplete.imgBearDailyCompletePanda
        case .gray:
            return ImageLiterals.DailyRoutineComplete.imgBearDailyCompleteGray
        }
    }
    
    var happyCompleteBear: UIImage {
        switch self {
        case .brown:
            return ImageLiterals.HappyRoutineComplete.imgHappyBearBrown
        case .red:
            return ImageLiterals.HappyRoutineComplete.imgHappyBearRed
        case .panda:
            return ImageLiterals.HappyRoutineComplete.imgHappyBearPanda
        case .gray:
            return ImageLiterals.HappyRoutineComplete.imgHappyBearGray
        }
    }
}

final class CompleteDailyRoutineView: UIView {

    // MARK: - UI Components
    
    let cottonLottieView = LottieAnimationView(name: "daily_complete_som")
    private let bearImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = BearType.brown.dailyCompleteBear
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.DailyRoutine.completeDailyRoutine
        label.font = .fontGuide(.head1)
        label.textColor = .Gray700
        label.textAlignment = .center
        return label
    }()
    
    let cottonLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.DailyRoutine.getCotton
        label.font = .fontGuide(.body2)
        label.textColor = .Gray500
        label.roundCorners(cornerRadius: 8, maskedCorners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner])
        label.backgroundColor = .Gray100
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setHierarchy()
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

private extension CompleteDailyRoutineView {
    
    func setUI() {
        self.backgroundColor = .SoftieBack
    
        cottonLottieView.loopMode = .loop
        cottonLottieView.contentMode = .scaleAspectFit
        cottonLottieView.frame = self.bounds
        cottonLottieView.backgroundColor = .clear
        textLabel.alpha = 0
        cottonLabel.alpha = 0
    }
    
    func setHierarchy() {
        self.addSubviews(bearImageView, textLabel, cottonLabel, cottonLottieView)
    }
    
    func setLayout() {
        cottonLottieView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(420)
        }
        
        bearImageView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.equalTo(288)
            $0.height.equalTo(198)
        }
        
        textLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(71)
            $0.horizontalEdges.equalToSuperview().inset(30)
        }
        
        cottonLabel.snp.makeConstraints {
            $0.top.equalTo(textLabel.snp.bottom).offset(18)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(118)
            $0.height.equalTo(39)
        }
    }
}
