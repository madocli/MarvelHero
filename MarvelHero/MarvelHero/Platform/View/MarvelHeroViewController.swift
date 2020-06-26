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
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - LoadingView
    let spinner = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewReady()
        configureCollectionView()
        configureSpinnerSize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Marvel Hero"
    }
    
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .lightGray
        let nibCell = UINib(nibName: CharacterCollectionViewCell.ID, bundle: nil)
        collectionView.register(nibCell, forCellWithReuseIdentifier: CharacterCollectionViewCell.ID)
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.ID, for: indexPath) as! CharacterCollectionViewCell
        presenter?.configure(cell: cell, forRow: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.selected(row: indexPath.row)
    }
}

//MARK: CollectionView - FlowLayout
extension MarvelHeroViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.bounds.width - 15)
        return CGSize(width: size, height: 500)
    }
}
