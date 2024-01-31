//
//  SplashScreen.swift
//  RickAndMortyTestApp
//
//  Created by Fisenko Irina on 21.11.2023.
//

import UIKit

final class SplashScreen: UIViewController {
    private let image = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
}

extension SplashScreen {
override var preferredStatusBarStyle: UIStatusBarStyle {
            return .lightContent
        }
    
    private func commonInit() {
        setupSplashScreen()
        setupImage()
        moveToMainScreen()
    }
    
    private func setupSplashScreen() {
        navigationController?.navigationBar.barStyle = .black
        view.backgroundColor = UIColor(named: "backgroundColor")
    }
    
    private func setupImage() {
        view.addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "SplashImage")
        image.contentMode = .scaleToFill
        NSLayoutConstraint.activate([
            image.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            image.widthAnchor.constraint(equalToConstant: 334),
            image.heightAnchor.constraint(equalToConstant: 650)
        ])
    }
    
    private func moveToMainScreen() {
        let controller = MainScreen()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}

