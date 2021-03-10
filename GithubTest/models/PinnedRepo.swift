//
//  PinnedRepo.swift
//  GithubTest
//
//  Created by Thushara Wijekoon on 2021-03-09.
//

import Foundation
struct PinnedRepo: Codable {
    var name : String? = ""
    var nameWithOwner : String? = ""
    var primaryLanguage : String? = ""
    var repoDescription : String? = ""
    var stargazerCount : Int? = 0
}
