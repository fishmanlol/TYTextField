//
//  Country.swift
//  TYTextField
//
//  Created by tongyi on 12/31/19.
//  Copyright © 2019 Yi Tong. All rights reserved.
//

import Foundation

struct Country {
    let code: Int
    let fullName: String
    let shortName: String
    
    static let `default` = Country(code: 1, fullName: "United States", shortName: "US")
    
    func shortNameAndCodeString() -> String {
        return "\(shortName) +\(code)"
    }
    
    func fullNameAndCodeString() -> String {
        return "\(fullName)(+\(code))"
    }
}

extension Country: Equatable {
    static func ==(lhs: Country, rhs: Country) -> Bool {
        return lhs.fullNameAndCodeString() == rhs.fullNameAndCodeString()
    }
}
