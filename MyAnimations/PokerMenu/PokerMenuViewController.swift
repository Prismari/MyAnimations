//
//  ViewController.swift
//  AnimationIndividaulTask_13
//
//  Created by UGORETS Maria on 24.02.2020.
//  Copyright © 2020 MariaUgorets. All rights reserved.
//

import UIKit

class PokerMenuViewController: UIViewController {
    
    @IBOutlet weak var menu: UIStackView!
    
    @IBOutlet weak var settingsButton: UIView!
    
    @IBOutlet var settingsMenuViews: [UIView]!
    
    @IBOutlet weak var hideButtonView: UIButton!
    
    @IBAction func hideButton(_ sender: Any) {
        hideButtons()
    }
    
    private var scaleTransformCoefficient: CGFloat = 1.0
    private var translateTransformCoefficientForItem: CGFloat = 0.0
    private var alphaCoefficient: CGFloat = 1.0
    lazy var translateTransformCoefficientForMenu: CGFloat = {
        return hideButtonView.frame.height * 1.3
    }()
    
    private var isCollapsed = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collapseMenu()
        handleTapOnSettingsView()
        hideButtonsWhenTappedAround()
    }
    
    private func collapseMenu() {
        hideButtonView.transform = CGAffineTransform(translationX: 0, y: translateTransformCoefficientForMenu)
        for viewIndex in settingsMenuViews.indices {
            if viewIndex > 1 {
                settingsMenuViews[viewIndex].isHidden = true
            }
            collapseItem(settingsMenuViews[viewIndex])
        }
    }
    
    private func collapseItem(_ item: UIView) {
        updateCoefficients()
        transformMenuItem(for: item)
        menu.sendSubviewToBack(item)
    }
    
    private func updateCoefficients() {
        let itemsCount = CGFloat(integerLiteral:  settingsMenuViews.count)
        scaleTransformCoefficient -= 0.13
        translateTransformCoefficientForItem -= settingsButton.frame.height - 0.2
        alphaCoefficient -= (1 / itemsCount)
    }
    
    private func transformMenuItem(for menuItem: UIView) {
        let resizeTransform = settingsButton.transform.scaledBy(x: scaleTransformCoefficient, y: 1.0)
        let resizeAndMoveTransform = resizeTransform.translatedBy(x: 0, y: translateTransformCoefficientForItem)
        menuItem.transform = resizeAndMoveTransform
        menuItem.alpha = alphaCoefficient
    }
    
    
    private func handleTapOnSettingsView() {
        let tapOnSettingView = UITapGestureRecognizer(target: self, action: #selector(openMenu))
        settingsButton.addGestureRecognizer(tapOnSettingView)
    }
    
    @objc func openMenu() {
        isCollapsed = false
        showMenuWithAnimation()
        showHideButtonWithAnimation()
        resetCoefficients()
    }
    
    private func showMenuWithAnimation() {
        UIView.animate(withDuration: 0.5, animations: {
            self.menu.transform = .identity
            self.settingsMenuViews.forEach({
                self.showMenuItems($0)
            })
            self.menu.transform = CGAffineTransform(translationX: 0, y: self.translateTransformCoefficientForMenu)
        })
    }
    
    private func showMenuItems(_ item: UIView) {
        item.transform = .identity
        item.alpha = 1.0
        item.isHidden = false
    }
    
    private func resetCoefficients() {
        self.scaleTransformCoefficient = 1.0
        self.translateTransformCoefficientForItem = 0.0
        self.alphaCoefficient = 1.0
    }
    
    private func showHideButtonWithAnimation() {
        UIView.animate(withDuration: 0.2, animations: {
           self.hideButtonView.transform = .identity
            self.hideButtonView.alpha = 1.0
        })
    }
    
    func hideButtonsWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideButtons))
        view.addGestureRecognizer(tap)
    }
    
    @objc func hideButtons() {
        if isCollapsed {
            return
        }
        UIView.animate(withDuration: 0.5, animations: {
            self.collapseMenu()
            self.menu.transform = .identity
            self.settingsButton.layoutIfNeeded()
            self.hideButtonView.alpha = 0.0
        })
        isCollapsed = true
    }
}

