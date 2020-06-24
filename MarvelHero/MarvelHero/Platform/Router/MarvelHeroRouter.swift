//
//  MarvelHeroRouter.swift
//  MarvelHero
//
//  Created by Maria Donet Climent on 24/06/2020.
//  Copyright © 2020 MariaDonet. All rights reserved.
//

import UIKit

class MarvelHeroRouter {
    weak var viewController: UIViewController?
    
    static func createModule() -> ViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = ViewController.initFromStoryboard()
        let interactor = MarvelHeroInteractor(remoteDataSource: MarvelRemoteDataSource())
        let router = MarvelHeroRouter()
        let presenter = MarvelHeroPresenter(interactor: interactor)
        presenter.view = view
        view.presenter = presenter
        view.router = router
        router.viewController = view
        
        return view
    }
    
}
