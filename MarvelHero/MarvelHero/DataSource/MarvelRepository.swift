//
//  MarvelRepository.swift
//  MarvelHero
//
//  Created by Maria Donet Climent on 23/06/2020.
//  Copyright © 2020 MariaDonet. All rights reserved.
//

import Foundation

class MarvelRepository {
    let remoteDataSource: MarvelRemoteDataSourceGateway
    
    init(remoteDataSource: MarvelRemoteDataSourceGateway) {
        self.remoteDataSource = remoteDataSource
    }
    
    func fetchCharacters(offset: Int, handler: @escaping (Result<CharacterResponseModel, HeroErrorModel>) -> Void) {
        remoteDataSource.getCharacterst(offset: offset, handler: handler)
    }
}
