//
//  AddDailyRoutineViewController.swift
//  Sopetit-iOS
//
//  Created by Minjoo Kim on 1/13/24.
//

import UIKit

final class AddDailyRoutineViewController: UIViewController {
    
    // MARK: - Properties
    
    private let dailyRoutineTheme = DailyRoutineTheme.dummy()
    private var dailyRoutineCard = DailyRoutineCard.dummy()
    private var selectedIndex = 0
    
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
        
        setUI()
        setDelegate()
        setRegister()
        setAddTarget()
        setCarousel()
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
    }
    
    func setAddTarget() {
        addDailyRoutineView.addButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc
    func buttonTapped() {
        self.present(dailyAddBottom, animated: false)
    }
    
    func setRegister() {
        DailyRoutineThemeCollectionViewCell.register(target: addDailyRoutineView.dailyRoutineThemeView.collectionView)
        DailyRoutineCardCollectionViewCell.register(target: addDailyRoutineView.collectionView)
        
    }
    
    func setCarousel() {
        dailyRoutineCard.insert(dailyRoutineCard[dailyRoutineCard.count-1], at: 0)
        dailyRoutineCard.insert(dailyRoutineCard[dailyRoutineCard.count-2], at: 0)
        dailyRoutineCard.append(dailyRoutineCard[2])
        dailyRoutineCard.append(dailyRoutineCard[3])
    }
}

extension AddDailyRoutineViewController: BottomSheetButtonDelegate {
    func completeButtonTapped() {
        
    }
    
    func deleteButtonTapped() {
        
    }
    
    func addButtonTapped() {
        self.dismiss(animated: false)
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let keyWindow = windowScene.windows.first else {
            return
        }
        let nav = TabBarController()
        nav.selectedIndex = 0
        if let navController = nav.viewControllers?[0] as? UINavigationController,
           let dailyViewController = navController.viewControllers.first as? DailyViewController {
            dailyViewController.isFromAddDailyBottom = true
        }
        keyWindow.rootViewController = UINavigationController(rootViewController: nav)
    }
}

extension AddDailyRoutineViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == addDailyRoutineView.dailyRoutineThemeView.collectionView {
            return dailyRoutineTheme.count
        } else if collectionView == addDailyRoutineView.collectionView {
            return dailyRoutineCard.count
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
            cell.setDataBind(model: dailyRoutineTheme[indexPath.row])
            return cell
        } else if collectionView == addDailyRoutineView.collectionView {
            let cell = DailyRoutineCardCollectionViewCell.dequeueReusableCell(collectionView: collectionView, indexPath: indexPath)
            cell.setDataBind(model: dailyRoutineCard[indexPath.row], image: dailyRoutineTheme[selectedIndex].cardImage)
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
            selectedIndex = indexPath.row
            print(selectedIndex)
            addDailyRoutineView.collectionView.reloadData()
        } else if collectionView == addDailyRoutineView.collectionView {
            print(indexPath.row)
        }
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
            let count = dailyRoutineCard.count
            if scrollView.contentOffset.x-2 <= Const.itemSize.width + Const.itemSpacing - Const.insetX {
                scrollView.setContentOffset(.init(x: (Const.itemSize.width + Const.itemSpacing) * Double(count-3) - Const.insetX, y: scrollView.contentOffset.y), animated: false)
            }
            
            if scrollView.contentOffset.x+2 >= Double(count-2) * (Const.itemSize.width + Const.itemSpacing) - Const.insetX - Const.sideItem {
                scrollView.setContentOffset(.init(x: 2 * (Const.itemSize.width + Const.itemSpacing) - Const.insetX, y: scrollView.contentOffset.y), animated: false)
            }
        }
    }
}
