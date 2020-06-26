//
//  MarvelHeroViewInterface.swift
//  MarvelHero
//
//  Created by Maria Donet Climent on 24/06/2020.
//  Copyright © 2020 MariaDonet. All rights reserved.
//

import Foundation

protocol MarvelHeroViewInterface: class {
    func loadingData()
    func removeLoadingData()
    func reloadData()
    func show(error: String)
}
