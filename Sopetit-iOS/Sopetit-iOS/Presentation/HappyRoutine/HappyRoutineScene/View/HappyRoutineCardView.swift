//
//  HappyRoutineCardView.swift
//  Sopetit-iOS
//
//  Created by Minjoo Kim on 1/11/24.
//

import UIKit

import SnapKit

final class HappyRoutineCardView: UIView {

    // MARK: - UI Components
    
    private let cardView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let cardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let detailTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .fontGuide(.body2)
        label.textColor = .Gray700
        label.numberOfLines = 0
        return label
    }()
    
    private let magnifyButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageLiterals.HappyRoutine.icMagnify, for: .normal)
        return button
    }()
    
    private let detailCardView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.backgroundColor = .SoftieWhite
        view.roundCorners(cornerRadius: 20, maskedCorners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner])
        view.layer.borderColor = UIColor.Gray100.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .fontGuide(.body2)
        label.textColor = .Gray700
        label.numberOfLines = 0
        return label
    }()
    
    private let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .Gray100
        return view
    }()
    
    private let detailContentLabel: UILabel = {
        let label = UILabel()
        label.font = .fontGuide(.body4)
        label.textColor = .Gray400
        label.numberOfLines = 0
        return label
    }()
    
    private let timeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.HappyRoutine.icTime
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = .fontGuide(.caption1)
        label.textColor = .Gray400
        return label
    }()
    
    private let placeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.HappyRoutine.icPlace
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let placeLabel: UILabel = {
        let label = UILabel()
        label.font = .fontGuide(.caption1)
        label.textColor = .Gray400
        return label
    }()
    
    private let switchButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageLiterals.HappyRoutine.icTransfer, for: .normal)
        return button
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setHierarchy()
        setLayout()
        setAddTarget()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

private extension HappyRoutineCardView {
    
    func setHierarchy() {
        self.addSubviews(cardView, detailCardView)
        self.cardView.addSubviews(cardImageView, detailTitleLabel, magnifyButton)
        self.detailCardView.addSubviews(subtitleLabel, dividerView, detailContentLabel, timeImageView, timeLabel, placeImageView, placeLabel, switchButton)
    }
    
    func setLayout() {
        cardView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        cardImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        detailTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(236)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        magnifyButton.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview().inset(22)
            $0.size.equalTo(24)
        }
        
        detailCardView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(49)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        dividerView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(18)
            $0.top.equalToSuperview().inset(145)
            $0.height.equalTo(1)
        }
        
        detailContentLabel.snp.makeConstraints {
            $0.top.equalTo(dividerView.snp.bottom).offset(17)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        timeImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(94)
            $0.size.equalTo(22)
        }
        
        timeLabel.snp.makeConstraints {
            $0.leading.equalTo(timeImageView.snp.trailing).offset(6)
            $0.centerY.equalTo(timeImageView.snp.centerY)
        }
        
        placeImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(65)
            $0.size.equalTo(22)
        }
        
        placeLabel.snp.makeConstraints {
            $0.leading.equalTo(placeImageView.snp.trailing).offset(6)
            $0.centerY.equalTo(placeImageView.snp.centerY)
        }
        
        switchButton.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview().inset(22)
            $0.size.equalTo(24)
        }
    }
    
    func setAddTarget() {
        magnifyButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        switchButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc func buttonTapped(sender: UIButton) {
        switch sender {
        case magnifyButton:
            cardToDetailCard()
        case switchButton:
            detailCardToCard()
        default:
            break
        }
    }
    
    func cardToDetailCard() {
        self.detailCardView.isHidden.toggle()
        UIView.transition(with: self.detailCardView, duration: 0.6, options: .transitionFlipFromLeft, animations: nil)

        UIView.transition(with: self.cardView, duration: 0.6, options: .transitionFlipFromLeft, animations: nil, completion: {_ in
            self.cardView.isHidden.toggle()
        })
    }
    
    func detailCardToCard() {
        self.cardView.isHidden.toggle()
        UIView.transition(with: self.cardView, duration: 0.6, options: .transitionFlipFromLeft, animations: nil)
        UIView.transition(with: self.detailCardView, duration: 0.6, options: .transitionFlipFromLeft, animations: nil, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
            self.detailCardView.isHidden.toggle()
        }
    }
}

extension HappyRoutineCardView {

    func setDataBind(model: HappyRoutineCard) {
        self.cardImageView.image = model.cardImage
        self.detailTitleLabel.text = model.detailTitle
        self.detailTitleLabel.setLineSpacing(lineSpacing: 4)
        self.detailTitleLabel.textAlignment = .center
        self.subtitleLabel.text = model.detailTitle
        self.subtitleLabel.setLineSpacing(lineSpacing: 4)
        self.subtitleLabel.textAlignment = .center
        self.detailContentLabel.text = model.detailContent
        self.detailContentLabel.setTextWithLineHeight(text: detailContentLabel.text, lineHeight: 14 * 1.5)
        self.timeLabel.text = model.detailTime
        self.placeLabel.text = model.detailPlace
    }
}
