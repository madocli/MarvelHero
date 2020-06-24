//
//  MarvelHeroGateway.swift
//  MarvelHero
//
//  Created by Maria Donet Climent on 24/06/2020.
//  Copyright © 2020 MariaDonet. All rights reserved.
//

import Foundation

protocol MarvelHeroGateway {
    func getMarvelHeroList(offset: Int, handler: @escaping (Result<[MarvelHeroEntity], HeroErrorModel>) -> Void)
}
