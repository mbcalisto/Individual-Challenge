//
//  Model.swift
//  Individual Challenge
//
//  Created by Mateus Calisto on 13/10/22.
//

import Foundation
import UIKit

struct Owner: Decodable{
    let avatar_url: String
}

struct User: Decodable {
    let id: Int
    let name: String
    let description: String?
    let language: String?
    let owner: Owner
}

struct GitHubError: Decodable {
    let message: String
    let documentation_url: String
}
