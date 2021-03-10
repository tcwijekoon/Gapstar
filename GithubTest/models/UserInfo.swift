//
//  UserInfo.swift
//  GithubTest
//
//  Created by Thushara Wijekoon on 2021-03-09.
//

import Foundation
struct UserInfo: Codable {
    var name : String? = ""
    var loginName : String? = ""
    var email : String? = ""
    var noFollowings : Int? = 0
    var noFollowers : Int? = 0
    var avatar : String? = ""
}
