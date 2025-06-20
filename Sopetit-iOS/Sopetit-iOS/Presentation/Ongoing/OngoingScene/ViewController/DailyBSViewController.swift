//
//  DailyBSViewController.swift
//  Sopetit-iOS
//
//  Created by Minjoo Kim on 8/30/24.
//

import UIKit

import SnapKit

protocol DailyRoutineProtocol: AnyObject {
    func editDailyRoutine()
    func deleteDailyRoutine()
}

final class DailyBSViewController: UIViewController {
    
    // MARK: - Properties
    
    weak var delegate: DailyRoutineProtocol?
    
    var bottomHeight: CGFloat = SizeLiterals.Screen.screenHeight * 412 / 812
    var height: CGFloat = 0
    var entity = DailyRoutinev2(routineId: 0, originRoutineId: nil, content: "", achieveCount: 0, isAchieve: false, alarmTime: nil)
    
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
    
    let alarmStackView: UIStackView = {
        let stackview = UIStackView ()
        stackview.axis = .horizontal
        stackview.spacing = 4
        stackview.alignment = .center
        return stackview
    }()
    
    private let alarmIcon = UIImageView(image: UIImage(resource: .icAlarm))
    
    private let alarmTime: UILabel = {
        let label = UILabel()
        label.font = .fontGuide(.body2)
        label.textColor = .Gray500
        return label
    }()
    
    let detailEditButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(resource: .btnMemoEdit), for: .normal)
        button.contentMode = .scaleAspectFill
        return button
    }()
    
    let detailDeleteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(resource: .btnMemoDel), for: .normal)
        button.contentMode = .scaleAspectFill
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
        
        if let alarm = model.alarmTime {
            alarmStackView.isHidden = false
            alarmTime.text = formatAlarmTime(alarm)
            alarmTime.asLineHeight(.body2)
        } else {
            alarmStackView.isHidden = true
        }
    }
    
    func setHierarchy() {
        contentBackView.addSubview(detailContentLabel)
        bottomSheet.addSubviews(challengeTitleLabel,
                                contentBackView,
                                alarmStackView,
                                detailEditButton,
                                detailDeleteButton)
        view.addSubviews(backgroundView,
                         bottomSheet)
        alarmStackView.addArrangedSubviews(
            alarmIcon,
            alarmTime
        )
    }
    
    func setLayout() {
        let hasAlarm = entity.alarmTime != nil
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
        
        alarmStackView.snp.makeConstraints {
            $0.top.equalTo(contentBackView.snp.bottom).offset(12)
            $0.leading.equalTo(contentBackView.snp.leading)
            $0.height.equalTo(20)
        }
        
        alarmIcon.snp.makeConstraints {
            $0.size.equalTo(18)
        }
        
        detailEditButton.snp.makeConstraints {
            if SizeLiterals.Screen.deviceRatio > 0.5 {
                $0.top.equalTo(hasAlarm ? alarmStackView.snp.bottom : contentBackView.snp.bottom).offset(16)
            } else {
                $0.top.equalTo(hasAlarm ? alarmStackView.snp.bottom : contentBackView.snp.bottom).offset(SizeLiterals.Screen.screenHeight * 32 / 812)
            }
            $0.leading.equalToSuperview().inset(20)
            $0.width.equalTo((SizeLiterals.Screen.screenWidth - 47) / 2)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 56 / 812)
        }
        
        detailDeleteButton.snp.makeConstraints {
            if SizeLiterals.Screen.deviceRatio > 0.5 {
                $0.top.equalTo(hasAlarm ? alarmStackView.snp.bottom : contentBackView.snp.bottom).offset(16)
            } else {
                $0.top.equalTo(hasAlarm ? alarmStackView.snp.bottom : contentBackView.snp.bottom).offset(SizeLiterals.Screen.screenHeight * 32 / 812)
            }
            $0.trailing.equalToSuperview().inset(20)
            $0.width.equalTo((SizeLiterals.Screen.screenWidth - 47) / 2)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 56 / 812)
        }
    }
    
    func setAddTarget() {
        detailEditButton.addTarget(self, action: #selector(tapEditButton), for: .touchUpInside)
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
    func tapEditButton() {
        self.dismiss(animated: false)
        self.delegate?.editDailyRoutine()
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
    
    func formatAlarmTime(_ alarmTime: String) -> String {
        let parts = alarmTime.split(separator: ":")
        guard parts.count >= 2,
              let hour = Int(parts[0]),
              let minute = Int(parts[1]) else {
            return alarmTime
        }
        
        let period = hour < 12 ? "오전" : "오후"
        var hour12 = hour % 12
        if hour12 == 0 { hour12 = 12 }
        let minuteStr = minute < 10
               ? "0\(minute)"
               : "\(minute)"
        
        return "\(period) \(hour12):\(minuteStr)"
    }
}
