//
//  MFRoundProgressView.swift
//  components
//
//  Created by Marius Fanu on 26/01/15.
//  Copyright (c) 2015 Alecs Popa. All rights reserved.
//

import UIKit

@IBDesignable
class MFRoundProgressView: UIView {
    
    @IBInspectable var percent:CGFloat = 50.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    private var startAngle = CGFloat(-90 * Double.pi / 180)
    private var endAngle = CGFloat(270 * Double.pi / 180)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        backgroundColor = .clear
    }

    override func draw(_ rect: CGRect) {
        // General Declarations
        guard let context = UIGraphicsGetCurrentContext() else {
            print("Error getting context")
            return
        }
        
        // Color Declarations
        let progressColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        let progressBackgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.4)
        let titleColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.8)
        
        // Shadow Declarations
        let innerShadow = UIColor.black.withAlphaComponent(0.22)
        let innerShadowOffset = CGSize(width: 3.1, height: 3.1)
        let innerShadowBlurRadius = CGFloat(4)
        
        // Background Drawing
        let backgroundPath = UIBezierPath(ovalIn: CGRect(x: rect.minX, y: rect.minY, width: rect.width, height: rect.height))
        backgroundColor?.setFill()
        backgroundPath.fill()
        
        // Background Inner Shadow
        context.saveGState();
        UIRectClip(backgroundPath.bounds);
        context.setShadow(offset: CGSize.zero, blur: 0, color: nil);
        
        context.setAlpha(innerShadow.cgColor.alpha)
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        
        let opaqueShadow = innerShadow.withAlphaComponent(1)
        context.setShadow(offset: innerShadowOffset, blur: innerShadowBlurRadius, color: opaqueShadow.cgColor)
        context.setBlendMode(CGBlendMode.sourceOut)
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        
        opaqueShadow.setFill()
        backgroundPath.fill()
        context.endTransparencyLayer();
        
        context.endTransparencyLayer();
        context.restoreGState();
        
        // ProgressBackground Drawing
        let kMFPadding = CGFloat(15)
        
        let progressBackgroundPath = UIBezierPath(ovalIn: CGRect(x: rect.minX + kMFPadding/2, y: rect.minY + kMFPadding/2, width: rect.size.width - kMFPadding, height: rect.size.height - kMFPadding))
        progressBackgroundColor.setStroke()
        progressBackgroundPath.lineWidth = 5
        progressBackgroundPath.stroke()
        
        // Progress Drawing
        let progressRect = CGRect(x: rect.minX + kMFPadding/2, y: rect.minY + kMFPadding/2, width: rect.size.width - kMFPadding, height: rect.size.height - kMFPadding)
        let progressPath = UIBezierPath()
        progressPath.addArc(withCenter: CGPoint(x: progressRect.midX, y: progressRect.midY), radius: progressRect.width / 2, startAngle: startAngle, endAngle: (endAngle - startAngle) * (percent / 100) + startAngle, clockwise: true)
        progressColor.setStroke()
        progressPath.lineWidth = 4
        progressPath.lineCapStyle = CGLineCap.round
        progressPath.stroke()
        
        // Text Drawing
        let textRect = CGRect(x: rect.minX, y: rect.minY, width: rect.size.width, height: rect.size.height)
        let textContent = NSString(string: "\(Int(percent))")
        let textStyle = NSMutableParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        textStyle.alignment = .center
        
        let textFontAttributes = [
            NSAttributedStringKey.font: UIFont(name: "HelveticaNeue-Light", size: rect.width / 3)!,
            NSAttributedStringKey.foregroundColor: titleColor,
            NSAttributedStringKey.paragraphStyle: textStyle]
        
        let textHeight = textContent.boundingRect(with: CGSize(width: textRect.width, height: textRect.height), options: .usesLineFragmentOrigin, attributes: textFontAttributes, context: nil).height
        
        context.saveGState()
        context.clip(to: textRect)
        textContent.draw(in: CGRect(x: textRect.minX, y: textRect.minY + (textRect.height - textHeight) / 2, width: textRect.width, height: textHeight), withAttributes: textFontAttributes)
        context.restoreGState();
    }
}
