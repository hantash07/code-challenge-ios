//
//  NetworkManager.swift
//  code-challenge
//
//  Created by Hantash on 20/12/2021.
//

import UIKit
import Alamofire
import SwifterSwift

class NetworkManager: NSObject {
    
    private static func request(method: HTTPMethod, url: URL, callback: ((NetworkResponseDataModel<Any>) -> ())?) {
        
        Alamofire.request(url, method: method).responseJSON { (response) in
            let result = NetworkResponseDataModel<Any>.instanceFromDataResponse(response)
            callback?(result)
        }
    }
    
    public static func GET(endPoint: String, callback: ((NetworkResponseDataModel<Any>) -> ())?) {
        let url = URL.init(string: endPoint)
        NetworkManager.request(method: .get, url: url!, callback: callback)
    }
    
    public static func DOWNLOAD(endpoint: String, completion : @escaping (URL?) -> ()) {
        let destination: Alamofire.DownloadRequest.DownloadFileDestination = { _, _ in
            let documentsURL = FileManager.default.urls(for: .picturesDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent("image1.png")
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }

        Alamofire.download(endpoint, to: destination).response { response in
            if response.error == nil, let destinationURL = response.destinationURL {
                completion(destinationURL)
            } else {
                completion(nil)
            }
        }
    }
}

enum EnumNetworkAuthOptions: Int {
    case AUTH_NONE = 0b00000000
    case AUTH_REQUIRED = 0b00000001
    case AUTH_SHOULDUPDATE = 0b00000010
}
