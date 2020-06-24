//
//  ViewController.swift
//  MarvelHero
//
//  Created by Maria Donet Climent on 21/06/2020.
//  Copyright © 2020 MariaDonet. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    static let ID = "ViewController"

    var presenter: MarvelHeroPresenter?
    var router: MarvelHeroRouter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    class func initFromStoryboard() -> ViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: ViewController.ID) as! ViewController
    }

}

extension ViewController: MarvelHeroViewInterface {
    func loadingData() {
        // TODO: ***
    }
    
    func removeLoadingData() {
        // TODO: ****
    }
    
    func reloadData() {
        // TODO: ****
    }
    
    func show(error: String) {
        // TODO: ****
    }
    
}
