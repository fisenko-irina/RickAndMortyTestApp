//
//  DetailsScreen.swift
//  RickAndMortyTestApp
//
//  Created by Fisenko Irina on 21.11.2023.
//

import UIKit

final class DetailsScreen: UIViewController {
    private let imageLabel = UIImageView()
    private let nameLabel = UILabel()
    private let statusLabel = UILabel()
    private let detailsTable = UITableView(frame: .zero, style: .grouped)
    private let network = RickAndMortyNetworkServiceImpl()
    private var image = UIImage()
    
    private var character: Character {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.detailsTable.reloadData()
            }
        }
    }
    
    init(character: Character, image: UIImage) {
        self.character = character
        self.image = image
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()


    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
            return .lightContent
        }
}

private extension DetailsScreen {
    func commonInit() {
        setupView()
        setupImageLabel()
        setupNameLabel()
        setupStatusLabel()
        setupDetailsTable()
    }
    func setupView() {
        view.backgroundColor = UIColor(named: "backgroundColor")
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barStyle = .black
    }
    func setupImageLabel() {
        view.addSubview(imageLabel)
        imageLabel.translatesAutoresizingMaskIntoConstraints = false
        imageLabel.image = image
        imageLabel.clipsToBounds = true
        imageLabel.layer.cornerRadius = 16
        
        NSLayoutConstraint.activate([
            imageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageLabel.widthAnchor.constraint(equalToConstant: 148),
            imageLabel.heightAnchor.constraint(equalToConstant: 148)
        ])
    }
    func setupNameLabel() {
        view.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textAlignment = .center
        nameLabel.textColor = .white
        nameLabel.font = UIFont(name: "gilroy-bold", size: 22)
        nameLabel.text = character.name
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: imageLabel.bottomAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    func setupStatusLabel() {
        view.addSubview(statusLabel)
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.textAlignment = .center
        statusLabel.statusColor(character: character)
        statusLabel.font = UIFont(name: "gilroy-medium", size: 16)
        statusLabel.text = character.status.rawValue
        NSLayoutConstraint.activate([
            statusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            statusLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16),
            statusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            statusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    func setupDetailsTable() {
        view.addSubview(detailsTable)
        detailsTable.translatesAutoresizingMaskIntoConstraints = false
        detailsTable.register(InfoCell.self, forCellReuseIdentifier: "\(InfoCell.self)")
        detailsTable.register(OriginCell.self, forCellReuseIdentifier: "\(OriginCell.self)")
        detailsTable.register(EpisodesCell.self, forCellReuseIdentifier: "\(EpisodesCell.self)")
        detailsTable.dataSource = self
        detailsTable.delegate = self
        detailsTable.backgroundColor = UIColor(named: "backgroundColor")
        detailsTable.separatorStyle = .none
        detailsTable.showsVerticalScrollIndicator = false
        detailsTable.allowsSelection = false
        detailsTable.layer.cornerRadius = 16
        detailsTable.clipsToBounds = true
        NSLayoutConstraint.activate([
            detailsTable.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 24),
            detailsTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            detailsTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            detailsTable.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - UITableViewDataSource
extension DetailsScreen: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel?.textColor = .white
            header.textLabel?.font = UIFont(name: "gilroy-semi-bold", size: 17)
            header.textLabel?.text = header.textLabel?.text?.capitalized
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Info"
        case 1: return "Origin"
        case 2: return "Episodes"
        default: return nil
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return 1
        case 2: return character.episode.count
        default: return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(InfoCell.self)", for: indexPath) as? InfoCell else { fatalError() }
            cell.configure(character: character)
            return cell
        case 1: guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(OriginCell.self)", for: indexPath) as? OriginCell else { fatalError() }
            cell.configure(character: character)
            network.getLocation(string: character.origin.url) { result in
                switch result {
                case.success(let planet):
                    DispatchQueue.main.async {
                        cell.configure(planet: planet)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            return cell
        case 2: guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(EpisodesCell.self)", for: indexPath) as? EpisodesCell else { fatalError() }
            network.getEpisode(url: character.episode[indexPath.row]) { result in
                switch result {
                case .success(let episode):
                    DispatchQueue.main.async {
                        cell.configure(episode: episode)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            return cell
        default: return UITableViewCell()
        }
    }
}
// MARK: - UITableViewDelegate
extension DetailsScreen: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0: return 124
        case 1: return 80
        case 2: return 100
        default: return 100
        }
    }
}
