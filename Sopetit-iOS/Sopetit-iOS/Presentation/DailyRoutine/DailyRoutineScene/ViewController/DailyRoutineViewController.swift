//
//  DailyRoutineViewController.swift
//  Sopetit-iOS
//
//  Created by Minjoo Kim on 1/29/24.
//

import UIKit

final class DailyRoutineViewController: UIViewController {
    
    // MARK: - Properties
    
    private var dailyRoutineEntity = DailyRoutineEntity(routines: [])
    
    // MARK: - UI Components
    
    private let dailyRoutineView = DailyRoutineView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        self.view = dailyRoutineView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setHierarchy()
        setLayout()
        setDelegate()
    }
}

// MARK: - Extensions

extension DailyRoutineViewController {

    func setUI() {
        
    }
    
    func setHierarchy() {
        
    }
    
    func setLayout() {
        
    }
    
    func setDelegate() {
        
    }
    
    func setRegister() {
        DailyRoutineCollectionViewCell.register(target: dailyRoutineView.collectionView)
        DailyRoutineEmptyView.register(target: dailyRoutineView.collectionView)
    }
}

// MARK: - Network

extension DailyRoutineViewController {
    
    func getRoutineListAPI() {
        DailyRoutineService.shared.getRoutineListAPI { networkResult in
            switch networkResult {
            case .success(let data):
                if let data = data as? GenericResponse<DailyRoutineEntity> {
                    if let listData = data.data {
                        self.dailyRoutineEntity = listData
                    }
                    self.dailyRoutineView.collectionView.reloadData()
                }
            case .requestErr, .serverErr:
                break
            default:
                break
            }
        }
    }
    
    func deleteRoutineListAPI(routineIdList: String) {
        DailyRoutineService.shared.deleteRoutineListAPI(routineIdList: routineIdList) { networkResult in
            switch networkResult {
            case .success:
//                self.dailyFooterView.isUserInteractionEnabled = true
                self.dailyRoutineView.collectionView.reloadData()
            case .requestErr, .serverErr:
                break
            default:
                break
            }
        }
    }
    
    func patchRoutineAPI(routineId: Int) {
        DailyRoutineService.shared.patchRoutineAPI(routineId: routineId) { _ in
            for cell in self.dailyRoutineView.collectionView.visibleCells {
                if let dailyCell = cell as? ExDailyRoutineCollectionViewCell {
                    if dailyCell.tag == routineId {
                        if let index = self.dailyRoutineEntity.routines.firstIndex(where: { $0.routineID == routineId }) {
                            self.dailyRoutineEntity.routines[index].isAchieve = true
                        }
                    }
                }
            }
            self.dailyRoutineView.collectionView.reloadData()
        }
    }
}
