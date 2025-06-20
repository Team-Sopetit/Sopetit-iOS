//
//  SettingAlarmSwitch.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 6/20/25.
//

import Foundation
import UIKit

final class SettingAlarmSwitch: UISwitch {
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        if let url = URL(string: UIApplication.openSettingsURLString),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        return false
    }
}
