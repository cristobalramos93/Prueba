//
//  CharactersListViewModel.swift
//  Prueba
//
//  Created by Cristobal Ramos on 12/6/23.
//

import Foundation
import Combine

class CharactersListViewModel {
    private var api: ApiRequest?
    let showCharactersPublisher = PassthroughSubject<CharactersDataList, Never>()
    let goToCharacterDetailPublisher = PassthroughSubject<CharacterData, Never>()
    let showErrorPublisher = PassthroughSubject<Void, Never>()
    let setTotalCharactersPublisher = PassthroughSubject<Int, Never>()
    var cancellable = Set<AnyCancellable>()
    
    init(api: ApiRequest) {
        self.api = api
    }
    
    func loadCharacterList(page: Int, characterList: [CharacterData]) {
        var list = characterList
        api?.fetchCharacterList(page)
            .sink(receiveCompletion: { result in
                switch result {
                case .failure:
                    self.showErrorPublisher.send()
                case .finished:
                    break
                }
            }, receiveValue: { data in
                list += data.characterList
                self.showCharactersPublisher.send(CharactersDataList(characterList: list, pages: data.pages))
            }).store(in: &cancellable)
    }
}
