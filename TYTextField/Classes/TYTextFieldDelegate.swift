//
//  TYTextFieldDelegate.swift
//  TYTextField
//
//  Created by tongyi on 12/27/19.
//  Copyright © 2019 Yi Tong. All rights reserved.
//

import Foundation

public protocol TYTextFieldDelegate: class {
    func pinCodeTextFieldDidComplete(_ textField: TYPinCodeTextField)
    func textFieldDidEndEditing(_ textField: TYNormalTextField)
    func textFieldDidBeginEditing(_ textField: TYNormalTextField)
    func textFieldShouldReturn(_ textField: TYNormalTextField) -> Bool
    func textFieldShouldClear(_ textField: TYNormalTextField) -> Bool
    func textField(_ textField: TYNormalTextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    func textFieldShouldEndEditing(_ textField: TYNormalTextField) -> Bool
    func textFieldShouldBeginEditing(_ textField: TYNormalTextField) -> Bool
    func textFieldDidChangeSelection(_ textField: TYNormalTextField)
}

public extension TYTextFieldDelegate {
    func pinCodeTextFieldDidComplete(_ textField: TYPinCodeTextField) {}
    func textFieldDidEndEditing(_ textField: TYNormalTextField) {}
    func textFieldDidBeginEditing(_ textField: TYNormalTextField) {}
    func textFieldShouldReturn(_ textField: TYNormalTextField) -> Bool { return true }
    func textFieldShouldClear(_ textField: TYNormalTextField) -> Bool { return true }
    func textField(_ textField: TYNormalTextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool { return true }
    func textFieldShouldEndEditing(_ textField: TYNormalTextField) -> Bool { return true }
    func textFieldShouldBeginEditing(_ textField: TYNormalTextField) -> Bool { return true }
    func textFieldDidChangeSelection(_ textField: TYNormalTextField) {}
}
