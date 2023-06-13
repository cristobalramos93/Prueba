//
//  ResponseDTO.swift
//  Prueba
//
//  Created by Cristobal Ramos on 12/6/23.
//

import Foundation

// MARK: - Welcome
struct CharacterListDTO: Codable {
    let info: InfoDTO
    let results: [CharacterDTO]
}

// MARK: - Info
struct InfoDTO: Codable {
    let count, pages: Int
    let next, prev: String?
}

// MARK: - Result
struct CharacterDTO: Codable {
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

enum GenderDTO: String, Codable {
    case female = "Female"
    case genderless = "Genderless"
    case male = "Male"
    case unknown = "unknown"
}

// MARK: - Location
struct LocationDTO: Codable {
    let name: String
    let url: String
}

enum SpeciesDTO: String, Codable {
    case alien = "Alien"
    case human = "Human"
    case humanoid = "Humanoid"
    case mythologicalCreature = "Mythological Creature"
    case unknown = "unknown"
}

enum StatusDTO: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}
