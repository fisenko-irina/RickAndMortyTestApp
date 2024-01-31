//
//  OriginCell.swift
//  RickAndMortyTestApp
//
//  Created by Fisenko Irina on 21.11.2023.
//

import UIKit

final class OriginCell: UITableViewCell {
    private let planetView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "planetBackground")
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    private let planetImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Planet")
        image.contentMode = .scaleAspectFit
        return image
    }()
    private let planetName: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "gilroy-semi-bold", size: 17)
        label.text = "Earth"
        label.textAlignment = .left
        return label
    }()
    private let universeObject: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "statusColor")
        label.font = UIFont(name: "gilroy-medium", size: 13)
        label.textAlignment = .left
        return label
    }()
    
    func configure(character: Character) {
        self.planetName.text = character.origin.name
    }
    
    func configure(planet: Planet) {
        self.universeObject.text = planet.type
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func commonInit() {
        setupCell()
        setupPlanetView()
        setupPlanetImage()
        setupPlanetName()
        setupUniverseObject()
    }
    private func setupCell() {
        backgroundColor = .clear
        contentView.backgroundColor = UIColor(named: "cellBackgroundColor")
        contentView.layer.cornerRadius = 16
        contentView.clipsToBounds = true
    }
    private func setupPlanetView() {
        contentView.addSubview(planetView)
        planetView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            planetView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            planetView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            planetView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            planetView.widthAnchor.constraint(equalTo: planetView.heightAnchor)
        ])
    }
    private func setupPlanetImage() {
        planetView.addSubview(planetImage)
        planetImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            planetImage.centerYAnchor.constraint(equalTo: planetView.centerYAnchor),
            planetImage.centerXAnchor.constraint(equalTo: planetView.centerXAnchor),
            planetImage.heightAnchor.constraint(equalToConstant: 24),
            planetImage.widthAnchor.constraint(equalToConstant: 24)
        ])
    }
    private func setupPlanetName() {
        contentView.addSubview(planetName)
        planetName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            planetName.leadingAnchor.constraint(equalTo: planetView.trailingAnchor, constant: 16),
            planetName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            planetName.heightAnchor.constraint(equalToConstant: 22),
            planetName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    private func setupUniverseObject() {
        contentView.addSubview(universeObject)
        universeObject.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            universeObject.leadingAnchor.constraint(equalTo: planetView.trailingAnchor, constant: 16),
            universeObject.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            universeObject.heightAnchor.constraint(equalToConstant: 18),
            universeObject.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
}
