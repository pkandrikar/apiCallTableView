//
//  User.swift
//  Assignment
//
//  Created by Sahil Saharkar on 3/1/22.
//

import Foundation

struct UserAPIResponse: Codable {
    var page : Int
    var per_page : Int
    var total : Int
    var total_pages : Int
    var data: [User]
}

struct User: Codable {
    var id : Int
    var email : String
    var first_name : String
    var last_name : String
    var avatar : String
}
