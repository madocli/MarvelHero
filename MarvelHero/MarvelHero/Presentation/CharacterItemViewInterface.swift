//
//  CharacterItemViewInterface.swift
//  MarvelHero
//
//  Created by Maria Donet Climent on 24/06/2020.
//  Copyright © 2020 MariaDonet. All rights reserved.
//

import Foundation

protocol CharacterItemViewInterface: class {
    func set(imageUrl: String, imageExtension: String)
    func set(name: String)
    func set(description: String)
}
