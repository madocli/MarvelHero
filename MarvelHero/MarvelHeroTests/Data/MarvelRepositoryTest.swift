//
//  MarvelRepositoryTest.swift
//  MarvelHeroTests
//
//  Created by Maria Donet Climent on 21/06/2020.
//  Copyright © 2020 MariaDonet. All rights reserved.
//

import XCTest
@testable import MarvelHero

class MarvelRepositoryTest: XCTestCase {

    // MARK: - Test variables

    var sut: MarvelRepository!
    var remoteDataSource: RemoteDataSourceMock!
    
    override func setUp() {
        super.setUp()
        remoteDataSource = RemoteDataSourceMock()
        sut = MarvelRepository(remoteDataSource: self.remoteDataSource)
    }
    
    
    override func tearDown() {
        sut = nil
        remoteDataSource = nil
        super.tearDown()
    }
    
    // MARK: - Basic tes
    
    func test_sut_isntNil() {
        XCTAssertNotNil(sut)
    }
    
    // MARK: - Get correct DATA
    func test_initializationView_callRemoteDataSource_getsDataFromServiceSuccessfuly() {
        sut.fetchCharacters(offset: 0) { (result) in
            switch result {
            case let .success(t):
                XCTAssertEqual(3, t.data.results.count)
            case .failure(_):
                XCTAssert(false)
            }
        }
    }
    
    func test_initializationView_callRemoteDataSource_getsFailure() {
        remoteDataSource.didPetition = false
        sut.fetchCharacters(offset: 0) { (result) in
            switch result {
            case .success(_):
                XCTAssert(false)
            case let .failure(e):
                XCTAssertEqual("You must provide a hash.", e.message)
            }
        }
    }
    
    
    // MARK: - Stubs & Mocks.
    
    class RemoteDataSourceMock: MarvelRemoteDataSourceGateway {
        var didPetition = true
        func getCharacterst(offset: Int, handler: @escaping (Result<CharacterResponseModel, HeroErrorModel>) -> Void) {
            if didPetition {
                let jsonData = MarvelHeroData.jsonValue
                do {
                    let genericResponse = try JSONDecoder().decode(CharacterResponseModel.self, from: jsonData)
                    handler(.success(genericResponse))
                } catch {
                    print("ERROROOOOO ")
                    handler(.failure(HeroErrorModel(message: "Error decodding CharacerHeroModel")))

                }
            } else {
                handler(.failure(HeroErrorModel(message: "You must provide a hash.")))
            }
        }
    }
}
