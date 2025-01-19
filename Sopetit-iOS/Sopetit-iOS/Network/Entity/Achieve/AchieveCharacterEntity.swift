//
//  AchieveCharacterEntity.swift
//  Sopetit-iOS
//
//  Created by ahra on 1/10/25.
//

import UIKit

struct AchieveCharacterEntity {
    let themeId: Int
    
    var characterImage: UIImage {
        return UIImage(named: "img_stats_\(themeId)") ?? UIImage()
    }
    
    var characterTitle: String {
        switch themeId {
        case 1: return "따뜻한 솜뭉치"
        case 2: return "편안한 솜뭉치"
        case 3: return "똑똑한 솜뭉치"
        case 4: return "에너지 솜뭉치"
        case 5: return "느긋한 솜뭉치"
        case 6: return "활력의 솜뭉치"
        case 7: return "다정한 솜뭉치"
        default: return ""
        }
    }
    
    var characterSub: String {
        switch themeId {
        case 1: return "다정다감해요"
        case 2: return "차분하고 성숙해요"
        case 3: return "꼼꼼하고 현실적이에요"
        case 4: return "밝고 긍정적이에요"
        case 5: return "차분하고 여유로워요"
        case 6: return "활발하고 힘이 넘쳐요"
        case 7: return "섬세하고 온화해요"
        default: return ""
        }
    }
}
