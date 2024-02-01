//
//  MakeAlert.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 2023/12/29.
//

import UIKit

extension UIViewController {
    
    func makeSessionExpiredAlert() {
        makeVibrate()
        let alertViewController = UIAlertController(
            title: I18N.SessionExpiredAlert.title,
            message: I18N.SessionExpiredAlert.message,
            preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default) { _ in
            self.moveToLoginView()
        }
        alertViewController.addAction(okAction)
        self.present(alertViewController, animated: true, completion: nil)
    }
    
    private func moveToLoginView() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let keyWindow = windowScene.windows.first else {
            return
        }
        
        let nav = UINavigationController(rootViewController: LoginViewController())
        keyWindow.rootViewController = nav
    }
}
