//
//  UtilsString.swift
//  code-challenge
//
//  Created by Hantash on 20/12/2021.
//

import Foundation

class UtilsString: NSObject {
    
    public static func parseString(_ value: Any?) -> String! {
        guard let _ = value else {
            return ""
        }
        if let _ = value as? NSNull {
            return ""
        }
        return value as? String ?? ""
    }
    
    public static func parseString(_ value: Any?, DefaultValue defaultValue: String) -> String! {
        guard let _ = value else {
            return defaultValue
        }
        if let _ = value as? NSNull {
            return defaultValue
        }
        return value as? String ?? defaultValue
    }
    
    public static func parseInt(_ value: Any?, DefaultValue defaultValue: Int?) -> Int! {
        let defValue: Int! = defaultValue ?? 0
        if let _ = value as? NSNull {
            return defValue
        }
        guard let _ = value else {
            return defValue
        }
        
        if let v = value as? Int {
            return v
        }
        
        let valueString = String.init(format: "%@", value! as! CVarArg)
        if let v = Int(valueString) {
            return v
        }
        return defValue
    }
    
    public static func parseDouble(_ value: Any?, DefaultValue defaultValue: Double?) -> Double! {
        let defValue: Double! = defaultValue ?? 0
        if let _ = value as? NSNull {
            return defValue
        }
        guard let _ = value else {
            return defValue
        }
        
        if let v = value as? Double {
            return v
        }
        
        let valueString = String.init(format: "%@", value! as! CVarArg)
        if let v = Double(valueString) {
            return v
        }
        return defValue
    }
    
    public static func parseFloat(_ value: Any?, DefaultValue defaultValue: Float?) -> Float! {
        let defValue: Float! = defaultValue ?? 0
        if let _ = value as? NSNull {
            return defValue
        }
        guard let _ = value else {
            return defValue
        }
        
        if let v = value as? Float {
            return v
        }
        
        let valueString = String.init(format: "%@", value! as! CVarArg)
        if let v = Float(valueString) {
            return v
        }
        return defValue
    }
    
    public static func parseBool(_ value: Any?, DefaultValue defaultValue: Bool?) -> Bool! {
        let defValue: Bool! = defaultValue ?? false
        if let _ = value as? NSNull {
            return defValue
        }
        guard let _ = value else {
            return defValue
        }
        
        if let v = value as? Bool {
            return v
        }
        
        let valueString = String.init(format: "%@", value! as! CVarArg)
        if let v = Bool(valueString) {
            return v
        }
        return defValue
    }
    
    public static func padLeadnigZerosForTwoDigits(_ value: Int) -> String {
        if value > 9 {
            return String.init(format: "%d", value)
        }
        return String.init(format: "0%d", value)
    }
    
    public static func generateRandomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0...length - 1).map{ _ in letters.randomElement()! })
    }
    
    public static func stripNonNumericsFromString(_ text: String?) -> String {
        guard let text = text else {
            return ""
        }
        return text.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
    }
    
    public static func beautifyPhoneNumber(_ phone: String) -> String {
        var text = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result: [Character] = []
        
        var idx = 0
        var charIndex = 0
        let phoneFormat = "(###) ###-####"
        
        if text.count > 10 {
            text = String(text.suffix(10))
        }
        
        while idx < phoneFormat.count && charIndex < text.count {
            let index = phoneFormat.index(phoneFormat.startIndex, offsetBy: idx)
            let character = phoneFormat[index]
            if character == "#" {
                let charIndexItem = text.index(text.startIndex, offsetBy: charIndex)
                let strp = text[charIndexItem]
                charIndex += 1
                result.append(strp)
            } else {
                result.append(character)
            }
            idx += 1
        }
        return String(result)
    }
    
    public static func beautifyCCN(ccn: String?, isLast4: Bool) -> String {
        guard let ccn = ccn else {
            return ""
        }
        
        if isLast4 == true {
            // ••••    ••••    ••••    4444
            let last4 = String(ccn.suffix(4))
            return String.init(format: "••••    ••••    ••••    %@", last4)
        }
        else {
            let refinedCCN = UtilsString.stripNonNumericsFromString(ccn)
            var x = 0
            var array: [String]! = []
            while x < refinedCCN.count {
                let startIndex = refinedCCN.index(refinedCCN.startIndex, offsetBy: x)
                let endIndex = refinedCCN.index(refinedCCN.startIndex, offsetBy: (min(x + 4, refinedCCN.count)))
                let range = startIndex..<endIndex
                let comp = refinedCCN[range]
                array.append(String(comp))
                x = x + 4
            }
            return array.joined(separator: "    ")
        }
    }
    
    public static func beautifyAmount(_ amount: Float?) -> String {
        // return $1,234,567.89
        
        guard let amount = amount else {
            return "$0.00"
        }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "$"
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        
        return formatter.string(from: NSNumber(value: amount)) ?? "$0.00"
    }
    
    public static func beautifyDistance(distance: Float?) -> String {
        guard let feet = distance else {
            return "N/A"
        }
        
        if feet < 0.0001 {
            return "N/A"
        }
        
        if feet < 0.01 {
            return ">0.1 ft"
        }
        
        let miles: Float = feet / 5280.0
        if miles > 0.5 {
            return String.init(format: "%.1f mi", miles)
        }
        else {
            return String.init(format: "%.1f ft", feet)
        }
        
    }
    
    enum ErrorCode: String {
        case USER_LOGIN_INVALIDCREDENTIALS = "INVALID_CREDENTIALS_ERROR"
    }
}
