//
//  EpisodesCell.swift
//  RickAndMortyTestApp
//
//  Created by Fisenko Irina on 21.11.2023.
//

import UIKit

final class EpisodesCell: UITableViewCell {
    private lazy var viewAdd = ViewForCell()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        setupCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupCell() {
        contentView.addSubview(viewAdd)
        viewAdd.translatesAutoresizingMaskIntoConstraints = false
        viewAdd.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        viewAdd.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        viewAdd.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        let glue = viewAdd.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        glue.isActive = true
        glue.priority = .defaultHigh
    }
    
    func configure(episode: Episode) {
        viewAdd.configure(episode: episode)
    }
}
