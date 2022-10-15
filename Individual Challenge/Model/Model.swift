//
//  Model.swift
//  Individual Challenge
//
//  Created by Mateus Calisto on 13/10/22.
//

import Foundation
import UIKit

struct User: Decodable {
    let id: Int
    let name: String
    let description: String?
    let language: String?
}
