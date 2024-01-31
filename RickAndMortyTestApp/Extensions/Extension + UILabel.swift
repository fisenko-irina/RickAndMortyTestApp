//
//  Extension + UILabel.swift
//  RickAndMortyTestApp
//
//  Created by Fisenko Irina on 21.11.2023.
//

import Foundation
import UIKit

extension UILabel {
    func leftLabel() {
        self.font = UIFont(name: "gilroy-medium", size: 16)
        self.textColor = UIColor(named: "detailsTextColor")
        self.textAlignment = .left
    }
    func rightLabel() {
        self.font = UIFont(name: "gilroy-medium", size: 16)
        self.textColor = .white
        self.textAlignment = .right
    }
    
    func statusColor(character: Character) {
        switch character.status {
        case .alive:
            self.textColor = UIColor(named: "statusColor")
        case .dead:
            self.textColor = UIColor.red
        case .unknown:
            self.textColor = UIColor.white
        }
    }

}


