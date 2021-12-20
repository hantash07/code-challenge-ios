//
//  PhotoDataModel.swift
//  code-challenge
//
//  Created by Hantash on 20/12/2021.
//

import Foundation

class PhotoDataModel {
    var albumId: Int! = 0
    var id: Int! = 0
    var title: String! = ""
    var url: String! = ""
    var thumbnailUrl: String! = ""
    
    func initialize() {
        albumId = 0
        id = 0
        title = ""
        url = ""
        thumbnailUrl = ""
    }
    
    func deserialize(dictionary: [String: Any]?) {
        initialize()
        guard let dictionary = dictionary else {
            return
        }
        
        albumId = UtilsString.parseInt(dictionary["albumId"], DefaultValue: 0)
        id = UtilsString.parseInt(dictionary["id"], DefaultValue: 0)
        title = UtilsString.parseString(dictionary["title"])
        url = UtilsString.parseString(dictionary["url"])
        thumbnailUrl = UtilsString.parseString(dictionary["thumbnailUrl"])
    }
}
