//
//  MarvelHeroRouter.swift
//  MarvelHero
//
//  Created by Maria Donet Climent on 24/06/2020.
//  Copyright © 2020 MariaDonet. All rights reserved.
//

import UIKit

protocol MarvelHeroWireframeProtocol: class {
    func navigateToDetailView(url: String, name: String)
}

class MarvelHeroRouter: MarvelHeroWireframeProtocol {
    weak var viewController: UIViewController?
    
    static func createModule() -> MarvelHeroViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = MarvelHeroViewController.initFromStoryboard()
        let interactor = MarvelHeroInteractor(remoteDataSource: MarvelRemoteDataSource())
        let router = MarvelHeroRouter()
        let presenter = MarvelHeroPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    
    
    func navigateToDetailView(url: String, name: String) {
        self.viewController?.navigationController?.pushViewController(WebViewController(loadURL: url, name: name), animated: true)
    }
}
