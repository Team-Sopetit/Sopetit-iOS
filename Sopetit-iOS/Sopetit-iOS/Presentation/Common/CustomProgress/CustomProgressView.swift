//
//  CustomProgressView.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 2024/01/09.
//

import UIKit

import SnapKit

final class CustomProgressView: UIView {

    // MARK: - Properties
    
    private var progress: Int = 1
    
    // MARK: - UI Components
    
    private var progressView1: UIView = {
        var view = UIView()
        view.backgroundColor = .Gray100
        view.layer.cornerRadius = 3
        return view
    }()
    
    private var progressView2: UIView = {
        var view = UIView()
        view.backgroundColor = .Gray100
        view.layer.cornerRadius = 3
        return view
    }()
    
    private var progressView3: UIView = {
        var view = UIView()
        view.backgroundColor = .Gray100
        view.layer.cornerRadius = 3
        return view
    }()
    
    private var progressView4: UIView = {
        var view = UIView()
        view.backgroundColor = .Gray100
        view.layer.cornerRadius = 3
        return view
    }()
    
    // MARK: - Life Cycles
    
    init(progressNum: Int) {
        super.init(frame: CGRect.zero)
        
        self.progress = progressNum
        setHierarchy()
        setLayout()
        setProgress(num: progress)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

extension CustomProgressView {

    func setUI() {
        backgroundColor = .SoftieBack
    }
    
    func setHierarchy() {
        addSubviews(progressView1, progressView2, progressView4, progressView3)
    }
    
    func setLayout() {
        progressView1.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.width.equalTo((SizeLiterals.Screen.screenWidth - 55) / 4)
            $0.height.equalTo(5)
        }
        
        progressView2.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(progressView1.snp.trailing).offset(5)
            $0.width.equalTo((SizeLiterals.Screen.screenWidth - 55) / 4)
            $0.height.equalTo(5)
        }
        
        progressView4.snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
            $0.width.equalTo((SizeLiterals.Screen.screenWidth - 55) / 4)
            $0.height.equalTo(5)
        }
        
        progressView3.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalTo(progressView4.snp.leading).offset(-5)
            $0.width.equalTo((SizeLiterals.Screen.screenWidth - 55) / 4)
            $0.height.equalTo(5)
        }
    }
    
    func setProgress(num: Int) {
        switch num {
        case 1:
            progressView1.backgroundColor = .SoftieMain1
        case 2:
            progressView1.backgroundColor = .SoftieMain1
            progressView2.backgroundColor = .SoftieMain1
        case 3:
            progressView1.backgroundColor = .SoftieMain1
            progressView2.backgroundColor = .SoftieMain1
            progressView3.backgroundColor = .SoftieMain1
        case 4:
            progressView1.backgroundColor = .SoftieMain1
            progressView2.backgroundColor = .SoftieMain1
            progressView3.backgroundColor = .SoftieMain1
            progressView4.backgroundColor = .SoftieMain1
        default:
            break
        }
    }
}
