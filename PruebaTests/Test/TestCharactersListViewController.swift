//
//  TestCharactersListViewController.swift
//  PruebaTests
//
//  Created by Cristobal Ramos on 13/6/23.
//

import XCTest
@testable import Prueba

class TestCharactersListViewController: XCTestCase {
    
    var viewModel: CharactersListViewModel!
    var charactersListViewController:  CharactersListViewController!
    var api: ApiMock!
    
    override func setUp() {
        super.setUp()
        api = ApiMock(json: "CharacterListJSON")
        charactersListViewController =  CharactersListViewController()
        charactersListViewController.loadView()
        viewModel = CharactersListViewModel(api: api)
    }
    
    override func tearDown() {
        api = nil
        viewModel = nil
        charactersListViewController = nil
        super.tearDown()
    }
    
    func test_Given_list_of_characters_When_JSON_is_loaded_Then_view_show_table_view_with_elements() throws {
        let expectation = expectation(description: "list")
        charactersListViewController.viewModel = viewModel
        charactersListViewController.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
            XCTAssertEqual(self.charactersListViewController.charactersList.count, 20)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 2.0)
    }
    
    func test_Given_empty_list_of_characters_When_JSON_is_loaded_Then_view_show_error_view() throws {
        let expectation = expectation(description: "empty")
        viewModel = CharactersListViewModel(api: ApiMock(json: "Empty"))
        charactersListViewController.viewModel = viewModel
        charactersListViewController.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
            XCTAssertEqual(self.charactersListViewController.charactersList.count, 0)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 2.0)
    }
}
