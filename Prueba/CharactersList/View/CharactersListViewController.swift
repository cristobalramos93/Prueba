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
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
    var viewModel: CharactersListViewModel?
    private var totalPages = 0
    private var myPage = 1
    private var subscriptions = Set<AnyCancellable>()
    private var animationView: LottieAnimationView?
    private var backgroundView: UIView?
    private var characterDetailViewController = CharacterDetailViewController.initFromNib()
    private var filteredData: [CharacterData] = []
    var charactersList: [CharacterData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        setTableView()
        setBackgroundView()
        viewModel?.loadCharacterList(page: myPage, characterList: charactersList)
    }
}

private extension CharactersListViewController {
    func setTableView() {
        searchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        let nib = UINib(nibName: "CharacterCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CharacterCell")
    }
    
    func bind() {
        bindShowCharacters()
        bindShowError()
    }
    
    func showCharacters(characterData: CharactersDataList) {
        let page = myPage
        myPage = page + 1
        charactersList = characterData.characterList
        filteredData = characterData.characterList
        totalPages = characterData.pages
        tableView.reloadData()
        tableView.isHidden = false
        animationView?.stop()
        animationView?.isHidden = true
        backgroundView?.isHidden = true
    }
    
    func bindShowCharacters() {
        viewModel?.showCharactersPublisher
            .sink { [weak self] characterData in
                if characterData.characterList.isEmpty {
                    self?.showLottieView("error")
                } else {
                    self?.showCharacters(characterData: characterData)
                }
            }
            .store(in: &subscriptions)
    }
    
    func bindShowError() {
        viewModel?.showErrorPublisher
            .sink { [weak self] _ in
                self?.showLottieView("error")
            }
            .store(in: &subscriptions)
    }
    
    func setBackgroundView() {
        backgroundView = UIView(frame: CGRect.zero)
        backgroundView?.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundView ?? UIView())
        backgroundView?.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        backgroundView?.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundView?.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundView?.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundView?.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        backgroundView?.isHidden = true
    }
    
    func showLottieView(_ json: String) {
        DispatchQueue.main.async {
            self.animationView = .init(name: json)
            self.animationView?.frame = self.view.bounds
            self.animationView?.contentMode = .scaleAspectFit
            self.animationView?.loopMode = .loop
            self.animationView?.animationSpeed = 0.5
            self.view.addSubview(self.animationView ?? LottieAnimationView())
            self.animationView?.play()
            self.animationView?.isHidden = false
            self.backgroundView?.isHidden = false
        }
    }
}

extension CharactersListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath) as? CharacterCell {
            cell.setup(imageUrl: filteredData[indexPath.row].image, name: filteredData[indexPath.row].name)
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        characterDetailViewController.modalPresentationStyle = .fullScreen
        present(characterDetailViewController, animated: true, completion: nil)
        characterDetailViewController.setupView(filteredData[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, willDisplay: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == charactersList.count - 1 && myPage != totalPages {
            showLottieView("load")
            viewModel?.loadCharacterList(page: myPage, characterList: charactersList)
        }
    }
}

extension CharactersListViewController: UISearchBarDelegate {
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = searchText.isEmpty ? charactersList : charactersList.filter { character in
            return character.name.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
}
