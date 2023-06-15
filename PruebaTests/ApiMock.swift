//
//  ApiMock.swift
//  PruebaTests
//
//  Created by Cristobal Ramos on 13/6/23.
//

import Foundation
import Combine

@testable import Prueba

class ApiMock: ApiRequest {
    
    private var json: String
    
    init(json: String) {
        self.json = json
    }
    override func fetchCharacterList(_ page: Int) -> Future<CharactersDataList, Error> {
        Future<CharactersDataList, Error> { promise in
            var pages = 0
            var charactersList: [CharacterData] = []
            let decoder = JSONDecoder()
            let testBundle = Bundle(for: type(of: self))
            if let fileURL = testBundle.url(forResource: self.json, withExtension: "json") {
                do {
                    let data = try Data(contentsOf: fileURL)
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(CharacterListDTO.self, from: data)
                    charactersList = response.results.map {
                        return CharacterData(name: $0.name,
                                             status: $0.status,
                                             species: $0.species,
                                             type: $0.type,
                                             gender: $0.gender,
                                             location: $0.location,
                                             image: $0.image,
                                             episode: $0.episode)
                    }
                    pages = response.info.pages
                } catch let err {
                    promise(.failure(err))
                }
                DispatchQueue.main.async {
                    promise(.success(CharactersDataList(characterList: charactersList, pages: pages)))
                }
            }
        }
    }
}
