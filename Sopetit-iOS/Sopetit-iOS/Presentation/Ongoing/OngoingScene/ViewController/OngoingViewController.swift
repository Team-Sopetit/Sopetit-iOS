//
//  ActiveRoutineViewController.swift
//  Sopetit-iOS
//
//  Created by Minjoo Kim on 6/13/24.
//

import UIKit

import SnapKit

class OngoingViewController: UIViewController {
    
    private var challengeRoutine = ChallengeMemberEntity.challengeMemberInitial()
    private var dailyRoutineEntity = NewDailyRoutineEntity(routines: [])
    private var patchRoutineEntity = PatchRoutineEntity(routineId: 0, isAchieve: false, achieveCount: 0, hasCotton: false)
    let ongoingView = OngoingView()
    private var tapRoutine: EditDailyRoutineInfo = EditDailyRoutineInfo.initInfo
    
    override func loadView() {
        self.view = ongoingView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getDailyRoutine(status: false)
        getChallengeRoutine()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setDelegate()
        setAddTarget()
    }
}

private extension OngoingViewController {
    
    func setUI() {
        self.navigationController?.navigationBar.isHidden = true
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(setAddCustomRoutineToastView),
            name: Notification.Name("addCutomRoutine"),
            object: nil
        )
    }
    
    @objc
    func buttonTapped() {
        let nav = AddRoutineViewController()
        nav.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(nav, animated: true)
    }
    
    func setDelegate() {
        ongoingView.dailyRoutineView.dailyCollectionView.delegate = self
        ongoingView.dailyRoutineView.dailyCollectionView.dataSource = self
        ongoingView.challengeRoutineEmptyView.delegate = self
        ongoingView.dailyRoutineEmptyView.delegate = self
        ongoingView.challengeRoutineView.challengeRoutineCardView.delegate = self
    }
    
    func setAddTarget() {
        ongoingView.routineEmptyView.addRoutineButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        ongoingView.challengeRoutineView.challengeInfoButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        ongoingView.dailyRoutineView.dailyInfoButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        ongoingView.floatingButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
    }
    
    @objc func tapButton(_ sender: UIButton) {
        switch sender {
        case ongoingView.routineEmptyView.addRoutineButton:
            let vc = AddRoutineViewController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        case ongoingView.challengeRoutineView.challengeInfoButton:
            popChallengeInfo()
        case ongoingView.dailyRoutineView.dailyInfoButton:
            popDailyInfo()
        case ongoingView.floatingButton:
            let vc = AddRoutineViewController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
    
    func popDailyInfo() {
        self.ongoingView.addSubviews(self.ongoingView.dailyInfoView, self.ongoingView.dailyInfoImageView)
        self.ongoingView.dailyInfoView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        self.ongoingView.dailyInfoImageView.snp.makeConstraints {
            $0.top.equalTo(self.ongoingView.dailyRoutineView.dailyInfoButton.snp.top)
            $0.trailing.equalTo(self.ongoingView.dailyRoutineView.dailyInfoButton.snp.trailing)
        }
        NotificationCenter.default.post(name: Notification.Name("showPopup"), object: nil)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView(_:)))
        self.ongoingView.dailyInfoView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func popChallengeInfo() {
        self.ongoingView.addSubviews(self.ongoingView.dailyInfoView, self.ongoingView.challengeInfoImageView)
        
        self.ongoingView.dailyInfoView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.ongoingView.challengeInfoImageView.snp.makeConstraints {
            $0.top.equalTo(self.ongoingView.challengeRoutineView.challengeInfoButton.snp.top)
            $0.trailing.equalTo(self.ongoingView.challengeRoutineView.challengeInfoButton.snp.trailing)
        }
        NotificationCenter.default.post(name: Notification.Name("showPopup"), object: nil)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapChallengeView(_:)))
        self.ongoingView.dailyInfoView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func moreChallenge() {
        let nav = ChallengeBSViewController()
        nav.entity = challengeRoutine
        nav.delegate = self
        nav.modalPresentationStyle = .overFullScreen
        self.present(nav, animated: false)
    }
    
    @objc func didTapView(_ sender: UITapGestureRecognizer) {
        NotificationCenter.default.post(name: Notification.Name("hidePopup"), object: nil)
        closeDailyInfo()
    }
    
    @objc func didTapChallengeView(_ sender: UITapGestureRecognizer) {
        NotificationCenter.default.post(name: Notification.Name("hidePopup"), object: nil)
        closeChallengeInfo()
    }

    func closeDailyInfo() {
        self.ongoingView.dailyInfoImageView.removeFromSuperview()
        self.ongoingView.dailyInfoView.removeFromSuperview()
    }
    
    func closeChallengeInfo() {
        self.ongoingView.challengeInfoImageView.removeFromSuperview()
        self.ongoingView.dailyInfoView.removeFromSuperview()
    }
}

extension OngoingViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if dailyRoutineEntity.routines.isEmpty {
            print("emptyView")
            ongoingView.setRoutineView(challenge: false, daily: false)
        }
        return dailyRoutineEntity.routines.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return dailyRoutineEntity.routines[section].routines.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = NewDailyRoutineCollectionViewCell.dequeueReusableCell(collectionView: collectionView, indexPath: indexPath)
        cell.setDataBind(
            themeId: dailyRoutineEntity.routines[indexPath.section].themeId,
            routine: dailyRoutineEntity.routines[indexPath.section].routines[indexPath.item]
        )
        cell.delegate = self
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        return CGSize(width: SizeLiterals.Screen.screenWidth - 40, height: 22)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = NewDailyRoutineHeaderView.dequeueReusableHeaderView(collectionView: ongoingView.dailyRoutineView.dailyCollectionView, indexPath: indexPath)
            headerView.setDataBind(text: dailyRoutineEntity.routines[indexPath.section].themeName, image: dailyRoutineEntity.routines[indexPath.section].themeId)
            return headerView
        }
        return UICollectionReusableView()
    }
}

extension OngoingViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let label: UILabel = {
            let label = UILabel()
            label.text = dailyRoutineEntity.routines[indexPath.section].routines[indexPath.item].content
            label.font = .fontGuide(.body2)
            return label
        }()
        var hasAlarm: Bool = false
        if dailyRoutineEntity.routines[indexPath.section].routines[indexPath.item].alarmTime != nil {
            hasAlarm = true
        }
        let height = max(heightForView(text: label.text ?? "", font: label.font, width: SizeLiterals.Screen.screenWidth - 151), 24) + 50
        
        return CGSize(width: SizeLiterals.Screen.screenWidth - 40, height: hasAlarm ? height + 2 : height)
    }
    
    func heightForView(
        text: String,
        font: UIFont,
        width: CGFloat
    ) -> CGFloat {
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.setTextWithLineHeight(text: label.text, lineHeight: 20)
        label.sizeToFit()
        return label.frame.height
    }
    
    func heightForContentView(
        numberOfSection: Int,
        texts: NewDailyRoutineEntity
    ) {
        var height = Double(numberOfSection) * 18.0
        
        for i in texts.routines {
            for j in i.routines {
                let textHeight = heightForView(text: j.content, font: .fontGuide(.body2), width: SizeLiterals.Screen.screenWidth - 151) + 50
                height += textHeight
            }
            height += 18
        }
        height += Double(16 * (texts.routines.count - 1) + 90)
        ongoingView.dailyRoutineView.dailyCollectionView.snp.remakeConstraints {
            $0.height.equalTo(height)
            $0.top.equalTo(ongoingView.dailyRoutineView.dailyTitleLabel.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}

extension OngoingViewController {
    func getDailyRoutine(status: Bool) {
        OngoingService.shared.getDailyRoutine { networkResult in
            switch networkResult {
            case .success(let data):
                if let data = data as? GenericResponse<NewDailyRoutineEntity> {
                    if let listData = data.data {
                        self.dailyRoutineEntity = listData
                        self.dailyRoutineEntity.routines.sort(by: {$0.themeId < $1.themeId})
                        if self.dailyRoutineEntity.routines.isEmpty {
                            self.ongoingView.isDaily = false
                        } else {
                            self.ongoingView.isDaily = true
                            self.heightForContentView(numberOfSection: self.dailyRoutineEntity.routines.count, texts: self.dailyRoutineEntity)
                            self.ongoingView.dailyRoutineView.dailyCollectionView.reloadData()
                        }
                    }
                    if status == true {
                        self.setDeleteToastView()
                    }
                }
            case .requestErr, .serverErr:
                break
            default:
                break
            }
        }
    }
    
    func getChallengeRoutine() {
        OngoingService.shared.getChallengeRoutine { networkResult in
            self.ongoingView.isChallenge = false
            switch networkResult {
            case .success(let data):
                if let data = data as? GenericResponse<ChallengeMemberEntity> {
                    if let listData = data.data {
                        self.challengeRoutine = listData
                        if self.challengeRoutine.memberChallengeID != 0 {
                            self.ongoingView.isChallenge = true
                            self.ongoingView.challengeRoutineView.challengeRoutineCardView.setDataBind(data: self.challengeRoutine)
                        }
                    }
                }
            case .requestErr, .serverErr:
                break
            default:
                break
            }
        }
    }
    
    func patchRoutineAPI(routineId: Int) {
        OngoingService.shared.patchRoutineAPI(routineId: routineId) { networkResult in
            switch networkResult {
            case .success(let data):
                if let data = data as? GenericResponse<PatchRoutineEntity> {
                    if let listData = data.data {
                        self.patchRoutineEntity = listData
                    }
                    if self.patchRoutineEntity.hasCotton == true {
                        self.getCottonView()
                    } else {
                        if self.patchRoutineEntity.isAchieve == false {
                            self.setCancelToastView()
                        } else {
                            self.setNotCottonToastView()
                        }
                    }
                }
            case .requestErr, .serverErr:
                break
            default:
                break
            }
        }
    }
    
    func patchChallengeRoutine() {
        OngoingService.shared.patchChallengeAPI { networkResult in
            switch networkResult {
            case .success:
                self.getRainbowCottonView()
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    self.ongoingView.isChallenge = false
                }
            case .requestErr, .serverErr:
                break
            default:
                break
            }
        }
    }
}

extension OngoingViewController {
    
    func getCottonView() {
        let vc = GetCottonViewController()
        vc.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.present(vc, animated: false)
    }
    
    func getRainbowCottonView() {
        let vc = GetRainbowCottonViewController()
        vc.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        self.present(vc, animated: false)
    }
    
    func setCancelToastView() {
        self.ongoingView.addSubviews(ongoingView.cancelToastImageView)
        self.ongoingView.bringSubviewToFront(self.ongoingView.cancelToastImageView)
        self.ongoingView.cancelToastImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(self.ongoingView.safeAreaLayoutGuide).inset(24)
        }
        
        UIView.animate(withDuration: 0.5, delay: 1, animations: {self.ongoingView.cancelToastImageView.alpha = 0}, completion: {_ in self.ongoingView.cancelToastImageView.removeFromSuperview()
            self.ongoingView.cancelToastImageView.alpha = 1})
    }
    
    @objc
    func setAddCustomRoutineToastView() {
        ongoingView.addSubview(ongoingView.addCustomRoutineToastView)
        ongoingView.bringSubviewToFront(ongoingView.addCustomRoutineToastView)
        ongoingView.addCustomRoutineToastView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(self.ongoingView.safeAreaLayoutGuide).inset(24)
        }
        
        UIView.animate(
            withDuration: 0.5,
            delay: 1,
            animations: {
                self.ongoingView.addCustomRoutineToastView.alpha = 0
            },
            completion: { _ in
                self.ongoingView.addCustomRoutineToastView.removeFromSuperview()
                self.ongoingView.addCustomRoutineToastView.alpha = 1
            }
        )
    }
    
    func setNotCottonToastView() {
        self.ongoingView.addSubviews(ongoingView.notCottonToastImageView)
        self.ongoingView.bringSubviewToFront(self.ongoingView.notCottonToastImageView)
        self.ongoingView.notCottonToastImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(self.ongoingView.safeAreaLayoutGuide).inset(24)
        }
        
        UIView.animate(withDuration: 0.5, delay: 1, animations: {self.ongoingView.notCottonToastImageView.alpha = 0}, completion: {_ in self.ongoingView.notCottonToastImageView.removeFromSuperview()
            self.ongoingView.notCottonToastImageView.alpha = 1})
    }
    
    func setDeleteToastView() {
        self.ongoingView.addSubviews(ongoingView.deleteToastImageView)
        self.ongoingView.bringSubviewToFront(self.ongoingView.deleteToastImageView)
        self.ongoingView.deleteToastImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(self.ongoingView.safeAreaLayoutGuide).inset(24)
        }
        
        UIView.animate(withDuration: 0.5, delay: 1, animations: {self.ongoingView.deleteToastImageView.alpha = 0}, completion: {_ in self.ongoingView.deleteToastImageView.removeFromSuperview()
            self.ongoingView.deleteToastImageView.alpha = 1})
    }
    
    func setDeleteChallengeToastView() {
        self.ongoingView.addSubviews(ongoingView.deleteToastChallengeImageView)
        self.ongoingView.bringSubviewToFront(self.ongoingView.deleteToastChallengeImageView)
        self.ongoingView.deleteToastChallengeImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(self.ongoingView.safeAreaLayoutGuide).inset(24)
        }
        
        UIView.animate(withDuration: 0.5, delay: 1, animations: {self.ongoingView.deleteToastChallengeImageView.alpha = 0}, completion: {_ in self.ongoingView.deleteToastChallengeImageView.removeFromSuperview()
            self.ongoingView.deleteToastChallengeImageView.alpha = 1})
    }
}

extension OngoingViewController: CVCellDelegate {
    func selectedRadioButton(_ index: Int) {
        patchRoutineAPI(routineId: index)
    }
    
    func tapEllipsisButton(
        themeId: Int,
        model: DailyRoutinev2
    ) {
        let contentHeight = heightForView(
            text: model.content,
            font: .fontGuide(.body1),
            width: SizeLiterals.Screen.screenWidth - 80
        )
        let nav = DailyBSViewController()
        nav.delegate = self
        nav.bottomHeight = contentHeight + (model.alarmTime != nil ? 256 : 224)
        nav.height = contentHeight
        nav.entity = model
        nav.modalPresentationStyle = .overFullScreen
        self.tapRoutine = EditDailyRoutineInfo(
            routineId: model.routineId,
            themeId: themeId - 1 ,
            content: model.content,
            alarmTime: model.alarmTime,
            isSoftieRoutine: model.originRoutineId != nil
        )
        self.present(nav, animated: false)
    }
}

extension OngoingViewController: DailyRoutineProtocol {
    func editDailyRoutine() {
        let nav = AddCustomRoutineViewController()
        nav.fromEdit = true
        nav.routineInfo = self.tapRoutine
        self.navigationController?.pushViewController(nav, animated: true)
    }
    
    func deleteDailyRoutine() {
        getDailyRoutine(status: true)
    }
}

extension OngoingViewController: AddRoutineProtocol {
    func tapAddChallengeRoutine() {
        let vc = AddRoutineViewController()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension OngoingViewController: ChallengeCardProtocol {
    func tapCompleteButton() {
        patchChallengeRoutine()
    }
    
    func tapEllipsisButton() {
        moreChallenge()
    }
}

extension OngoingViewController: DeleteChallengeProtocol {
    func deleteChallengeRoutine() {
        self.ongoingView.isChallenge = false
        self.setDeleteChallengeToastView()
    }
}
