//
//  Request.swift
//  Individual Challenge
//
//  Created by Mateus Calisto on 13/10/22.
//

import Foundation
import UIKit

struct API {
    static func searchUser(username: String, compeltion: @escaping([User]?) ->()) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.github.com"
        components.path = "/users/\(username)/repos"
        let url = components.url!
        
        let task = URLSession.shared.dataTask(with: url){(data, response, error) in
            guard let responseData = data else{ return }
            let response = response as! HTTPURLResponse
            if response.statusCode == 404 {
                compeltion(nil)
            }
            do {
                let repos = try JSONDecoder().decode([User].self, from: responseData)
                compeltion(repos)
                
            } catch let error {
                print("Erro: \(error)")
            }
        }
        task.resume()
    }
}
