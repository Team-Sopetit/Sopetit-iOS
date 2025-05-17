//
//  ToastWithCottonView.swift
//  Sopetit-iOS
//
//  Created by ahra on 5/17/25.
//

import UIKit

import SnapKit

final class ToastWithCottonView: UIView {
    
    // MARK: - Properties
    
    private let content: String?
    
    // MARK: - UI Components
    
    private let stackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.spacing = 6
        return stackview
    }()
    
    private let toastIconImageview = UIImageView(image: UIImage(resource: .icSom))
    
    private lazy var toastLabel: UILabel = {
        let label = UILabel()
        label.text = content
        label.textColor = .SoftieWhite
        label.font = .fontGuide(.body2)
        label.asLineHeight(.body2)
        return label
    }()
    
    // MARK: - Life Cycles
    
    init(toastContent: String) {
        self.content = toastContent
        super.init(frame: CGRect.zero)
        
        setUI()
        setHierarchy()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ToastWithCottonView {
    
    func setUI() {
        clipsToBounds = true
        backgroundColor = .Gray400
        layer.cornerRadius = 22
    }
    
    func setHierarchy() {
        addSubview(stackView)
        stackView.addArrangedSubviews(toastIconImageview,
                                      toastLabel)
    }
    
    func setLayout() {
        let width = toastLabel.calculateLabelWidth(for: content ?? "",
                                                   with: .fontGuide(.body2))
        self.snp.makeConstraints {
            $0.width.equalTo(width + 56)
            $0.height.equalTo(44)
        }
        
        stackView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        toastIconImageview.snp.makeConstraints {
            $0.size.equalTo(18)
        }
    }
}
