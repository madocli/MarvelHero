//
//  MarvelHeroPresenter.swift
//  MarvelHero
//
//  Created by Maria Donet Climent on 24/06/2020.
//  Copyright © 2020 MariaDonet. All rights reserved.
//

import Foundation

class MarvelHeroPresenter {
    
    // MARK: - Properties
    private let interactor: MarvelHeroGateway
    weak var view: MarvelHeroViewInterface?
    
    // MARK: - DATA
    private var arrayHeros = [MarvelHeroEntity]()
    var numberOfItems: Int {
        return arrayHeros.count
    }
    // MARK: - Last item loaded
    var lastItemShown: Int?
    var isAtBottom = false
    
    // MARK: - Initialization
    init(interactor: MarvelHeroGateway) {
        self.interactor = interactor
    }
    
    func viewReady() {
        view?.loadingData()
        fetchHeros()
    }
    
    private func fetchHeros() {
        interactor.getMarvelHeroList(offset: arrayHeros.count) { [weak self] (result) in
            self?.view?.removeLoadingData()
            switch result {
            case let .success(t):
                for element in t {
                    self?.arrayHeros.append(element)
                }
                self?.view?.reloadData()
            case let .failure(e):
                self?.view?.show(error: e.message ?? "Something went wrong fetching data.")
            }
        }
    }
    
    private func positionToRepresent(row: Int) -> Int {
        var itemPosition = row
        if (isAtBottom && lastItemShown != nil) {
            itemPosition = lastItemShown!
            isAtBottom = false
        }
        return itemPosition
    }
    
    private func isLastItem(row: Int) {
        if row == arrayHeros.count - 1 {
            lastItemShown = row
            self.view?.loadingData()
            self.fetchHeros()
        }
    }
    
    func configure(cell: CharacterItemViewInterface, forRow row: Int) {
        if 0 <= row && row < arrayHeros.count {
            let itemPosition = positionToRepresent(row: row)
            
            let hero = arrayHeros[itemPosition]
            cell.set(name: hero.name ?? "")
            cell.set(description: hero.description ?? "")
            cell.set(imageUrl: hero.completeImageURL ?? "")
            
            isLastItem(row: row)
        }
    }
}
