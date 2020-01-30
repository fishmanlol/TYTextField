//
//  ViewController.swift
//  TYTextField
//
//  Created by werurty@163.com on 01/30/2020.
//  Copyright (c) 2020 werurty@163.com. All rights reserved.
//

import UIKit
import TYTextField

class ViewController: UIViewController {
    weak var stack: UIStackView!
    weak var pinCodeTF: TYPinCodeTextField!
    weak var normalTF: TYNormalTextField!
    weak var passwordTF: TYPasswordTextField!
    weak var mobileNumberTF: TYPhoneTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
    }
    
    private func setUp() {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalCentering
        view.addSubview(stack)
        
        stack.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(10)
            make.top.bottom.equalToSuperview().inset(100)
        }
        
        let normalTF = TYNormalTextField()
        normalTF.labelText = "Normal"
        normalTF.colorWhenEditing = .black
        normalTF.colorWhenNormal = .gray
        self.normalTF = normalTF
        stack.addArrangedSubview(normalTF)
        normalTF.snp.makeConstraints { (make) in
            make.height.equalTo(60)
        }
        
        
        let passwordTF = TYPasswordTextField()
        passwordTF.text = "123"
        self.passwordTF = passwordTF
        stack.addArrangedSubview(passwordTF)
        
        let pinCodeTF = TYPinCodeTextField(pinCodeCount: 6)
        pinCodeTF.lineLength = 10
        self.pinCodeTF = pinCodeTF
        stack.addArrangedSubview(pinCodeTF)
        pinCodeTF.snp.makeConstraints { (make) in
            make.height.equalTo(60)
        }
        
        let mobileNumberTF = TYPhoneTextField()
        mobileNumberTF.labelText = "Mobile Number"
        self.mobileNumberTF = mobileNumberTF
        mobileNumberTF.keyboardType = .numberPad
        mobileNumberTF.clearButtonMode = .always
        mobileNumberTF.colorWhenEditing = .black
        mobileNumberTF.colorWhenNormal = .gray
        stack.addArrangedSubview(mobileNumberTF)
        mobileNumberTF.snp.makeConstraints { (make) in
            make.height.equalTo(60)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(mobileNumberTF.isValidPhoneNumber)
        print(mobileNumberTF.phoneNumber)
    }
}

