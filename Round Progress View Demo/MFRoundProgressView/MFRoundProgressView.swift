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
    private var startAngle: CGFloat = CGFloat(-90 * M_PI / 180)
    private var endAngle: CGFloat = CGFloat(270 * M_PI / 180)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clearColor()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = UIColor.clearColor()
    }

    
    override func drawRect(rect: CGRect) {
        // General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        // Color Declarations
        let progressColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        let progressBackgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.4)
        let titleColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.8)
        
        // Shadow Declarations
        let innerShadow = UIColor.blackColor().colorWithAlphaComponent(0.22)
        let innerShadowOffset = CGSize(width: 3.1, height: 3.1)
        let innerShadowBlurRadius = CGFloat(4)
        
        // Background Drawing
        let backgroundPath = UIBezierPath(ovalInRect: CGRect(x: CGRectGetMinX(rect), y: CGRectGetMinY(rect), width: rect.width, height: rect.height))
        backgroundColor?.setFill()
        backgroundPath.fill()
        
        // Background Inner Shadow
        CGContextSaveGState(context);
        UIRectClip(backgroundPath.bounds);
        CGContextSetShadowWithColor(context, CGSizeZero, 0, nil);
        
        CGContextSetAlpha(context, CGColorGetAlpha(innerShadow.CGColor))
        CGContextBeginTransparencyLayer(context, nil)
        
        let opaqueShadow = innerShadow.colorWithAlphaComponent(1)
        CGContextSetShadowWithColor(context, innerShadowOffset, innerShadowBlurRadius, opaqueShadow.CGColor)
        CGContextSetBlendMode(context, CGBlendMode.SourceOut)
        CGContextBeginTransparencyLayer(context, nil)
        
        opaqueShadow.setFill()
        backgroundPath.fill()
        CGContextEndTransparencyLayer(context);
        
        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
        
        // ProgressBackground Drawing
        let kMFPadding = CGFloat(15)
        
        let progressBackgroundPath = UIBezierPath(ovalInRect: CGRect(x: CGRectGetMinX(rect) + kMFPadding/2, y: CGRectGetMinY(rect) + kMFPadding/2, width: rect.size.width - kMFPadding, height: rect.size.height - kMFPadding))
        progressBackgroundColor.setStroke()
        progressBackgroundPath.lineWidth = 5
        progressBackgroundPath.stroke()
        
        // Progress Drawing
        let progressRect = CGRect(x: CGRectGetMinX(rect) + kMFPadding/2, y: CGRectGetMinY(rect) + kMFPadding/2, width: rect.size.width - kMFPadding, height: rect.size.height - kMFPadding)
        let progressPath = UIBezierPath()
        progressPath.addArcWithCenter(CGPoint(x: CGRectGetMidX(progressRect), y: CGRectGetMidY(progressRect)), radius: CGRectGetWidth(progressRect) / 2, startAngle: startAngle, endAngle: (endAngle - startAngle) * (percent / 100) + startAngle, clockwise: true)
        progressColor.setStroke()
        progressPath.lineWidth = 4
        progressPath.lineCapStyle = CGLineCap.Round
        progressPath.stroke()
        
        // Text Drawing
        let textRect = CGRect(x: CGRectGetMinX(rect), y: CGRectGetMinY(rect), width: rect.size.width, height: rect.size.height)
        let textContent = NSString(string: "\(Int(percent))")
        let textStyle = NSMutableParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        textStyle.alignment = .Center
        
        let textFontAttributes = [
            NSFontAttributeName: UIFont(name: "HelveticaNeue-Light", size: rect.width / 3)!,
            NSForegroundColorAttributeName: titleColor,
            NSParagraphStyleAttributeName: textStyle]
        
        let textHeight = textContent.boundingRectWithSize(CGSize(width: textRect.width, height: textRect.height), options: .UsesLineFragmentOrigin, attributes: textFontAttributes, context: nil).height
        
        CGContextSaveGState(context)
        CGContextClipToRect(context, textRect)
        textContent.drawInRect(CGRect(x: CGRectGetMinX(textRect), y: CGRectGetMinY(textRect) + (CGRectGetHeight(textRect) - textHeight) / 2, width: CGRectGetWidth(textRect), height: textHeight), withAttributes: textFontAttributes)
        CGContextRestoreGState(context);
        
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
