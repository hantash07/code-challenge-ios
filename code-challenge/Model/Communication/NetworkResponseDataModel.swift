//
//  NetworkResponseDataModel.swift
//  code-challenge
//
//  Created by Hantash on 20/12/2021.
//

import UIKit
import Alamofire

class NetworkResponseDataModel<T> : NSObject {
    
    var payload: [[String: Any]] = [[:]]
    var parsedObject: T? = nil
    var code: Int! = EnumNetworkResponseCode.CODE_200_OK.rawValue
    
    var errorMessage: String = ""
    var errorCode: String = ""
    
    func initialize() {
        self.payload = [[:]]
        self.parsedObject = nil
        self.code = EnumNetworkResponseCode.CODE_200_OK.rawValue
        
        self.errorMessage = ""
        self.errorCode = ""
    }
    
    func isSuccess() -> Bool {
        return (self.code == EnumNetworkResponseCode.CODE_200_OK.rawValue || self.code == EnumNetworkResponseCode.CODE_201_CREATED.rawValue || self.code == EnumNetworkResponseCode.CODE_204_NOCONTENT.rawValue)
    }
    
    func isTokenExpired() -> Bool {
        return (self.code == EnumNetworkResponseCode.CODE_403_FORBIDDEN.rawValue) && (self.errorCode.caseInsensitiveCompare("ExpiredTokenError") == .orderedSame)
    }
    
    func getBeautifiedErrorMessage() -> String {
        if self.isSuccess() {
            return ""
        }
        if self.errorMessage != "" {
            return self.errorMessage
        }
        return "Sorry, we've encountered an unknown error."
    }
    
    static func instanceFromDataResponse(_ response: DataResponse<Any>) -> NetworkResponseDataModel<Any> {
        
        let modelResponse = NetworkResponseDataModel<Any>()
        if let JSON = response.result.value as? [[String: Any]] {
            modelResponse.payload = JSON
            
//            if let error = UtilsString.parseString(JSON["error"]) {
//                modelResponse.errorMessage = error
//            }
//            if let message = UtilsString.parseString(JSON["message"]) {
//                modelResponse.errorMessage = message
//            }
//            if let code = UtilsString.parseString(JSON["name"]) {
//                modelResponse.errorCode = code
//            }
        }
        
        modelResponse.code = response.response?.statusCode
        return modelResponse
    }
    
    static func instanceForFailure() -> NetworkResponseDataModel<T> {
        let instance = NetworkResponseDataModel<T>()
        instance.code = EnumNetworkResponseCode.CODE_400_BADREQUEST.rawValue
        return instance
    }
    
    static func instanceForSuccess() -> NetworkResponseDataModel<T> {
        let instance = NetworkResponseDataModel<T>()
        return instance
    }
}

enum EnumNetworkResponseCode: Int {
    case CODE_200_OK = 200
    case CODE_201_CREATED = 201
    case CODE_204_NOCONTENT = 204
    case CODE_400_BADREQUEST = 400
    case CODE_401_UNAUTHORIZED = 401
    case CODE_403_FORBIDDEN = 403
    case CODE_404_NOTFOUND = 404
    case CODE_500_SERVERERROR = 500
}
