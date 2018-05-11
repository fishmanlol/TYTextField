//
//  TYTextField.swift
//  TYTextField
//
//  Created by tongyi on 2018/5/10.
//  Copyright © 2018年 tongyi. All rights reserved.
//

import UIKit

public class TYTextField: UITextField {
    
    // MARK: Variables here
    public var defaultColor = UIColor.black.cgColor
    public var activeColor = UIColor(red: 68/255.0, green: 192/255.0, blue: 1.0, alpha: 1.0).cgColor
    
    lazy var bottomLine: CALayer = {
        let layer = CALayer()
        layer.borderColor = self.defaultColor
        layer.borderWidth = 1.0
        return layer
    }()
    
    lazy var rightImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    // MARK: Public functions
    public func showErrorHint() {
        rightImageView.image = UIImage.errorSymbol
        self.rightView = rightImageView
        
    }
    
    public func showCorrectHint() {
        rightImageView.image = UIImage.correctSymbol
        self.rightView = rightImageView
    }
    
    public func clearHint() {
        rightImageView.image = nil
        self.rightView = rightImageView
    }
    
    // MARK: Init functions
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextField()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupTextField()
    }
    
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        setRightImageViewBounds()
        setBottomLineFrame()
    }
    
    // Highlight when active
    override public func becomeFirstResponder() -> Bool {
        super.becomeFirstResponder()
        self.bottomLine.borderColor = activeColor
        return true
    }
    
    override public func resignFirstResponder() -> Bool {
        super.resignFirstResponder()
        self.bottomLine.borderColor = defaultColor
        return true
    }
    
    // MARK: Private functions
    private func setBottomLineFrame() {
        let x: CGFloat = 0
        let y: CGFloat = self.bounds.height  - 1
        let width: CGFloat = self.bounds.width - (self.rightView?.bounds.width ?? 0)
        let height: CGFloat = 1.0
        
        bottomLine.frame = CGRect(x: x, y: y, width: width, height: height)
    }
    
    private func setRightImageViewBounds() {
        let width: CGFloat = self.bounds.height * 0.75
        let height: CGFloat = width
        rightImageView.bounds = CGRect(x: 0, y: 0, width: width, height: height)
    }
    
    private func setupTextField() {
        self.rightViewMode = .always
        self.clearHint()
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
        self.tintColor = UIColor(red: 68/255.0, green: 192/255.0, blue: 1.0, alpha: 1.0)
        self.borderStyle = .none
        self.layer.addSublayer(bottomLine)
    }
}
