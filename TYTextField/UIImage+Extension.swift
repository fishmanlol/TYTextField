//
//  UIImage+Extension.swift
//  TYTextField
//
//  Created by tongyi on 2018/5/10.
//  Copyright © 2018年 tongyi. All rights reserved.
//

import UIKit

extension UIImage {
    
    
    static var correctSymbol: UIImage? {
        let frameworkBundle = Bundle(for: TYTextField.self)
        let imagePath = frameworkBundle.path(forResource: "correctSymbol.png", ofType: nil) ?? ""
        return UIImage(contentsOfFile: imagePath)
    }
    
    static var errorSymbol: UIImage? {
        let frameworkBundle = Bundle(for: TYTextField.self)
        let imagePath = frameworkBundle.path(forResource: "errorSymbol.png", ofType: nil) ?? ""
        return UIImage(contentsOfFile: imagePath)
    }
}
