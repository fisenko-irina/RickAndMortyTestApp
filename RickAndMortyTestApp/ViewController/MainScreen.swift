//
//  MainScreen.swift
//  RickAndMortyTestApp
//
//  Created by Fisenko Irina on 21.11.2023.
//

import UIKit

final class MainScreen: UIViewController {
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: setupFlowLayout())
    private let network: RickAndMortyNetworkService! = RickAndMortyNetworkServiceImpl()
    private var page: Int = 1
    
    lazy var cachedDataSource: NSCache<AnyObject, UIImage> = {
        let cache = NSCache<AnyObject, UIImage>()
        return cache
    }()
    
    private var characters = [Character]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.collectionView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCollectionView()
        
        network.getCharacters(page: page) { [weak self] result in
            switch result {
            case .success(let characters):
                self?.characters = characters.results
            case .failure(let error):
                print(error.localizedDescription)
            }
            self?.page += 1
        }
    }
}

extension MainScreen {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    private func setupView() {
        view.backgroundColor = UIColor(named: "backgroundColor")
        navigationItem.hidesBackButton = true
        navigationItem.backButtonDisplayMode = .minimal
        navigationController?.navigationBar.barStyle = .black
    }

    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: "\(MainCollectionViewCell.self)")
        collectionView.register(HeaderCollection.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "\(HeaderCollection.self)")

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor(named: "backgroundColor")
        collectionView.showsVerticalScrollIndicator = false

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        return layout
    }
}

// MARK: - UICollectionViewDataSource
extension MainScreen: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        characters.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(MainCollectionViewCell.self)", for: indexPath) as? MainCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(text: characters[indexPath.item].name)
        
        if let image = cachedDataSource.object(forKey: indexPath.item as AnyObject) {
            cell.configure(image: image)
        } else {
            network.getAvatar(url: characters[indexPath.item].image) { [weak self] image in
                cell.configure(image: image)
                self?.cachedDataSource.setObject(image, forKey: indexPath.item as AnyObject)
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "\(HeaderCollection.self)", for: indexPath)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 300, height: 60)
    }
    
}

// MARK: - UICollectionViewDelegate
extension MainScreen: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        true
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = DetailsScreen(character: characters[indexPath.item], image: cachedDataSource.object(forKey: indexPath.item as AnyObject) ?? UIImage())
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        network.getCharacters(page: page) { [weak self] result in
            switch result {
            case .success(let characters):
                self?.characters += characters.results
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        page += 1
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MainScreen: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 16
        let numberOfColumns: CGFloat = 2
        let heightWidthRatio: CGFloat = 1.3
        let widthCell = (collectionView.bounds.size.width - spacing)/numberOfColumns
        let heightCell = widthCell * heightWidthRatio
        return CGSizeMake(widthCell, heightCell)
    }
}
