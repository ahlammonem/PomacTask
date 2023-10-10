//
//  RepoModel.swift
//  PomacTask
//
//  Created by ahlam on 09/10/2023.
//

import Foundation

struct RepoModel : Codable {
    
    var id : Int?
    var name : String?
    var owner : OwnerModel?
}
