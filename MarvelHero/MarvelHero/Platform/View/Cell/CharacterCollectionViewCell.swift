//
//  CharacterCollectionViewCell.swift
//  MarvelHero
//
//  Created by Maria Donet Climent on 24/06/2020.
//  Copyright © 2020 MariaDonet. All rights reserved.
//

import UIKit
import SwiftyGif

class CharacterCollectionViewCell: UICollectionViewCell {
    static let ID = "CharacterCollectionViewCell"
    
    let gifExtension = "gif".uppercased()
    @IBOutlet weak var characterGifView: UIImageView!
    @IBOutlet weak var characterImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var imageWidthConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = .black
        self.nameLbl.textColor = .white
        descriptionLbl.textColor = .white
        DispatchQueue.main.async {
            self.imageWidthConstraint.constant = (UIScreen.main.bounds.width - 40)
        }
    }

}

extension CharacterCollectionViewCell: CharacterItemViewInterface {
    func set(imageUrl: String, imageExtension: String) {
        characterGifView.image = UIImage()
        characterImg.image = UIImage()
//        characterGifView.isHidden = (imageExtension.uppercased() != gifExtension)
//        characterImg.isHidden = (imageExtension.uppercased() == gifExtension)
//        if imageExtension.uppercased() == gifExtension {
//            guard let url = URL(string: imageUrl) else {
//                return
//            }
//            let loader = UIActivityIndicatorView(style: .large)
//            characterGifView.setGifFromURL(url, customLoader: loader)
//        } else {
//            characterImg.setImage(fromUrlString: imageUrl)
//        }
        characterImg.setImage(fromUrlString: imageUrl)
    }
    
    func set(name: String) {
        nameLbl.text = name
    }
    
    func set(description: String) {
        descriptionLbl.text = description
        descriptionLbl.sizeToFit()
    }
    
}
