//
//  SelectHappyCategoryView.swift
//  Sopetit-iOS
//
//  Created by Minjoo Kim on 1/9/24.
//

import UIKit

import SnapKit

final class SelectHappyCategoryView: UIView {

    // MARK: - Properties
    
    // MARK: - UI Components
    private let customNavigationBar: CustomNavigationBarView = {
        let view = CustomNavigationBarView()
        view.isTitleViewIncluded = true
        view.isTitleLabelIncluded = I18N.HappyRoutine.addHappyRoutineTitle
        view.isBackButtonIncluded = true
        return view
    }()
    
    let tagview = HappyRoutineTagView()
    private let divideView: UIView = {
        let view = UIView()
        view.backgroundColor = .Gray100
        return view
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setHierarchy()
        setLayout()
        setAddTarget()
        setRegisterCell()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

extension SelectHappyCategoryView {

    func setUI() {
        self.backgroundColor = .SoftieBack
    }
    
    func setHierarchy() {
        self.addSubviews(customNavigationBar, tagview, divideView)

    }
    
    func setLayout() {
        customNavigationBar.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
        }
        
        tagview.snp.makeConstraints {
            $0.top.equalTo(customNavigationBar.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(61)
        }
        
        divideView.snp.makeConstraints {
            $0.top.equalTo(tagview.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(1)
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
