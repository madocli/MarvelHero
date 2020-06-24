//
//  ViewController.swift
//  MarvelHero
//
//  Created by Maria Donet Climent on 21/06/2020.
//  Copyright © 2020 MariaDonet. All rights reserved.
//

import UIKit

class MarvelHeroViewController: UIViewController {
    static let ID = "MarvelHeroViewController"

    var presenter: MarvelHeroPresenter?
    var router: MarvelHeroRouter?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - LoadingView
    let spinner = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureCollectionView()
        configureSpinnerSize()
    }
    
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        // TODO: Configure collection cell
    }
    
    class func initFromStoryboard() -> MarvelHeroViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: MarvelHeroViewController.ID) as! MarvelHeroViewController
    }

    func configureSpinnerSize() {
        let size = CGFloat(60)
        spinner.frame = CGRect(x: (UIScreen.main.bounds.width - size) / 2,
                               y: (UIScreen.main.bounds.height - size - CGFloat(self.navigationController?.navigationBar.frame.height ?? 0.0)) / 2,
                               width: size,
                               height: size)
        spinner.style = .large
        spinner.color = .gray
        DispatchQueue.main.async {
            self.collectionView.addSubview(self.spinner)
        }
    }
}

extension MarvelHeroViewController: MarvelHeroViewInterface {
    func loadingData() {
        self.spinner.startAnimating()
    }
    
    func removeLoadingData() {
        self.spinner.stopAnimating()
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
    
    func show(error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension MarvelHeroViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.numberOfItems ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // TODO: Get collection view cell and configure with data
        return UICollectionViewCell()
    }
}
