//
//  CharacterData.swift
//  Prueba
//
//  Created by Cristobal Ramos on 12/6/23.
//

import Foundation

struct CharacterData {
    let id: Int
    let name: String
    let status: StatusDTO
    let species: String
    let type: String
    let gender: GenderDTO
    let origin, location: LocationDTO
    let image: String
    let episode: [String]
    let url: String
    let created: String
}
