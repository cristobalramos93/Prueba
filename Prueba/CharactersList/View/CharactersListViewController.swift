//
//  CharactersListViewController.swift
//  Prueba
//
//  Created by Cristobal Ramos on 12/6/23.
//

import UIKit
import Combine
import Lottie

class CharactersListViewController: UIViewController {
    var charactersList: [CharacterData] = []
    @IBOutlet private weak var tableView: UITableView!
    var presenter: CharactersListViewModel?
    private var totalPages = 0
    private var myPage = 0
    private var subscriptions = Set<AnyCancellable>()
    private var animationView: LottieAnimationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lottieStartView()
        bindShowCharacters()
        self.setTableView()
        presenter?.loadCharacterList(page: 0, characterList: charactersList)
    }


}

private extension CharactersListViewController {
    func setTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        let nib = UINib(nibName: "CharacterCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "CharacterCell")
    }
    
    func bindShowCharacters() {
        presenter?.showCharactersPublisher
            .sink { [weak self] characterData in
                if characterData.characterList.isEmpty {
                    //self.showError()
                } else {
                    let page = self?.myPage
                    self?.myPage = (page ?? 0) + 1
                    self?.charactersList = characterData.characterList
                    self?.totalPages = characterData.pages
                    self?.tableView.reloadData()
                    self?.tableView.isHidden = false
                    //self.errorView.isHidden = true
                    //self.reloadButton.isHidden = true
                }
            }
            .store(in: &subscriptions)
    }
    
    func lottieStartView() {
        
        animationView = .init(name: "guns")
        animationView!.frame = view.bounds
        //animationView?.frame = CGRect(x: 0, y: 0, width: 320, height: 568)
        animationView!.contentMode = .scaleAspectFit
        animationView!.loopMode = .loop
        animationView!.animationSpeed = 0.5
        self.view.addSubview(animationView!)
        animationView!.play()
    }
}

extension CharactersListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.charactersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath) as? CharacterCell {
            cell.setup(imageUrl: self.charactersList[indexPath.row].image, name: self.charactersList[indexPath.row].name)
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //self.presenter?.loadCharacter(self.charactersList[indexPath.row].id)
    }
    
    func tableView(_ tableView: UITableView, willDisplay: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == charactersList.count - 1 && myPage != totalPages {
                //self.showLoading()
                //self.loadingView.isHidden = false
                presenter?.loadCharacterList(page: myPage + 1, characterList: charactersList) //{
                    //self.loadingView.isHidden = true
                    //self.dismissLoading()
                //}
        }
    }
}
