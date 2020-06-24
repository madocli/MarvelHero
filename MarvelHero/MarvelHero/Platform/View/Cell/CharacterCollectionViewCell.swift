//
//  CharacterCollectionViewCell.swift
//  MarvelHero
//
//  Created by Maria Donet Climent on 24/06/2020.
//  Copyright © 2020 MariaDonet. All rights reserved.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {
    static let ID = "CharacterCollectionViewCell"
    
    @IBOutlet weak var characterImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

extension CharacterCollectionViewCell: CharacterItemViewInterface {
    func set(imageUrl: String) {
        // TODO : ****
    }
    
    func set(name: String) {
        nameLbl.text = name
    }
    
    func set(description: String) {
        descriptionLbl.text = description
        descriptionLbl.sizeToFit()
    }
    
}
