//
//  MarvelHeroPresenterTest.swift
//  MarvelHeroTests
//
//  Created by Maria Donet Climent on 23/06/2020.
//  Copyright © 2020 MariaDonet. All rights reserved.
//

import XCTest
@testable import MarvelHero

class MarvelHeroPresenterTest: XCTestCase {
    // TODO: ******
    let imageSizeFormat = "/portrait_uncanny"
    // MARK: - Test Variables.
    var sut: MarvelHeroPresenter!
    var interactor: MarvelHeroGatewayMock!
    var view: MarvelHeroViewInterfaceMock!
    var router: MarvelHeroRouterMock!
    
    // MARK: - Set up and tear down.
    override func setUp() {
        super.setUp()
        interactor = MarvelHeroGatewayMock()
        view = MarvelHeroViewInterfaceMock()
        router = MarvelHeroRouterMock()
        sut = MarvelHeroPresenter(view: view, interactor: interactor, router: router)
    }
    
    override func tearDown() {
        sut = nil
        interactor = nil
        view = nil
        router = nil
        super.tearDown()
    }
    
    // MARK: - Basic test.
    func testSutIsntNil() {
        XCTAssertNotNil(sut)
    }
    
    // MARK: - functionality
    func test_viewReady_initialApp_invokesInteractorGetMarvelHeroList() {
        sut.viewReady()
        XCTAssertEqual(1, interactor.getMarvelHeroWasInvoked)
    }
    
    func test_viewReady_initialApp_invokesViewToShowLoadingData() {
        sut.viewReady()
        XCTAssertEqual(1, view.loadingDataWasInvoked)
    }
    
    func test_viewReady_failsToLoadData_showMessage() {
        interactor.didPetition = false
        sut.viewReady()
        XCTAssertEqual("Error loading data, try again in a moment.", view.errorShowed)
    }
    
    func test_viewReady_getData_removeLoadingView() {
        sut.viewReady()
        XCTAssertEqual(1, view.removeLoadingDataWasInvoked)
    }
    
    func test_viewReady_getData_callViewToReloadData() {
        sut.viewReady()
        XCTAssertEqual(1, view.reloadDataWasInvoked)
    }
    
    // MARK: - Fetched Data
    func test_viewReady_fetchData_getNumberOfItems() {
        sut.viewReady()
        XCTAssertEqual(1, sut.numberOfItems)
    }
    
    // MARK: - Configure Item View
    func test_sutConfigureCell_displayFetchData() {
        sut.viewReady()
        let cell = CharacterItemViewInterfaceMock()
        sut.configure(cell: cell, forRow: 0)
        XCTAssertEqual("Aegis (Trey Rollins)", cell.setedName)
        XCTAssertEqual("Some description from Aegis", cell.setedDescription)
        XCTAssertEqual("http://i.annihil.us/u/prod/marvel/i/mg/5/e0/4c0035c9c425d/portrait_uncanny.gif", cell.setedImageURL)
    }
    
    // MARK: - Fetch more data
    func test_viewScrollsToBottom_fetchMoreData_interactorGetMajorOffset() {
        interactor.jsonData = MarvelHeroData.multipleCharactersJson
        sut.viewReady()
        let cell = CharacterItemViewInterfaceMock()
        sut.configure(cell: cell, forRow: 3)
        XCTAssertEqual(4, interactor.offset)
    }
    
    func test_viewScrollsToBottom_fetchMoreData_invokesViewShowLoading() {
        sut.viewReady()
        interactor.jsonData = MarvelHeroData.multipleCharactersJson
        let cell = CharacterItemViewInterfaceMock()
        sut.configure(cell: cell, forRow: 0)
        XCTAssertEqual(2, view.loadingDataWasInvoked)
    }
    
    func test_viewScrollsToBottom_fetchMoreData_invokesViewRemoveLoading() {
        sut.viewReady()
        interactor.jsonData = MarvelHeroData.multipleCharactersJson
        let cell = CharacterItemViewInterfaceMock()
        sut.configure(cell: cell, forRow: 0)
        XCTAssertEqual(2, view.removeLoadingDataWasInvoked)
    }
    
    func test_viewScrollsToBottom_fetchMoreData_invokesReloadView() {
        sut.viewReady()
        interactor.jsonData = MarvelHeroData.multipleCharactersJson
        let cell = CharacterItemViewInterfaceMock()
        sut.configure(cell: cell, forRow: 0)
        XCTAssertEqual(2, view.reloadDataWasInvoked)
    }
    
    // MARK: - Selected item at
    func test_userSelectsItem_invokesToNavigate() {
        interactor.jsonData = MarvelHeroData.multipleCharactersJson
        sut.viewReady()
        sut.selected(row: 2)
        XCTAssertEqual(1, router.navigateToDetailWasInvoked)
    }
    
    func test_userSelectsItem_invokesShowErrors() {
        interactor.jsonData = MarvelHeroData.multipleCharactersJson
        sut.viewReady()
        sut.selected(row: 1)
        XCTAssertEqual("This Hero has no wiki details", view.errorShowed)
    }
    
    func test_userSelectsItem_invokesToNavigateWithNameAndUrl() {
        sut.viewReady()
        sut.selected(row: 0)
        XCTAssertEqual("Aegis (Trey Rollins)", router.setedName)
        XCTAssertEqual("http://marvel.com/universe/Aegis_%28Trey_Rollins%29?utm_campaign=apiRef&utm_source=e320a3aac9434b8366a3334560055c48", router.setedURL)
    }
    
    func test_userSelectsItem_outOfRange_doNotInvokesToNavigate() {
        sut.viewReady()
        sut.selected(row: 1)
        XCTAssertEqual(0, router.navigateToDetailWasInvoked)
    }
    
    // MARK: - Stubs & Mocks.
    
    class MarvelHeroGatewayMock: MarvelHeroGateway {
        var didPetition = true
        var getMarvelHeroWasInvoked = 0
        var offset = 0
        var jsonData = MarvelHeroData.singleCharacterJson
        func getMarvelHeroList(offset: Int, handler: @escaping (Result<[MarvelHeroEntity], HeroErrorModel>) -> Void) {
            getMarvelHeroWasInvoked += 1
            self.offset = offset
            if didPetition {
                do {
                    let arrayCharacters = try JSONDecoder().decode([CharacterResult].self, from: jsonData)
                    var arrayMarvelHeroEntity = [MarvelHeroEntity]()
                    for character in arrayCharacters {
                        arrayMarvelHeroEntity.append(MarvelHeroEntity(characterResponse: character))
                    }
                    handler(.success(arrayMarvelHeroEntity))
                } catch {
                    handler(.failure(HeroErrorModel(message: "Error decodding CharacerResult")))
                }
            } else {
                handler(.failure(HeroErrorModel(message: "Error loading data, try again in a moment.")))
            }
        }
    }
    
    class MarvelHeroViewInterfaceMock: MarvelHeroViewInterface {
        var loadingDataWasInvoked = 0
        var removeLoadingDataWasInvoked = 0
        var reloadDataWasInvoked = 0
        var errorShowed = ""
        
        func loadingData() {
            loadingDataWasInvoked += 1
        }
        
        func removeLoadingData() {
            removeLoadingDataWasInvoked += 1
        }
        
        func reloadData() {
            reloadDataWasInvoked += 1
        }
        
        func show(error: String) {
            errorShowed = error
        }
    }
    
    class CharacterItemViewInterfaceMock: CharacterItemViewInterface {
        var setedImageURL = ""
        var setedName = ""
        var setedDescription = ""
        
        func set(imageUrl: String, imageExtension: String) {
            setedImageURL = imageUrl
        }
        
        func set(name: String) {
            setedName = name
        }
        
        func set(description: String) {
            setedDescription = description
        }
    }
    
    class MarvelHeroRouterMock: MarvelHeroWireframeProtocol {
        var setedURL = ""
        var setedName = ""
        var navigateToDetailWasInvoked = 0
        func navigateToDetailView(url: String, name: String) {
            navigateToDetailWasInvoked += 1
            setedURL = url
            setedName = name
        }
    }
}
