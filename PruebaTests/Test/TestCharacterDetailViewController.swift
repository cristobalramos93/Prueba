//
//  TestCharacterDetailViewController.swift
//  PruebaTests
//
//  Created by Cristobal Ramos on 13/6/23.
//

import XCTest
@testable import Prueba

class TestCharacterDetailViewController: XCTestCase {
    
    var characterDetailViewController: CharacterDetailViewController!
    var character: CharacterData!
    
    override func setUp() {
        super.setUp()
        characterDetailViewController =  CharacterDetailViewController()
        characterDetailViewController.loadView()
        character = CharacterData(name: "",
                                  status: .alive,
                                  species: "",
                                  type: "",
                                  gender: .male,
                                  location: LocationDTO(name: "", url: ""),
                                  image: "",
                                  episode: [])
        characterDetailViewController.setupView(character)
    }
    
    override func tearDown() {
        character = nil
        characterDetailViewController = nil
        super.tearDown()
    }
    
    func test_Given_one_character_When_view_is_loaded_Then_stackView_has_6_elements() throws {
        XCTAssertEqual(characterDetailViewController.stackView.arrangedSubviews.count, 6)
    }
    
    func test_Given_one_character_When_view_is_loaded_Then_returnImageView_is_not_nil() throws {
        characterDetailViewController.viewDidLoad()
        XCTAssertNotNil(characterDetailViewController.returnImageView)
    }
    
    func test_Given_one_character_When_view_WillDisappear_Then_stackView_has_0_elements() throws {
        characterDetailViewController.viewWillDisappear(true)
        XCTAssertEqual(characterDetailViewController.stackView.arrangedSubviews.count, 0)
    }
}
