//
//  MainMenuRouter.swift
//  MyAnimations
//
//  Created by UGORETS Maria on 21.08.2020.
//  Copyright © 2020 MariaUgorets. All rights reserved.
//

import UIKit

protocol MainMenuRouter {
    var menu: UIViewController? { get }
    func showAnimation(_ type: AnimationsType)
}

class MainMenuRouterImp: MainMenuRouter {
    weak var menu: UIViewController?
    
    init(withMenu menu: UIViewController) {
        self.menu = menu
    }
    
    func showAnimation(_ type: AnimationsType) {
        switch type {
        case .poker:
            let storyBoard : UIStoryboard = UIStoryboard(name: "PokerMenu", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "PokerMenuViewController") as! PokerMenuViewController
            menu?.present(nextViewController, animated:true, completion:nil)
            
        case .progressBar:
            let nextViewController = ProgressBarViewController()
            menu?.present(nextViewController, animated:true, completion:nil)

        case .fallingLeaf:
            let nextViewController = FallingAnimationViewController()
            nextViewController.type = .leaf
            menu?.present(nextViewController, animated:true, completion:nil)
        case .fallingFeather:
            let nextViewController = FallingAnimationViewController()
            nextViewController.type = .feather
            menu?.present(nextViewController, animated:true, completion:nil)
        default: break
        }
    }
}
