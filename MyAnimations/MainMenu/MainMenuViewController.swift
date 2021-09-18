//
//  ViewController.swift
//  MyAnimations
//
//  Created by UGORETS Maria on 21.08.2020.
//  Copyright © 2020 MariaUgorets. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {
    var router: MainMenuRouter?
    
    private lazy var menuCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.register(MenuItemCollectionViewCell.self, forCellWithReuseIdentifier: MenuItemCollectionViewCell.reuseID)
       
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(menuCollection)
        menuCollection.frame = CGRect(x: view.frame.minX, y: view.frame.maxY / 10, width: view.frame.width, height: view.frame.height)
    }
}

extension MainMenuViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear, animations: {
                cell.transform = CGAffineTransform.init(scaleX: 0.95, y: 0.95)
            }) { (ended) in
                
                UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear, animations: {
                    cell.transform = CGAffineTransform.init(scaleX: 1, y: 1)
                    
                })
            }
        }
        router?.showAnimation(AnimationsType(rawValue: indexPath.row) ?? .empty)
    }
}

extension MainMenuViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MenuItemCollectionViewCell.reuseID,
            for: indexPath
        ) as? MenuItemCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setup(withType: AnimationsType(rawValue: indexPath.row) ?? .empty)
        return cell
    }
    
}

extension MainMenuViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 16 * 2), height: 90)
    }
}

