//
//  Extension.swift
//  Example
//
//  Created by William.Weng on 2022/12/15.
//

import UIKit

// MARK: - CALayer (static function)
extension CALayer {
    
    /// Layer產生器
    /// - 含路徑 + 相關設定
    /// - Parameters:
    ///   - path: 繪圖的路徑
    ///   - strokeColor: 線的顏色
    ///   - fillColor: 背景色
    ///   - lineWidth: 線寬
    /// - Returns: CAShapeLayer
    static func _shape(with path: CGPath?, strokeColor: UIColor? = .black, fillColor: UIColor? = nil, lineWidth: CGFloat = 10) -> CAShapeLayer {
        
        let layer = CAShapeLayer()

        layer.path = path
        layer.lineWidth = lineWidth
        layer.strokeColor = strokeColor?.cgColor
        layer.fillColor = fillColor?.cgColor
        layer.lineCap = .round
        layer.lineJoin = .round

        return layer
    }
}

// MARK: - CALayer (class function)
extension CALayer {
    
    /// 加上動畫資訊
    /// - Parameters:
    ///   - info: (animation: T: CAAnimation, keyPath: Constant.AnimationKeyPath)
    /// - Returns: Self
    func _addAnimationInformation<T: CAAnimation>(_ info: (animation: T, keyPath: Constant.AnimationKeyPath)) -> Self {
        self.add(info.animation, forKey: info.keyPath.rawValue)
        return self
    }
    
    /// 設定圓角
    /// - 可以個別設定要哪幾個角
    /// - 預設是四個角全是圓角
    /// - Parameters:
    ///   - radius: 圓的半徑
    ///   - corners: 圓角要哪幾個邊
    func _maskedCorners(radius: CGFloat, corners: CACornerMask = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]) {
        self.masksToBounds = true
        self.maskedCorners = corners
        self.cornerRadius = radius
    }
}

// MARK: - CAAnimation (static function)
extension CAAnimation {
    
    /// [Layer動畫產生器 (CABasicAnimation)](https://jjeremy-xue.medium.com/swift-說說-cabasicanimation-9be31ee3eae0)
    /// - Parameters:
    ///   - keyPath: [要產生的動畫key值](https://blog.csdn.net/iosevanhuang/article/details/14488239)
    ///   - fromValue: [開始的值](https://blog.csdn.net/weixin_34072857/article/details/93332552)
    ///   - toValue: 結束的值
    ///   - duration: 動畫時間
    /// - Returns: Constant.CAAnimationInformation
    static func _basicAnimation(keyPath: Constant.AnimationKeyPath = .strokeEnd, fromValue: Any?, toValue: Any?, duration: CFTimeInterval = 1.0, repeatCount: Float = 1.0) -> Constant.BasicAnimationInformation {
        
        let animation = CABasicAnimation(keyPath: keyPath.rawValue)
        
        animation.fromValue = fromValue
        animation.toValue = toValue
        animation.duration = duration
        animation.repeatCount = repeatCount
        
        animation.autoreverses = false
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        
        return (animation, keyPath)
    }
}
