//
//  MarvelHeroInteractor.swift
//  MarvelHero
//
//  Created by Maria Donet Climent on 23/06/2020.
//  Copyright © 2020 MariaDonet. All rights reserved.
//

import Foundation

class MarvelHeroInteractor {
    let remoteDataSource: MarvelRemoteDataSourceGateway
    
    init(remoteDataSource: MarvelRemoteDataSourceGateway) {
        self.remoteDataSource = remoteDataSource
    }
}

extension MarvelHeroInteractor: MarvelHeroGateway {
    func getMarvelHeroList(offset: Int, handler: @escaping (Result<[MarvelHeroEntity], HeroErrorModel>) -> Void) {
        remoteDataSource.getCharacterst(offset: offset) { (result) in
            switch result {
            case let .success(t):
                var arrayCharacters = [MarvelHeroEntity]()
                for element in t.data.results {
                    arrayCharacters.append(MarvelHeroEntity(characterResponse: element))
                }
                handler(.success(arrayCharacters))
            case let .failure(e):
                handler(.failure(e))
            }
        }
    }
}
