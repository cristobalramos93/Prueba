//
//  TestCharactersListViewModel.swift
//  PruebaTests
//
//  Created by Cristobal Ramos on 15/6/23.
//

import XCTest
import Combine
@testable import Prueba

class TestCharactersListViewModel: XCTestCase {
    var viewModel: CharactersListViewModel!
    var mockApi: ApiMock!
    var subscriptions: Set<AnyCancellable>!
    var characterData: CharactersDataList!
    var error: Bool!
    
    override func setUp() {
        super.setUp()
        characterData = CharactersDataList(characterList: [], pages: 1)
        error = false
        mockApi = ApiMock(json: "CharacterListJSON")
        viewModel = CharactersListViewModel(api: mockApi)
        subscriptions = Set<AnyCancellable>()
    }

    override func tearDown() {
        characterData = nil
        error = nil
        viewModel = nil
        mockApi = nil
        subscriptions = nil
        super.tearDown()
    }
    
    func bindShowCharacters() {
        viewModel?.showCharactersPublisher
            .sink { [weak self] characterData in
                self?.characterData = characterData
            }
            .store(in: &subscriptions)
    }
    
    func bindGetError() {
        viewModel?.showErrorPublisher
            .sink { [weak self] _ in
                self?.error = true
            }
            .store(in: &subscriptions)
    }

    func test_Given_characterList_When_The_List_Is_Empty_Then_The_20_Are_Added() {
        let expectation = expectation(description: "list")
        bindShowCharacters()
        viewModel.loadCharacterList(page: 1, characterList: [])
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
            XCTAssertEqual(self.characterData.characterList.count, 20)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 2.0)
    }
    
    func test_Given_characterList_When_One_Already_Exists_On_The_List_Then_The_20_And_The_Existing_One_Are_Added() {
        let expectation = expectation(description: "list")
        bindShowCharacters()
        viewModel.loadCharacterList(page: 1, characterList: [CharacterData(name: "", status: .alive, species: "", type: "", gender: .male, location: .init(name: "", url: ""), image: "", episode: [])])
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
            XCTAssertEqual(self.characterData.characterList.count, 21)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 2.0)
    }
    
    func test_Given_Error_JSON_When_The_List_Is_Empty_Then_Erro_is_True() {
        let expectation = expectation(description: "list")
        mockApi = ApiMock(json: "Empty")
        viewModel = CharactersListViewModel(api: mockApi)
        bindGetError()
        viewModel.loadCharacterList(page: 1, characterList: [])
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
            XCTAssertTrue(self.error)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 2.0)
    }
}
