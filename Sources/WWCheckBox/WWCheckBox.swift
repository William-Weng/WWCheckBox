//
//  Checkbox.swift
//  Example
//
//  Created by iOS on 2023/2/24.
//

import UIKit

public protocol WWCheckboxDelegate {
    func didTouched(_ checkbox: WWCheckBox, indexPath: IndexPath, isSelected: Bool)
}

@IBDesignable
open class WWCheckBox: UIView {
    
    @IBInspectable var isSelected: Bool = false
    @IBInspectable var isUsedAnimation: Bool = true
    
    @IBInspectable var borderWidth: CGFloat = 1.0
    @IBInspectable var lineWidth: CGFloat = 1.0
    @IBInspectable var animationDuration: CGFloat = 0.5
    
    @IBInspectable var startPointOffsetX: CGFloat = 0
    @IBInspectable var startPointOffsetY: CGFloat = 0
    @IBInspectable var cornerPointOffsetX: CGFloat = 0
    @IBInspectable var cornerPointOffsetY: CGFloat = 0
    @IBInspectable var endPointOffsetX: CGFloat = 0
    @IBInspectable var endPointOffsetY: CGFloat = 0
    
    @IBInspectable var borderColor: UIColor = .black
    @IBInspectable var lineColor: UIColor = .white
    @IBInspectable var checkedBackgroundColor: UIColor = .systemBlue
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var innerView: UIView!
    
    public var delegate: WWCheckboxDelegate?
    public var indexPath: IndexPath = []
    
    private let radius = 8.0
    private var checkBoxLayer: CAShapeLayer?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initViewFromXib()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        initViewFromXib()
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        tapAction()
    }
    
    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        initSetting()
        drawCheckBoxPath()
        checkStatusSetting(isSelected)
    }
    
    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        contentView?.prepareForInterfaceBuilder()
    }
    
    deinit { delegate = nil }
    
    @objc func didTouched(_ tapGestureRecognizer: UITapGestureRecognizer) {
        touchedAction(tapGestureRecognizer)
    }
}

// MARK: - WWCheckBox (public class function)
public extension WWCheckBox {
    
    /// ?????????????????????
    /// - Parameters:
    ///   - isSelected: Bool
    ///   - isUsedAnimation: Bool
    func selected(_ isSelected: Bool, isUsedAnimation: Bool = false) {
        
        checkBoxLayer?.removeAllAnimations()
        checkBoxLayer?.removeFromSuperlayer()
        checkStatusSetting(isSelected)
        self.isSelected = isSelected
        
        if !isSelected { return }
        if (!isUsedAnimation) { drawCheckBoxPath(); return }
        
        let info = CABasicAnimation._basicAnimation(fromValue: 0.0, toValue: 1.0, duration: animationDuration)
        drawCheckBoxPathWithAnimation(info: info)
    }
}

// MARK: - WWCheckBox (private class function)
private extension WWCheckBox {
    
    /// ??????Nib?????? => ??????View??????
    func initViewFromXib() {

        let bundle = Bundle.module
        let name = String(describing: WWCheckBox.self)
        
        bundle.loadNibNamed(name, owner: self, options: nil)
        contentView.frame = bounds
        
        addSubview(contentView)
    }

    /// ???????????????
    func initSetting() {
        contentView.layer.borderWidth = borderWidth
        contentView.layer.borderColor = borderColor.cgColor
        contentView.layer._maskedCorners(radius: radius)
        contentView.backgroundColor = .clear
    }
    
    /// ????????????????????????????????????
    /// - Parameter isChecked: Bool
    func checkStatusSetting(_ isChecked: Bool) {
        
        innerView.backgroundColor = (!isChecked) ? .clear : checkedBackgroundColor
        contentView.layer.borderWidth = (!isChecked) ? borderWidth : 0
        
        if (!isChecked) {
            checkBoxLayer?.removeAllAnimations()
            checkBoxLayer?.removeFromSuperlayer()
        }
    }
    
    /// ??????????????????
    /// - Parameter tapGestureRecognizer: UITapGestureRecognizer
    func touchedAction(_ tapGestureRecognizer: UITapGestureRecognizer) {
        
        guard let checkBox = tapGestureRecognizer.view as? WWCheckBox else { return }
        
        isSelected.toggle()
        delegate?.didTouched(checkBox, indexPath: indexPath, isSelected: isSelected)
        selected(isSelected, isUsedAnimation: isUsedAnimation)
    }
    
    /// ??????????????????
    func tapAction() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(Self.didTouched(_:)))
        addGestureRecognizer(tap)
    }
    
    /// ????????? + ??????
    func drawCheckBoxPathWithAnimation(info: Constant.BasicAnimationInformation) {
        drawCheckBoxPath()
        _ = checkBoxLayer?._addAnimationInformation(info)
    }
    
    /// ?????????
    func drawCheckBoxPath() {
        
        let path = checkBoxPathMaker()
        checkBoxLayer = CALayer._shape(with: path.cgPath, strokeColor: lineColor, fillColor: .clear, lineWidth: lineWidth)
        if let checkBoxLayer = checkBoxLayer { contentView.layer.addSublayer(checkBoxLayer) }
    }
    
    /// ????????????????????????
    /// - Returns: UIBezierPath
    func checkBoxPathMaker() -> UIBezierPath {
        
        let path = checkBoxPath(
            innerView: innerView,
            outerView: contentView,
            startPointOffset: CGPoint(x: startPointOffsetX, y: startPointOffsetY),
            cornerPointOffset: CGPoint(x: cornerPointOffsetX, y: cornerPointOffsetY),
            endPointOffset: CGPoint(x: endPointOffsetX, y: endPointOffsetY)
        )

        return path
    }
    
    /// ???????????????
    /// - Parameters:
    ///   - innerView: ?????????View
    ///   - outerView: ?????????View
    ///   - startPointOffset: ??????????????????
    ///   - cornerPointOffset: ????????????????????????
    ///   - endPointOffset: ??????????????????
    /// - Returns: UIBezierPath
    func checkBoxPath(innerView: UIView, outerView: UIView, startPointOffset: CGPoint, cornerPointOffset: CGPoint, endPointOffset: CGPoint) -> UIBezierPath {
        
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: innerView.frame.minX + startPointOffset.x, y: innerView.frame.midY + startPointOffset.y))
        path.addLine(to: CGPoint(x: innerView.frame.midX + cornerPointOffset.x, y: innerView.frame.maxY + cornerPointOffset.y))
        path.addLine(to: CGPoint(x: outerView.frame.maxX + endPointOffset.x, y: outerView.frame.minY + endPointOffset.y))
        
        return path
    }
}
