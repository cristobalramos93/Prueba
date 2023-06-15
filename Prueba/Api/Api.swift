//
//  Api.swift
//  Prueba
//
//  Created by Cristobal Ramos on 12/6/23.
//

import Foundation

class API {
    let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    func performRequest(_ completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
