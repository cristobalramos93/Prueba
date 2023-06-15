//
//  CharacterDetailViewController.swift
//  Prueba
//
//  Created by Cristobal Ramos on 13/6/23.
//

import Foundation
import UIKit
import Kingfisher

class CharacterDetailViewController: UIViewController {
    
    @IBOutlet weak var returnImageView: UIImageView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet private weak var characterImageView: UIImageView!
    
    private var character: CharacterData?
    
    override func viewDidLoad() {
        setReturnImageView()
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
    
    func setupView(_ character: CharacterData) {
        self.character = character
        setViews()
        setImageView()
    }
}

private extension CharacterDetailViewController {
    func setViews() {
        addView(title: "Name", subtitle: character?.name ?? "Unknow")
        addView(title: "Status", subtitle: character?.status.rawValue ?? "Unknow")
        addView(title: "Species", subtitle: character?.species ?? "Unknow")
        addView(title: "Location", subtitle: character?.location.name ?? "Unknow")
        addView(title: "Gender", subtitle: character?.gender.rawValue ?? "Unknow")
        addView(title: "Episodes", subtitle: String(character?.episode.count ?? 0))
    }
    
    func addView(title: String, subtitle: String) {
        let episodeView: DetailView = UIView.fromNib()
        episodeView.setView(title: title, subtitle: subtitle)
        stackView.addArrangedSubview(episodeView)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    func setReturnImageView() {
        returnImageView.image = UIImage(named: "back")
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        returnImageView.isUserInteractionEnabled = true
        returnImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func setImageView() {
        guard let character = self.character else { return }
        characterImageView.layer.cornerRadius = characterImageView.frame.height / 2
        characterImageView.clipsToBounds = true
        characterImageView.contentMode = .scaleAspectFill
        let url = URL(string: character.image)
        characterImageView.kf.setImage(with: url)
    }
}
