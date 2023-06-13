//
//  CharacterCell.swift
//  openBank
//
//  Created by Cristobal Ramos on 3/3/22.
//

import Foundation
import UIKit
import Kingfisher

class CharacterCell: UITableViewCell {
    
    @IBOutlet private weak var characterImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.characterImageView.image = nil
    }
    
    func setup(imageUrl: String, name: String) {
        nameLabel.text = name
        characterImageView.layer.cornerRadius = self.characterImageView.frame.height / 2
        characterImageView.clipsToBounds = true
        characterImageView.contentMode = .scaleAspectFill
        let url = URL(string: imageUrl)
        characterImageView.kf.setImage(with: url)
    }
}
