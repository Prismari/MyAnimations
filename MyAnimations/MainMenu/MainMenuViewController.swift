//
//  ViewController.swift
//  MyAnimations
//
//  Created by UGORETS Maria on 21.08.2020.
//  Copyright © 2020 MariaUgorets. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {
    
    private lazy var menuCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: MenuItemCollectionViewCell.description())
       
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
        let storyBoard : UIStoryboard = UIStoryboard(name: "PokerMenu", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "PokerMenuViewController") as! PokerMenuViewController
        self.present(nextViewController, animated:true, completion:nil)
    }
}

extension MainMenuViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MenuItemCollectionViewCell.description(),
            for: indexPath
        )
        cell.backgroundColor = #colorLiteral(red: 0.6682489514, green: 0.825932622, blue: 1, alpha: 0.5)
        cell.layer.borderColor = #colorLiteral(red: 0.2699920535, green: 0.3371974528, blue: 0.3942155838, alpha: 0.5)
        cell.layer.borderWidth = 2.0
        cell.layer.cornerRadius = 5.0
        cell.clipsToBounds = true
        return cell
    }
    
}

extension MainMenuViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 16 * 2), height: 90)
    }
}

