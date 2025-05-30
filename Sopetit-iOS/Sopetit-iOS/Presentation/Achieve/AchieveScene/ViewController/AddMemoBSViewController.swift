//
//  AddMemoBSViewController.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 12/3/24.
//

import UIKit

import SnapKit
import FirebaseAnalytics

final class AddMemoBSViewController: UIViewController {
    
    // MARK: - Properties
    
    private var bottomHeight: CGFloat = SizeLiterals.Screen.screenHeight * 312 / 812
    private var bottomsheetBottomOffest = 0.0
    private var isKeyboardVisible = false
    private var isAddMemo: Bool = false
    private var memoId: Int = 0
    
    var selectDate: Date = Date()
    
    // MARK: - UI Components
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .Gray950
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private let bottomSheet: UIView = {
        let view = UIView()
        view.backgroundColor = .SoftieWhite
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.cornerRadius = 20
        view.clipsToBounds = false
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "메모"
        label.font = .fontGuide(.head4)
        label.textColor = .Gray700
        return label
    }()
    
    private let textCountLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .Gray400
        label.font = .fontGuide(.body2)
        return label
    }()
    
    private let maxCountLabel: UILabel = {
        let label = UILabel()
        label.text = "/100"
        label.textColor = .Gray400
        label.font = .fontGuide(.body2)
        return label
    }()
    
    private let editMemoTextView: UITextView = {
        let textView = UITextView()
        textView.text = "간단한 감정이나 생각을 남겨보세요."
        textView.font = .fontGuide(.body2)
        textView.textColor = .Gray400
        textView.textContainer.maximumNumberOfLines = 4
        textView.showsHorizontalScrollIndicator = false
        textView.backgroundColor = .Gray200
        textView.layer.cornerRadius = 8
        textView.isScrollEnabled = false
        textView.textContainerInset = UIEdgeInsets(top: SizeLiterals.Screen.screenHeight * 16 / 812, left: 16, bottom: 0, right: 16)
        
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
    
    private let completeButton: UIButton = {
        let button = UIButton()
        button.isEnabled = false
        button.setTitle("완료", for: .normal)
        button.setTitleColor(.SoftieWhite, for: .normal)
        button.setBackgroundColor(.Gray650, for: .normal)
        button.setBackgroundColor(.Gray300, for: .disabled)
        button.layer.cornerRadius = 10
        return button
    }()
    
    // MARK: - Life Cycles
    
    init(memo: String, memoId: Int) {
        self.memoId = memoId
        super.init(nibName: nil, bundle: nil)
        self.bindUI(memo: memo)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setHierarchy()
        setLayout()
        setDismissAction()
        setAddTarget()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showBottomSheet()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardUp),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardDown),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

extension AddMemoBSViewController {
    
    func bindUI(memo: String) {
        if memo == "" { // AddMemo
            isAddMemo = true
        } else { // EditMemo
            isAddMemo = false
            editMemoTextView.text = memo
            editMemoTextView.textColor = .Gray700
            textCountLabel.text = String(memo.count)
            textCountLabel.textColor = .Gray700
            completeButton.isEnabled = true
        }
    }
    
    func setUI() {
        view.backgroundColor = .clear
    }
    
    func setHierarchy() {
        bottomSheet.addSubviews(titleLabel,
                                textCountLabel,
                                maxCountLabel,
                                editMemoTextView,
                                completeButton)
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
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.centerX.equalToSuperview()
        }
        
        maxCountLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.top)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        textCountLabel.snp.makeConstraints {
            $0.top.equalTo(maxCountLabel.snp.top)
            $0.trailing.equalTo(maxCountLabel.snp.leading).offset(-1)
        }
        
        editMemoTextView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 40)
            $0.height.equalTo(132)
        }
        
        completeButton.snp.makeConstraints {
            if SizeLiterals.Screen.deviceRatio > 0.5 {
                $0.top.equalTo(editMemoTextView.snp.bottom).offset(16)
            } else {
                $0.top.equalTo(editMemoTextView.snp.bottom).offset(SizeLiterals.Screen.screenHeight * 32 / 812)
            }
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 40)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 56 / 812)
        }
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
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: {
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
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleSwipeGesture))
        backgroundView.addGestureRecognizer(tapGesture)
        
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboardAndBottomSheet))
        bottomSheet.addGestureRecognizer(tapGesture2)
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture))
        swipeGesture.direction = .down
        view.addGestureRecognizer(swipeGesture)
    }
    
    @objc
    func handleSwipeGesture() {
        if isKeyboardVisible {
            dismissKeyboardAndBottomSheet()
        } else {
            hideBottomSheet()
        }
    }
    
    @objc
    func dismissKeyboardAndBottomSheet() {
        view.endEditing(true)
        isKeyboardVisible = false
    }
    
    @objc
    func hideBottomSheetAction() {
        hideBottomSheet()
    }
    
    func setAddTarget() {
        editMemoTextView.delegate = self
        completeButton.addTarget(self,
                                 action: #selector(tapCompleteButton),
                                 for: .touchUpInside)
    }
    
    @objc
    func tapCompleteButton() {
        if isAddMemo {
            postMemo()
        } else { // patch
            patchMemo()
        }
    }
    
    func checkMaxLength(_ textView: UITextView) {
        
        let maxLength = 100
        if textView.text.count > maxLength {
            textView.deleteBackward()
        }
        
        if textView.numberOfLines() < 5 {
            textView.isEditable = true
        } else {
            textView.deleteBackward()
        }
    }
    
    @objc func keyboardUp(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let animationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else {
            return
        }
        
        let keyboardHeight = keyboardFrame.height
        isKeyboardVisible = true
        bottomSheet.snp.updateConstraints {
            $0.top.equalToSuperview().inset(SizeLiterals.Screen.screenHeight - bottomHeight - keyboardHeight)
        }
        UIView.animate(withDuration: animationDuration) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardDown(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let animationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else {
            return
        }
        isKeyboardVisible = false
        bottomSheet.snp.updateConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
        }
        UIView.animate(withDuration: animationDuration) {
            self.view.layoutIfNeeded()
        }
    }
}

extension AddMemoBSViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .Gray400 {
            textView.text = nil
            textView.textColor = .Gray700
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "간단한 감정이나 생각을 남겨보세요."
            textView.textColor = .Gray400
            completeButton.isEnabled = false
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        checkMaxLength(textView)
        let count = textView.text.count
        textCountLabel.text = String(count)
        textCountLabel.textColor = count > 0 ? .Gray700 : .Gray400
        completeButton.isEnabled = count > 0 ? true : false
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        return true
    }
}

// MARK: - Networks

extension AddMemoBSViewController {
    
    func postMemo() {
        AchieveService.shared.postMemoAPI(addMemoEntity: AddMemosRequestEntity(achievedDate: formatDateToString(selectDate), content: editMemoTextView.text)) { networkResult in
            switch networkResult {
            case .success(let data):
                if let data = data as? GenericResponse<MemosResponseEntity> {
                    print("➡️➡️➡️")
                    dump(data)
                    Analytics.logEvent("add_memo", parameters: nil)
                    NotificationCenter.default.post(name: Notification.Name("addMemo"), object: nil)
                    UserManager.shared.setWriteMemo()
                    self.hideBottomSheet()
                }
            case .reissue:
                ReissueService.shared.postReissueAPI(refreshToken: UserManager.shared.getRefreshToken) { success in
                    if success {
                        self.postMemo()
                    } else {
                        self.makeSessionExpiredAlert()
                    }
                }
            case .requestErr, .serverErr:
                self.makeServerErrorAlert()
            default:
                break
            }
        }
    }
    
    func patchMemo() {
        AchieveService.shared.patchMemoAPI(memoId: self.memoId,
                                           content: self.editMemoTextView.text) { networkResult in
            switch networkResult {
            case .success(let data):
                if let _ = data as? GenericResponse<EmptyEntity> {
                    NotificationCenter.default.post(name: Notification.Name("patchMemo"), object: nil)
                    self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
                }
            case .reissue:
                ReissueService.shared.postReissueAPI(refreshToken: UserManager.shared.getRefreshToken) { success in
                    if success {
                        self.postMemo()
                    } else {
                        self.makeSessionExpiredAlert()
                    }
                }
            case .requestErr, .serverErr:
                self.makeServerErrorAlert()
            default:
                break
            }
        }
    }
}
