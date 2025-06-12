//
//  DailyBSViewController.swift
//  Sopetit-iOS
//
//  Created by Minjoo Kim on 8/30/24.
//

import UIKit

import SnapKit

protocol DeleteDailyProtocol: AnyObject {
    func deleteDailyRoutine()
}

final class DailyBSViewController: UIViewController {
    
    // MARK: - Properties
    
    weak var delegate: DeleteDailyProtocol?
    
    var bottomHeight: CGFloat = SizeLiterals.Screen.screenHeight * 412 / 812
    var height: CGFloat = 0
    var entity = DailyRoutinev2(routineId: 0, content: "", achieveCount: 0, isAchieve: false, alarmTime: nil)
    
    // MARK: - UI Components
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .Gray1000
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private let bottomSheet: UIView = {
        let view = UIView()
        view.backgroundColor = .SoftieWhite
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.cornerRadius = 20
        view.clipsToBounds = false
        return view
    }()
    
    private let challengeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "데일리 루틴"
        label.textColor = .Gray700
        label.font = .fontGuide(.head4)
        label.asLineHeight(.head4)
        return label
    }()
    
    private let contentBackView: UIView = {
        let view = UIView()
        view.backgroundColor = .Gray200
        view.layer.borderColor = UIColor.Gray300.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let detailContentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .Gray700
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .fontGuide(.body1)
        return label
    }()
    
    let detailDeleteButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .Gray650
        button.setTitle("삭제하기", for: .normal)
        button.titleLabel?.font = .fontGuide(.body1)
        button.setBackgroundColor(.Red200, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        bindUI(model: entity)
        setHierarchy()
        setLayout()
        setDismissAction()
        setAddTarget()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showBottomSheet()
    }
}

// MARK: - Extensions
extension DailyBSViewController {
    
    func setUI() {
        view.backgroundColor = .clear
    }
    
    func bindUI(model: DailyRoutinev2) {
        entity = model
        detailContentLabel.text = model.content.replacingOccurrences(of: "\n", with: " ")
        detailContentLabel.asLineHeight(.body1)
        detailContentLabel.textAlignment = .center
    }
    
    func setHierarchy() {
        contentBackView.addSubview(detailContentLabel)
        bottomSheet.addSubviews(challengeTitleLabel,
                                contentBackView,
                                detailDeleteButton)
        view.addSubviews(backgroundView,
                         bottomSheet)
    }
    
    func setLayout() {
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        bottomSheet.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        challengeTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.centerX.equalToSuperview()
        }
        
        contentBackView.snp.makeConstraints {
            $0.top.equalTo(challengeTitleLabel.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 40)
            $0.height.equalTo(height + 40)
        }
        
        detailContentLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 95)
        }
        
        detailDeleteButton.snp.makeConstraints {
            $0.top.equalTo(contentBackView.snp.bottom).offset(32)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 40)
            $0.height.equalTo(56)
        }
    }
    
    func setAddTarget() {
        detailDeleteButton.addTarget(self, action: #selector(tapDeleteButton), for: .touchUpInside)
    }
    
    func showBottomSheet() {
        DispatchQueue.main.async {
            self.bottomSheet.snp.remakeConstraints {
                $0.leading.trailing.bottom.equalToSuperview()
                $0.top.equalToSuperview().inset(SizeLiterals.Screen.screenHeight - self.bottomHeight)
            }
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: {
                self.backgroundView.backgroundColor = .Gray1000
                self.view.layoutIfNeeded()
            })
        }
    }
    
    func hideBottomSheet() {
        DispatchQueue.main.async {
            self.bottomSheet.snp.remakeConstraints {
                $0.leading.trailing.bottom.equalToSuperview()
            }
            UIView.animate(withDuration: 0.25, delay: 0, animations: {
                self.backgroundView.backgroundColor = .clear
                self.view.layoutIfNeeded()
            }, completion: { _ in
                if self.presentingViewController != nil {
                    self.dismiss(animated: true, completion: nil)
                }
            })
        }
    }
    
    func setDismissAction() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideBottomSheetAction))
        backgroundView.addGestureRecognizer(tapGesture)
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(hideBottomSheetAction))
        swipeGesture.direction = .down
        view.addGestureRecognizer(swipeGesture)
    }
    
    @objc
    func hideBottomSheetAction() {
        hideBottomSheet()
    }
    
    @objc
    func tapDeleteButton() {
        deleteRoutineListAPI(routineId: entity.routineId)
    }
    
    func deleteRoutineListAPI(routineId: Int) {
        OngoingService.shared.deleteRoutineListAPI(routineIdList: "\(routineId)") { networkResult in
            switch networkResult {
            case .success:
                self.dismiss(animated: false)
                self.delegate?.deleteDailyRoutine()
            case .requestErr, .serverErr:
                break
            default:
                break
            }
        }
    }
}
