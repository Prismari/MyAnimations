//
//  MenuItemCollectionViewCell.swift
//  MyAnimations
//
//  Created by UGORETS Maria on 21.08.2020.
//  Copyright © 2020 MariaUgorets. All rights reserved.
//

import UIKit

class MenuItemCollectionViewCell: UICollectionViewCell {
    static let reuseID = "MenuItemCollectionViewCell"
    
    private var type: AnimationsType = .empty
    
    private lazy var title: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    func setup(withType type: AnimationsType) {
        self.type = type
        backgroundColor = #colorLiteral(red: 0.6682489514, green: 0.825932622, blue: 1, alpha: 0.5)
        layer.cornerRadius = 5.0
        clipsToBounds = true
        setTitle()
    }
    
    private func setTitle() {
        var titleText = ""
        
        switch type {
        case .poker:
            titleText = "Poker cells animation"
        case .progressBar:
            titleText = "Segmented progress bar with gradient"
        case .fallingLeaf:
            titleText = "Falling leaf"
        case .fallingFeather:
            titleText = "Falling feather"
        default: break
        }

        title.text = titleText
        title.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        addSubview(title)
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        ])
    }
    
}
