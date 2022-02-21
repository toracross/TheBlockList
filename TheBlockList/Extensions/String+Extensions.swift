//
//  String+Extensions.swift
//  TheBlockList
//
//  Created by Wellison Pereira on 2/21/22.
//

import Foundation

/// A basic string extension that provides number formatting.
/// This example was pulled from SO: https://stackoverflow.com/questions/14974331/string-to-phone-number-format-on-ios
extension String {
    public func phoneNumberFormat() -> String {
        return self.replacingOccurrences(of: "(\\d{3})(\\d{3})(\\d+)", with: "($1) $2-$3", options: .regularExpression, range: nil)
    }
}
