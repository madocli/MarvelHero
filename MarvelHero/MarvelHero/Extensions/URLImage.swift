//
//  URLImage.swift
//  MarvelHero
//
//  Created by Maria Donet Climent on 25/06/2020.
//  Copyright © 2020 MariaDonet. All rights reserved.
//

import UIKit

extension UIImageView {
    func setImage(fromUrlString urlString: String) {
        guard let url = URL(string: urlString) else {
            image = UIImage()
            return
        }

        DispatchQueue.global().async { [weak self] in
            do {
                let data = try Data(contentsOf: url)
                DispatchQueue.main.async {
                    self?.image = UIImage(data: data) ?? UIImage()
                }
            } catch {
                DispatchQueue.main.async {
                    self?.image = UIImage()
                }
            }
        }
    }
}
