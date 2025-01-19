//
//  StatsChartView.swift
//  Sopetit-iOS
//
//  Created by ahra on 1/10/25.
//


import UIKit

final class StatsChartView: UIView {
    
     var achieveTheme: AchieveThemeEntity = AchieveThemeEntity.initalEntity(){
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    init(entity: AchieveThemeEntity) {
        self.achieveTheme = entity
        super.init(frame: .zero)
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func draw(_ rect: CGRect) {
        
        let center = CGPoint(x: rect.midX, y: rect.midY)
        
        var colors: [UIColor] = []
        var values: [CGFloat] = []
        
        for (index, theme) in achieveTheme.themes.enumerated() {
            values.append(CGFloat(theme.achievedCount))
            
            let baseColor = UIColor(named: "ThemeChart\(theme.id)") ?? UIColor()
            if index == 0 || theme.id == 0 {
                colors.append(baseColor)
            } else if index < 3 && theme.id == 1 {
                colors.append(baseColor.withAlphaComponent(0.4))
            } else {
                colors.append(baseColor.withAlphaComponent(0.7))
            }
        }
        
        let total = CGFloat(achieveTheme.achievedCount)
        
        var startAngle: CGFloat = (-(.pi) / 2)
        var endAngle: CGFloat = 0.0
        
        values.enumerated().forEach { (index, value) in
            endAngle = (value / total) * (.pi * 2)
            
            let path = UIBezierPath()
            path.move(to: center)
            path.addArc(withCenter: center,
                        radius: 71,
                        startAngle: startAngle,
                        endAngle: startAngle + endAngle,
                        clockwise: true)
            
            colors[index].setFill()
            path.fill()
            startAngle += endAngle
            path.close()
        }
        
        let semiCircle = UIBezierPath(arcCenter: center,
                                      radius: 36,
                                      startAngle: 0,
                                      endAngle: (360 * .pi) / 180,
                                      clockwise: true)
        UIColor.white.set()
        semiCircle.fill()
    }
}
