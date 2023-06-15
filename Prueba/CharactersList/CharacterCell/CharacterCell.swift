//
//  CharacterCell.swift
//  Prueba
//
//  Created by Cristobal Ramos on 12/6/23.
//

import Foundation
import UIKit
import Kingfisher

class CharacterCell: UITableViewCell {
    
    @IBOutlet private weak var characterImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        characterImageView.image = nil
    }
    
    func setup(imageUrl: String, name: String) {
        nameLabel.text = name
        characterImageView.layer.cornerRadius = characterImageView.frame.height / 2
        characterImageView.clipsToBounds = true
        characterImageView.contentMode = .scaleAspectFill
        let url = URL(string: imageUrl)
        characterImageView.kf.setImage(with: url)
    }
}
