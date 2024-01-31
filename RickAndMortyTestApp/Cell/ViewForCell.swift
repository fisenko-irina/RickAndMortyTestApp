//
//  ViewForCell.swift
//  RickAndMortyTestApp
//
//  Created by Fisenko Irina on 21.11.2023.
//

import Foundation
import UIKit

final class ViewForCell: UIView {
    private let episodeName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "gilroy-semi-bold", size: 17)
        label.textColor = .white
        return label
    }()
    private let seasonEpisode: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "statusColor")
        label.font = UIFont(name: "gilroy-medium", size: 13)
        return label
    }()
    private let dateEpisode: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "detailsTextColor")
        label.font = UIFont(name: "gilroy-medium", size: 12)
        label.textAlignment = .right
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(episode: Episode) {
        episodeName.text = episode.name
        dateEpisode.text = episode.airDate
        seasonEpisode.text = convert(string: episode.episode)
    }
    
    private func convert(string: String) -> String {
        let season = string.components(separatedBy: "S").last?.components(separatedBy: "E").first ?? ""
        let episode = string.components(separatedBy: "E").last ?? ""
        return "Episode: \(Int(episode) ?? 0), Season: \(Int(season) ?? 0)"
    }
    
    private func commonInit() {
        setupView()
        addSubviews()
        setupEpisodeName()
        setupSeasonEpisode()
        setupDateEpisode()
    }
    private func setupView() {
        self.backgroundColor = UIColor(named: "cellBackgroundColor")
        self.layer.cornerRadius = 16
        self.clipsToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = true
    }
    
    private func addSubviews() {
        addSubview(episodeName)
        addSubview(seasonEpisode)
        addSubview(dateEpisode)
    }
    
    private func setupEpisodeName() {
        episodeName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            episodeName.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            episodeName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            episodeName.heightAnchor.constraint(equalToConstant: 22),
            episodeName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    private func setupSeasonEpisode() {
        seasonEpisode.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            seasonEpisode.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            seasonEpisode.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            seasonEpisode.trailingAnchor.constraint(equalTo: dateEpisode.leadingAnchor, constant: 16),
            seasonEpisode.heightAnchor.constraint(equalToConstant: 20),
        ])
        seasonEpisode.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
    }

    private func setupDateEpisode() {
        dateEpisode.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateEpisode.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            dateEpisode.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            dateEpisode.heightAnchor.constraint(equalToConstant: 20),
        ])
        dateEpisode.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    }
}
