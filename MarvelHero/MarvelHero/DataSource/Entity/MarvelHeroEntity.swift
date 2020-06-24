//
//  MarvelHeroEntity.swift
//  MarvelHero
//
//  Created by Maria Donet Climent on 24/06/2020.
//  Copyright © 2020 MariaDonet. All rights reserved.
//

import Foundation

struct MarvelHeroEntity {
    let name: String?
    let description: String?
    let completeImageURL: String?
    
    init(characterResponse: CharacterResult) {
        self.name = characterResponse.name
        self.description = characterResponse.resultDescription
        self.completeImageURL = "\(characterResponse.thumbnail?.path ?? "")/portrait_fantastic\(characterResponse.thumbnail?.thumbnailExtension ?? "")"
    }
}
