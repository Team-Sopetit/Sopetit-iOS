//
//  HappyRoutineTag.swift
//  Sopetit-iOS
//
//  Created by Minjoo Kim on 1/10/24.
//

import Foundation

struct HappyRoutineTag {
    static func dummy() -> [String] {
        return [I18N.HappyRoutineCategory.all,
                I18N.HappyRoutineCategory.relationship,
                I18N.HappyRoutineCategory.aStep,
                I18N.HappyRoutineCategory.rest,
                I18N.HappyRoutineCategory.new,
                I18N.HappyRoutineCategory.mind]
    }
}
