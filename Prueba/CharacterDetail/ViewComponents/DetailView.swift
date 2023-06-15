//
//  DetailView.swift
//  Prueba
//
//  Created by Cristobal Ramos on 13/6/23.
//

import Foundation
import UIKit

class DetailView: UIView {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    
    func setView(title: String, subtitle: String) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        titleLabel.textColor = .gray
    }
}
