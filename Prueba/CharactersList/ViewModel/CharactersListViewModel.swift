//
//  CharactersListViewModel.swift
//  Prueba
//
//  Created by Cristobal Ramos on 12/6/23.
//

import Foundation
import Combine

struct CharactersDataList {
    var characterList: [CharacterData]
    var pages: Int
}

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
    
//    func loadCharacter(_ id: Int) {
//        self.api?.fetchCharacter(id: id)
//                .sink(receiveCompletion: { result in
//                    switch result {
//                    case .failure: self.showErrorPublisher.send()
//                    case .finished: break
//                    }
//                }, receiveValue: { character in
//                    self.goToCharacterDetailPublisher.send(character)
//                }).store(in: &cancellable)
//    }
    
//    func viewDidLoad() {
//        self.loadCharacterList()
//    }
    
    func loadCharacterList(page: Int, characterList: [CharacterData]/*, completion: @escaping () -> Void*/) {
        var list = characterList
        self.api?.fetchCharacterList(page)
            .sink(receiveCompletion: { result in
                switch result {
                case .failure:
                    //completion()
                    self.showErrorPublisher.send()
                case .finished:
                    break
                }
            }, receiveValue: { data in
                //completion()
                list += data.characterList
                self.showCharactersPublisher.send(CharactersDataList(characterList: data.characterList, pages: data.pages))
            }).store(in: &cancellable)
    }
}

//private extension CharactersListPresenter {
//
//    func loadCharacterList() {
//        self.api?.fetchCharactersList(offset: 0)
//            .sink(receiveCompletion: { result in
//                switch result {
//                case .failure: self.showErrorPublisher.send()
//                case .finished: break
//                }
//            }, receiveValue: { data in
//                self.setTotalCharactersPublisher.send(data.total)
//                self.showCharactersPublisher.send(data.characterList)
//            }).store(in: &cancellable)
//    }
//}
