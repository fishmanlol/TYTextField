//
//  String+.swift
//  TYTextField
//
//  Created by tongyi on 1/30/20.
//  Copyright © 2020 Yi Tong. All rights reserved.
//

import Foundation

extension String {
    func onlyNumber() -> String {
        return filter { $0.isNumber }
    }
}
