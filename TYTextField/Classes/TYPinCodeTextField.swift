//
//  TYPinCodeTextField.swift
//  TYTextField
//
//  Created by Yi Tong on 12/23/19.
//  Copyright © 2019 Yi Tong. All rights reserved.
//

import Foundation

public class TYPinCodeTextField: TYNormalTextField {
    override func createTextField(frame: CGRect) -> _TextField {
        let tf = _TextField(frame: frame, type: .pinCode, pinCodeCount: pinCodeCount)
        return tf
    }
    
    public let pinCodeCount: UInt
    
    public var lineLength: CGFloat {
        get {
            return _textField.lineLength
        }
        
        set {
            _textField.lineLength = newValue
        }
    }
    
    public var fontSize: CGFloat = 17.0 {
        didSet {
            _textField._font = UIFont.monospacedDigitSystemFont(ofSize: fontSize, weight: fontWeight)
        }
    }
    
    public var fontWeight: UIFont.Weight = .regular {
        didSet {
            _textField._font = UIFont.monospacedDigitSystemFont(ofSize: fontSize, weight: fontWeight)
        }
    }
    
    public override var tintColor: UIColor! {
        didSet {
            _textField.tintColor = tintColor
        }
    }
    //MARK: - Initializations
    public init(pinCodeCount: UInt, frame: CGRect = CGRect.zero) {
        self.pinCodeCount = pinCodeCount
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    //MARK: - Helper
    private func setUp() {
        autocorrectionType = .no
        keyboardType = .numberPad
        if #available(iOS 12.0, *) {
            textContentType = .oneTimeCode
        }
    }
}
