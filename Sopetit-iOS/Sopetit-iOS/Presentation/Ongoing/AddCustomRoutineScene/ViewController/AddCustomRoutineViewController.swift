//
//  AddCustomRoutineViewController.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 5/30/25.
//
import UIKit

import SnapKit
import FirebaseAnalytics
import UserNotifications

final class AddCustomRoutineViewController: UIViewController {
    
    // MARK: - UI Components
    
    private var addCustomRoutineView = AddCustomRoutineView()
    private lazy var collectionView = addCustomRoutineView.themeCollectionView
    private var routineEntity = ThemeSelectEntity(themes: [])
    
    private var selectThemeId: Int = -1 {
        didSet { updateNextButtonState() }
    }
    
    private var currentText: String = "" {
        didSet { updateNextButtonState() }
    }
    
    var fromEdit: Bool = false
    var routineInfo: EditDailyRoutineInfo = EditDailyRoutineInfo.initInfo
    
    // MARK: - Life Cycles
    
    override func loadView() {
        self.view = addCustomRoutineView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getThemeAPI()
        setDelegate()
        setAddTarget()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setUI()
    }
}

extension AddCustomRoutineViewController {
    
    func setUI() {
        if fromEdit {
            addCustomRoutineView.customRoutineTextView.text = routineInfo.content
            addCustomRoutineView.customRoutineTextView.textColor = .Gray700
            if let alarm = routineInfo.alarmTime {
                addCustomRoutineView.alarmToggle.isOn = true
                if let date = date(from: alarm) {
                    addCustomRoutineView.alarmDatePicker.setDate(date, animated: false)
                }
                switchChanged(addCustomRoutineView.alarmToggle)
            }
        } else {
            addCustomRoutineView.onTextChanged = { [weak self] text in
                self?.currentText = text
            }
        }
    }
    
    func setDelegate() {
        addCustomRoutineView.navigationView.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setAddTarget() {
        addCustomRoutineView.textClearButton.addTarget(
            self,
            action: #selector(tapClearButton),
            for: .touchUpInside
        )
        addCustomRoutineView.alarmToggle.addTarget(
            self,
            action: #selector(switchChanged(_:)),
            for: .valueChanged
        )
        addCustomRoutineView.navigationView.rightButton.addTarget(
            self,
            action: #selector(addCustomRoutineTapped),
            for: .touchUpInside
        )
        addCustomRoutineView.alarmErrorButton.addTarget(
            self,
            action: #selector(alarmErrorTapped),
            for: .touchUpInside
        )
        
        let swipeGesture = UISwipeGestureRecognizer(
            target: self,
            action: #selector(handleSwipeGesture)
        )
        swipeGesture.direction = .down
        view.addGestureRecognizer(swipeGesture)
    }
    
    @objc func tapClearButton() {
        let textView = addCustomRoutineView.customRoutineTextView
        currentText = ""
        textView.text = ""
        textView.resignFirstResponder()
        textView.constraints.forEach { constraint in
            if constraint.firstAttribute == .height {
                constraint.constant = 52
            }
        }
        UIView.animate(withDuration: 0.2) {
            self.addCustomRoutineView.layoutIfNeeded()
        }
    }
    
    @objc func addCustomRoutineTapped() {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:00"
        let selectedDate = addCustomRoutineView.alarmDatePicker.date
        let timeString = formatter.string(from: selectedDate)
        
        if addCustomRoutineView.alarmToggle.isOn {
            postRoutineCustomAPI(alarmTime: timeString)
        } else {
            postRoutineCustomAPI()
        }
    }
    
    @objc func switchChanged(_ sender: UISwitch) {
        addCustomRoutineView.alarmDatePicker.isHidden = !sender.isOn
        
        UIView.animate(withDuration: 0.25) {
            self.addCustomRoutineView.alarmStackView.layoutIfNeeded()
        }
        
        guard sender.isOn else {
            addCustomRoutineView.alarmErrorStackView.isHidden = true
            return
        }
        
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                self.addCustomRoutineView.alarmErrorStackView.isHidden = (settings.authorizationStatus == .authorized)
            }
        }
    }
    
    @objc func handleSwipeGesture() {
        view.endEditing(true)
    }
    
    @objc func alarmErrorTapped() {
        if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(settingsURL)
        }
    }
    
    func updateNextButtonState() {
        let shouldEnable = (selectThemeId > 0) && !currentText.isEmpty
        addCustomRoutineView.navigationView.rightButton.isEnabled = shouldEnable
    }
    
    func date(from timeString: String) -> Date? {
        let parts = timeString.split(separator: ":").map { String($0) }
        guard parts.count >= 2,
              let hour = Int(parts[0]),
              let minute = Int(parts[1]) else {
            return nil
        }
        
        var comps = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        comps.hour = hour
        comps.minute = minute
        comps.second = 0
        
        return Calendar.current.date(from: comps)
    }
}

extension AddCustomRoutineViewController: BackButtonProtocol {
    
    func tapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension AddCustomRoutineViewController {
    
    func getThemeAPI() {
        OnBoardingService.shared.getOnboardingThemeAPI { networkResult in
            switch networkResult {
            case .success(let data):
                if let data = data as? GenericResponse<ThemeSelectEntity> {
                    if let listData = data.data {
                        self.routineEntity = listData
                    }
                    self.collectionView.reloadData()
                }
            case .reissue:
                ReissueService.shared.postReissueAPI(refreshToken: UserManager.shared.getRefreshToken) { success in
                    if success {
                        self.getThemeAPI()
                    } else {
                        self.makeSessionExpiredAlert()
                    }
                }
            case .requestErr, .serverErr:
                break
            default:
                break
            }
        }
    }
    
    func postRoutineCustomAPI(
        alarmTime: String? = nil
    ) {
        AddDailyRoutineService.shared.postRoutineCustom(
            content: currentText,
            themeId: selectThemeId,
            alarmTime: alarmTime
        ) { networkResult in
            switch networkResult {
            case .success:
                NotificationCenter.default.post(name: Notification.Name("addCutomRoutine"), object: nil)
                self.navigationController?.popToRootViewController(animated: true)
            case .reissue:
                ReissueService.shared.postReissueAPI(refreshToken: UserManager.shared.getRefreshToken) { success in
                    if success {
                        self.postRoutineCustomAPI(
                            alarmTime: alarmTime
                        )
                    } else {
                        self.makeSessionExpiredAlert()
                    }
                }
            case .requestErr, .serverErr:
                break
            default:
                break
            }
        }
    }
}

extension AddCustomRoutineViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let string = routineEntity.themes[indexPath.item].title
        let cellSize = CGSize(width: string.size(withAttributes: [NSAttributedString.Key.font: UIFont.fontGuide(.body2)]).width + 48, height: 36)
        return cellSize
    }
}

extension AddCustomRoutineViewController: UICollectionViewDataSource {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return routineEntity.themes.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = ThemeSelectCollectionViewCell.dequeueReusableCell(
            collectionView: collectionView,
            indexPath: indexPath
        )
        cell.setDataBind(
            model: routineEntity.themes[indexPath.item],
            fromOnboarding: false
        )
        if fromEdit {
            if indexPath.item == routineInfo.themeId {
                cell.isSelected = true
                cell.backgroundColor = .Gray200
                cell.layer.borderColor = UIColor.Gray650.cgColor
            }
        }
        return cell
    }
}

extension AddCustomRoutineViewController: UICollectionViewDelegate {
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        makeVibrate()
        selectThemeId = routineEntity.themes[indexPath.item].themeID
        if let cell = collectionView.cellForItem(at: indexPath) as? ThemeSelectCollectionViewCell {
            cell.isSelected = true
            cell.backgroundColor = .Gray200
            cell.layer.borderColor = UIColor.Gray650.cgColor
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didDeselectItemAt indexPath: IndexPath
    ) {
        selectThemeId = -1
        if let cell = collectionView.cellForItem(at: indexPath) as? ThemeSelectCollectionViewCell {
            cell.isSelected = false
            cell.backgroundColor = .SoftieWhite
            cell.layer.borderColor = UIColor.Gray200.cgColor
        }
    }
}
