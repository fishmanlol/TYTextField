//
//  _TextFieldDelegate.swift
//  TYTextField
//
//  Created by tongyi on 12/27/19.
//  Copyright © 2019 Yi Tong. All rights reserved.
//

import Foundation
protocol _TextFieldDelegate: class {
    func _textFieldPinCodeComplete(_ textField: _TextField)
    func _textFieldDidBecomeFirstResponder(_ textField: _TextField)
    func _textFieldDidResignFirstResponder(_ textField: _TextField)
}

extension _TextFieldDelegate {
    func _textFieldPinCodeComplete(_ textField: _TextField) {}
    func _textFieldDidBecomeFirstResponder(_ textField: _TextField) {}
    func _textFieldDidResignFirstResponder(_ textField: _TextField) {}
}
