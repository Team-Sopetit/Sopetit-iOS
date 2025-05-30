//
//  AddCustomRoutineView.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 5/30/25.
//

import UIKit

import SnapKit

final class AddCustomRoutineView: UIView {
    
    // MARK: - UI Components
    
    let navigationView: CustomNavigationBarView = {
        let navi = CustomNavigationBarView()
        navi.isBackButtonIncluded = true
        navi.isRightButtonIncluded = true
        return navi
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private let contentView = UIView()
    
    private let customRoutineTitle: UILabel = {
        let label = UILabel()
        label.text = "루틴"
        label.font = .fontGuide(.body2)
        label.asLineHeight(.body2)
        label.textColor = .Gray700
        return label
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.text = "50자 이내로 가능해요"
        label.font = .fontGuide(.caption1)
        label.asLineHeight(.caption1)
        label.textColor = .Red200
        label.isHidden = true
        return label
    }()
    
    let customRoutineTextView: UITextView = {
        let textView = UITextView()
        textView.text = "루틴을 입력해주세요"
        textView.font = .fontGuide(.body2)
        textView.textColor = .Gray300
        textView.showsHorizontalScrollIndicator = false
        textView.backgroundColor = .SoftieWhite
        textView.layer.cornerRadius = 8
        textView.isScrollEnabled = false
        textView.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 48)
        textView.layoutManager.allowsNonContiguousLayout = false
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = 20
        paragraphStyle.maximumLineHeight = 20
        
        let attributedText = NSAttributedString(
            string: textView.text,
            attributes: [
                .font: textView.font!,
                .foregroundColor: textView.textColor!,
                .paragraphStyle: paragraphStyle
            ]
        )
        textView.attributedText = attributedText
        return textView
    }()
    
    let textClearButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(resource: .icTextClear), for: .normal)
        button.isHidden = true
        return button
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setHierarchy()
        setLayout()
        setDelegate()
        setRegisterCell()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

private extension AddCustomRoutineView {
    
    func setUI() {
        self.backgroundColor = .Gray50
    }
    
    func setHierarchy() {
        addSubviews(
            navigationView,
            scrollView
        )
        scrollView.addSubview(contentView)
        contentView.addSubviews(
            customRoutineTitle,
            errorLabel,
            customRoutineTextView,
            textClearButton
        )
    }
    
    func setDelegate() {
        customRoutineTextView.delegate = self
    }
    
    func setLayout() {
        navigationView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView)
            $0.width.equalTo(scrollView.snp.width)
            $0.height.equalTo(scrollView.snp.height).priority(.low)
        }
        
        customRoutineTitle.snp.makeConstraints {
            $0.top.equalToSuperview().inset(4)
            $0.leading.equalToSuperview().inset(20)
        }
        
        errorLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(6)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        customRoutineTextView.snp.makeConstraints {
            $0.top.equalTo(customRoutineTitle.snp.bottom).offset(6)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 40)
            $0.height.equalTo(52)
        }
        
        textClearButton.snp.makeConstraints {
            $0.top.equalTo(customRoutineTextView.snp.top).offset(16)
            $0.trailing.equalTo(customRoutineTextView.snp.trailing).offset(-16)
            $0.size.equalTo(20)
        }
    }
    
    func setRegisterCell() {
    }
}

extension AddCustomRoutineView: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .Gray300 {
            textView.text = nil
            textView.textColor = .Gray700
            textView.layer.borderColor = UIColor.Gray650.cgColor
            textView.layer.borderWidth = 1
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "루틴을 입력해주세요"
            textView.textColor = .Gray300
            textClearButton.isHidden = true
            errorLabel.isHidden = true
            textView.layer.borderWidth = 0
        }
    }
    
    func textView(_ textView: UITextView,
                  shouldChangeTextIn range: NSRange,
                  replacementText text: String) -> Bool {
        let current = textView.text ?? ""
        guard let stringRange = Range(range, in: current) else { return false }
        let updated = current.replacingCharacters(in: stringRange, with: text)
        let allow = updated.count <= 50
        errorLabel.isHidden = allow
        textView.layer.borderColor = allow ? UIColor.Gray650.cgColor : UIColor.Red200.cgColor
        return allow
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let count = textView.text.count
        errorLabel.isHidden = (count <= 50)
        textClearButton.isHidden = !(count > 0)
        textView.layer.borderWidth = count > 0 ? 1 : 0
        
        let size = CGSize(width: textView.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        
        textView.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = max(52, estimatedSize.height)
            }
        }
        textView.scrollRangeToVisible(textView.selectedRange)
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        return true
    }
}
