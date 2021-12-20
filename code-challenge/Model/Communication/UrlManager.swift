//
//  UrlManager.swift
//  code-challenge
//
//  Created by Hantash on 20/12/2021.
//

import Foundation

class UrlManager: NSObject {
    
    class PhotoAPI {
        public static func photos() -> String {
            return String.init(format: "%@photos", UtilsGeneral.baseUrl)
        }
    }
    
}
