//
//  Constant.swift
//  Example
//
//  Created by William.Weng on 2022/12/15.
//

import Foundation
import QuartzCore

// MARK: - Constant
final class Constant {
    typealias BasicAnimationInformation = (animation: CABasicAnimation, keyPath: Constant.AnimationKeyPath) // Basic動畫資訊
}

// MARK: - typealias
extension Constant {
    
    /// [動畫路徑 (KeyPath)](https://stackoverflow.com/questions/44230796/what-is-the-full-keypath-list-for-cabasicanimation)
    enum AnimationKeyPath: String {
        
        case strokeEnd = "strokeEnd"
        case position = "position"
    }
}
