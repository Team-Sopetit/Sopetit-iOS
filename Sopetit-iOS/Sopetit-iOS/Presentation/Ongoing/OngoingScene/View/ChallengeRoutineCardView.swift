//
//  ChallengeRoutineCardView.swift
//  Sopetit-iOS
//
//  Created by Minjoo Kim on 6/13/24.
//

import UIKit

import SnapKit

protocol ChallengeCardProtocol: AnyObject {
    func tapCompleteButton()
    func tapEllipsisButton()
}

class ChallengeRoutineCardView: UIView {
    
    weak var delegate: ChallengeCardProtocol?
    
    private var challengeRoutine: ChallengeRoutine = ChallengeRoutine(routineId: 0, themeId: 0, themeName: "", title: "", content: "", detailContent: "", place: "", timeTaken: "")
    
    private let themeImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let themeLabel: UILabel = {
        let label = UILabel()
        label.font = .fontGuide(.body2)
        label.asLineHeight(.body2)
        label.textColor = .Gray500
        return label
    }()
    
    let ellipsisButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(resource: .icMore), for: .normal)
        return button
    }()
    
    private let routineLabel: UILabel = {
        let label = UILabel()
        label.font = .fontGuide(.body2)
        label.asLineHeight(.body2)
        label.textColor = .Gray700
        label.setTextWithLineHeight(text: label.text, lineHeight: 20)
        label.numberOfLines = 0
        return label
    }()
    
    let completeButton: UIButton = {
        let button = UIButton()
        button.setTitle(I18N.ActiveRoutine.complete, for: .normal)
        button.setTitleColor(.SoftieWhite, for: .normal)
        button.titleLabel?.font = .fontGuide(.caption1)
        button.setBackgroundColor(.Gray650, for: .normal)
        button.roundCorners(cornerRadius: 17, maskedCorners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner])
        return button
    }()
    
    let cardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setHierarchy()
        setLayout()
        setAddTarget()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ChallengeRoutineCardView {
    
    func setUI() {
        self.layer.borderColor = UIColor.Gray200.cgColor
        self.layer.borderWidth = 1
        self.roundCorners(cornerRadius: 10, maskedCorners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner])
    }
    
    func setHierarchy() {
        
        self.addSubviews(cardImageView, themeImageView, themeLabel, ellipsisButton, routineLabel, completeButton)
        
    }
    
    func setLayout() {
        
        cardImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        themeImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalTo(ellipsisButton.snp.centerY)
            $0.size.equalTo(16)
        }
        
        themeLabel.snp.makeConstraints {
            $0.leading.equalTo(themeImageView.snp.trailing).offset(2)
            $0.centerY.equalTo(ellipsisButton.snp.centerY)
        }
        
        ellipsisButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(20)
            $0.size.equalTo(24)
        }
        
        routineLabel.snp.makeConstraints {
            $0.top.equalTo(ellipsisButton.snp.bottom).offset(6)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(35)
        }
        
        completeButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(12)
            $0.width.equalTo(66)
            $0.height.equalTo(34)
        }
    }
    
    func setAddTarget() {
        completeButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        ellipsisButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
    }
    
    @objc func tapButton(_ sender: UIButton) {
        switch sender {
        case completeButton:
            delegate?.tapCompleteButton()
        case ellipsisButton:
            delegate?.tapEllipsisButton()
        default:
            break
        }
    }
    
    func heightForView(text: String, font: UIFont, width: CGFloat) -> CGFloat {
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.setTextWithLineHeight(text: label.text, lineHeight: 20)
        label.sizeToFit()
        return label.frame.height
    }
}

extension ChallengeRoutineCardView {
    func setDataBind(data: ChallengeMemberEntity) {
        self.themeImageView.image = UIImage(named: "theme\(data.theme.themeID)") ?? UIImage()
        self.cardImageView.image = UIImage(named: "challenge-\(data.theme.themeID)") ?? UIImage()
        self.themeLabel.text = data.theme.themeName
        self.routineLabel.text = data.content.replacingOccurrences(of: "\n", with: " ")
        self.routineLabel.asLineHeight(.body2)
        var height = heightForView(text: data.content, font: .fontGuide(.body2), width: SizeLiterals.Screen.screenWidth - 95) - 20
        height = height < 40 ? 40 : height
        self.snp.remakeConstraints {
            $0.top.equalToSuperview().inset(40)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(height + 102)
        }
    }
}
