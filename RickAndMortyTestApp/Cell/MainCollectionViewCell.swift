//
//  MainCollectionViewCell.swift
//  RickAndMortyTestApp
//
//  Created by Fisenko Irina on 21.11.2023.
//

import UIKit

final class MainCollectionViewCell: UICollectionViewCell {
    private let imageCell = UIImageView()
    private let labelCell = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(image: UIImage?) {
        imageCell.image = image
    }
    
    func configure(text: String?) {
        labelCell.text = text
    }
    private func commonInit() {
        setupImage()
        setupLabel()
        setupCell()
    }
    private func setupImage() {
        self.contentView.addSubview(imageCell)
        imageCell.translatesAutoresizingMaskIntoConstraints = false
        imageCell.layer.cornerRadius = 10
        imageCell.clipsToBounds = true
        imageCell.contentMode = .scaleToFill
        
        NSLayoutConstraint.activate([
            imageCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            imageCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            imageCell.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            imageCell.heightAnchor.constraint(equalTo: imageCell.widthAnchor)
        ])
    }
    private func setupLabel() {
        self.contentView.addSubview(labelCell)
        labelCell.translatesAutoresizingMaskIntoConstraints = false
        labelCell.textColor = .white
        labelCell.font = UIFont(name: "gilroy-semi-bold", size: 17)
        labelCell.text = "Morty Smith"
        labelCell.textAlignment = .center
        NSLayoutConstraint.activate([
            labelCell.topAnchor.constraint(equalTo: imageCell.bottomAnchor),
            labelCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            labelCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            labelCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    private func setupCell() {
        self.backgroundColor = UIColor(named: "cellBackgroundColor")
        self.layer.cornerRadius = 16
        self.clipsToBounds = true
    }
}
