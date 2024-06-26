//
//  InfoCell.swift
//  RickAndMortyTestApp
//
//  Created by Fisenko Irina on 21.11.2023.
//

import UIKit

final class InfoCell: UITableViewCell {
    private lazy var speciesLabel: UILabel = {
        let label = UILabel()
        label.text = "Species:"
        label.leftLabel()
        return label
    }()
    private lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.text = "Type:"
        label.leftLabel()
        return label
    }()
    private lazy var genderLabel: UILabel = {
        let label = UILabel()
        label.text = "Gender:"
        label.leftLabel()
        return label
    }()
    private lazy var speciesValue: UILabel = {
        let label = UILabel()
        label.rightLabel()
        return label
    }()
    private lazy var typeValue: UILabel = {
        let label = UILabel()
        label.rightLabel()
        return label
    }()
    private lazy var genderValue: UILabel = {
        let label = UILabel()
        label.rightLabel()
        return label
    }()
    
    func configure(character: Character) {
        self.speciesValue.text = character.species
        if character.type == "" {
            self.typeValue.text = "None"
        } else {
            self.typeValue.text = character.type
        }
        self.genderValue.text = character.gender.rawValue
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
        addSubviews()
        setSpeciesLabel()
        setTypeLabel()
        setGenderLabel()
        setSpeciesValue()
        setTypeValue()
        setGenderValue()
    }
    private func setupCell() {
        backgroundColor = .clear
        contentView.backgroundColor = UIColor(named: "cellBackgroundColor")
        contentView.layer.cornerRadius = 16
        contentView.clipsToBounds = true
    }
    private func addSubviews() {
            [speciesLabel, typeLabel, genderLabel,
             speciesValue, typeValue, genderValue].forEach {
                $0.translatesAutoresizingMaskIntoConstraints = false
                contentView.addSubview($0)
            }
    }
    private func setSpeciesLabel() {
        NSLayoutConstraint.activate([
            speciesLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            speciesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            speciesLabel.heightAnchor.constraint(equalToConstant: 20),
            speciesLabel.widthAnchor.constraint(equalToConstant: 64)
        ])
        
        speciesLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
    }
    private func setTypeLabel() {
        NSLayoutConstraint.activate([
            typeLabel.topAnchor.constraint(equalTo: speciesLabel.bottomAnchor, constant: 15),
            typeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            typeLabel.heightAnchor.constraint(equalToConstant: 20),
            typeLabel.widthAnchor.constraint(equalToConstant: 64)
        ])
        typeLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
    }
    private func setGenderLabel() {
        NSLayoutConstraint.activate([
            genderLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 15),
            genderLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            genderLabel.heightAnchor.constraint(equalToConstant: 20),
            genderLabel.widthAnchor.constraint(equalToConstant: 64)
        ])
        genderLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
    }
    private func setSpeciesValue() {
        NSLayoutConstraint.activate([
            speciesValue.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            speciesValue.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            speciesValue.heightAnchor.constraint(equalToConstant: 20),
            speciesValue.leadingAnchor.constraint(equalTo: speciesLabel.trailingAnchor, constant: 20)
        ])
        speciesLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    }
    private func setTypeValue() {
        NSLayoutConstraint.activate([
            typeValue.topAnchor.constraint(equalTo: speciesValue.bottomAnchor, constant: 15),
            typeValue.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            typeValue.heightAnchor.constraint(equalToConstant: 20),
            typeValue.leadingAnchor.constraint(equalTo: typeLabel.trailingAnchor, constant: 20),
        ])
        typeLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    }
    private func setGenderValue() {
        NSLayoutConstraint.activate([
            genderValue.topAnchor.constraint(equalTo: typeValue.bottomAnchor, constant: 15),
            genderValue.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            genderValue.heightAnchor.constraint(equalToConstant: 20),
            genderValue.leadingAnchor.constraint(equalTo: genderLabel.trailingAnchor, constant: 20),
        ])
        genderValue.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    }
}
