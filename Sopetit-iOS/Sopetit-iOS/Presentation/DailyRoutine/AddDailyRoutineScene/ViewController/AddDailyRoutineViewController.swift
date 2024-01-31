//
//  AddDailyRoutineViewController.swift
//  Sopetit-iOS
//
//  Created by Minjoo Kim on 1/13/24.
//

import UIKit

final class AddDailyRoutineViewController: UIViewController {
    
    // MARK: - Properties
    
    private var dailyThemesEntity = DailyThemesEntity(themes: [])
    private var themeId = 0
    private var dailyRoutinesEntity = DailyRoutinesEntity(backgroundImageUrl: "", routines: [])
    private var selectedIndex = 0
    private var routineId: Int = 0
    
    private enum Const {
        static let itemSize = CGSize(width: 280, height: 398)
        static let itemSpacing = 20.0
        static let sideItem = insetX - itemSpacing
        
        static var insetX: CGFloat {
            (UIScreen.main.bounds.width - Self.itemSize.width) / 2.0
        }
        static var collectionViewContentInset: UIEdgeInsets {
            UIEdgeInsets(top: 0, left: Self.insetX, bottom: 0, right: Self.insetX)
        }
    }
    
    // MARK: - UI Components
    
    private let addDailyRoutineView = AddDailyRoutineView()
    private let dailyAddBottom = BottomSheetViewController(bottomStyle: .dailyAddBottom)
    
    // MARK: - Life Cycles
    
    override func loadView() {
        self.view = addDailyRoutineView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDailyThemes()
        setUI()
        setDelegate()
        setRegister()
        setAddTarget()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addDailyRoutineView.collectionView.setContentOffset(.init(x: 2 * (Const.itemSize.width + Const.itemSpacing) - Const.insetX, y: addDailyRoutineView.collectionView.contentOffset.y), animated: false)
    }
}

// MARK: - Extensions

private extension AddDailyRoutineViewController {
    
    func setUI() {
        dailyAddBottom.modalPresentationStyle = .overFullScreen
    }
    
    func setDelegate() {
        addDailyRoutineView.dailyRoutineThemeView.collectionView.delegate = self
        addDailyRoutineView.dailyRoutineThemeView.collectionView.dataSource = self
        addDailyRoutineView.collectionView.delegate = self
        addDailyRoutineView.collectionView.dataSource = self
        dailyAddBottom.buttonDelegate = self
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    func setAddTarget() {
        addDailyRoutineView.addButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        addDailyRoutineView.customNavigationBar.delegate = self
    }
    
    @objc
    func buttonTapped() {
        if let iconURL = URL(string: self.dailyThemesEntity.themes[selectedIndex].iconImageUrl) {
            self.dailyAddBottom.imageView.downloadedsvg(from: iconURL)
        }
        self.dailyAddBottom.subTitleLabel.text = "'\(dailyRoutinesEntity.routines[addDailyRoutineView.pageControl.currentPage + 2].content)'"
        self.present(dailyAddBottom, animated: false)
    }
    
    func setRegister() {
        DailyRoutineThemeCollectionViewCell.register(target: addDailyRoutineView.dailyRoutineThemeView.collectionView)
        DailyRoutineCardCollectionViewCell.register(target: addDailyRoutineView.collectionView)
    }
    
    func setCarousel() {
        addDailyRoutineView.pageControl.numberOfPages = dailyRoutinesEntity.routines.count
        dailyRoutinesEntity.routines.insert(dailyRoutinesEntity.routines[dailyRoutinesEntity.routines.count-1], at: 0)
        dailyRoutinesEntity.routines.insert(dailyRoutinesEntity.routines[dailyRoutinesEntity.routines.count-2], at: 0)
        dailyRoutinesEntity.routines.append(dailyRoutinesEntity.routines[2])
        dailyRoutinesEntity.routines.append(dailyRoutinesEntity.routines[3])
    }
    
    func setDismiss() {
        self.dismiss(animated: false)
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let keyWindow = windowScene.windows.first else {
            return
        }
        let nav = TabBarController()
        nav.selectedIndex = 0
        if let navController = nav.viewControllers?[0] as? UINavigationController,
           let dailyViewController = navController.viewControllers.first as? DailyRoutineViewController {
        }
        keyWindow.rootViewController = UINavigationController(rootViewController: nav)
    }
}

extension AddDailyRoutineViewController: BottomSheetButtonDelegate {
    func completeButtonTapped() { }
    
    func deleteButtonTapped() { }
    
    func addButtonTapped() {
        let index = addDailyRoutineView.pageControl.currentPage
        if dailyRoutinesEntity.routines.count == 0 {
            return
        }
        routineId = dailyRoutinesEntity.routines[index + 2].routineId
        postDailyMember(routineId: routineId)
    }
}

extension AddDailyRoutineViewController: UIGestureRecognizerDelegate {
    
    func setGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapBackButton))
        view.addGestureRecognizer(tapGesture)
    }
}
extension AddDailyRoutineViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == addDailyRoutineView.dailyRoutineThemeView.collectionView {
            return dailyThemesEntity.themes.count
        } else if collectionView == addDailyRoutineView.collectionView {
            return dailyRoutinesEntity.routines.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == addDailyRoutineView.dailyRoutineThemeView.collectionView {
            let cell = DailyRoutineThemeCollectionViewCell.dequeueReusableCell(collectionView: collectionView, indexPath: indexPath)
            if indexPath.row == selectedIndex {
                collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .init())
                cell.isSelected = true
            }
            cell.setDataBind(model: dailyThemesEntity.themes[indexPath.item])
            return cell
        } else if collectionView == addDailyRoutineView.collectionView {
            let cell = DailyRoutineCardCollectionViewCell.dequeueReusableCell(collectionView: collectionView, indexPath: indexPath)
            cell.setDataBind(model: dailyRoutinesEntity.routines[indexPath.row], imageURL: dailyThemesEntity.themes[selectedIndex].backgroundImageUrl)
            return cell
        }
        return UICollectionViewCell()
    }
}

extension AddDailyRoutineViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == addDailyRoutineView.dailyRoutineThemeView.collectionView {
            return CGSize(width: 56, height: 70)
        } else if collectionView == addDailyRoutineView.collectionView {
            return CGSize(width: Const.itemSize.width, height: 398)
        }
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == addDailyRoutineView.dailyRoutineThemeView.collectionView {
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .init())
            selectedIndex = indexPath.item
            themeId = dailyThemesEntity.themes[selectedIndex].themeId
            getDailyRoutinesAPI()
        } else if collectionView == addDailyRoutineView.collectionView { }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>
    ) {
        if scrollView == addDailyRoutineView.collectionView {
            let scrolledOffsetX = targetContentOffset.pointee.x + scrollView.contentInset.left
            let cellWidth = Const.itemSize.width + Const.itemSpacing
            let index = round(scrolledOffsetX / cellWidth)
            targetContentOffset.pointee = CGPoint(x: index * cellWidth - scrollView.contentInset.left, y: scrollView.contentInset.top)
        }
    }
}

extension AddDailyRoutineViewController: UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == addDailyRoutineView.collectionView {
            addDailyRoutineView.pageControl.currentPage = Int((scrollView.contentOffset.x - Const.insetX) / (Const.itemSize.width + Const.itemSpacing)) - 1
            let count = dailyRoutinesEntity.routines.count
            if scrollView.contentOffset.x-2 <= Const.itemSize.width + Const.itemSpacing - Const.insetX {
                scrollView.setContentOffset(.init(x: (Const.itemSize.width + Const.itemSpacing) * Double(count-3) - Const.insetX, y: scrollView.contentOffset.y), animated: false)
            }
            
            if scrollView.contentOffset.x+2 >= Double(count-2) * (Const.itemSize.width + Const.itemSpacing) - Const.insetX - Const.sideItem {
                scrollView.setContentOffset(.init(x: 2 * (Const.itemSize.width + Const.itemSpacing) - Const.insetX, y: scrollView.contentOffset.y), animated: false)
            }
        }
    }
}

extension AddDailyRoutineViewController: BackButtonProtocol {
    
    @objc
    func tapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Network

extension AddDailyRoutineViewController {
    
    func getDailyThemes() {
        AddDailyRoutineService.shared.getDailyThemesAPI { networkResult in
            switch networkResult {
            case .success(let data):
                if let data = data as? GenericResponse<DailyThemesEntity> {
                    if let listData = data.data {
                        self.dailyThemesEntity = listData
                    }
                    self.dailyThemesEntity.themes = self.dailyThemesEntity.themes.sorted(by: { $0.themeId < $1.themeId })
                    self.themeId = 1
                    self.addDailyRoutineView.dailyRoutineThemeView.collectionView.reloadData()
                    self.getDailyRoutinesAPI()
                }
            case .requestErr, .serverErr:
                break
            default:
                break
            }
        }
    }
    
    func getDailyRoutinesAPI() {
        AddDailyRoutineService.shared.getDailyRoutinesAPI(themes: self.themeId) { networkResult in
            switch networkResult {
            case .success(let data):
                if let data = data as? GenericResponse<DailyRoutinesEntity> {
                    if let listData = data.data {
                        self.dailyRoutinesEntity = listData
                    }
                    self.dailyRoutinesEntity.routines = self.dailyRoutinesEntity.routines.sorted(by: { $0.routineId < $1.routineId })
                    self.addDailyRoutineView.collectionView.reloadData()
                    self.setCarousel()
                }
            case .requestErr, .serverErr:
                break
            default:
                break
            }
        }
    }
    
    func postDailyMember(routineId: Int) {
        AddDailyRoutineService.shared.postDailyMember(routineId: routineId) { networkResult in
            switch networkResult {
            case .success(let data):
                if let data = data as? GenericResponse<DailyRoutineIdEntity> {
                    if data.data != nil {
                    }
                }
                self.setDismiss()
            case .requestErr, .serverErr:
                self.dismiss(animated: true)
            default:
                break
            }
        }
    }
}
