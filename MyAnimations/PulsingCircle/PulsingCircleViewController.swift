//
//  PulsingCircleViewController.swift
//  MyAnimations
//
//  Created by UGORETS Maria on 24.08.2020.
//  Copyright © 2020 MariaUgorets. All rights reserved.
//

import UIKit

class PulsingCircleViewController: UIViewController {
    private var points = [
        CGPoint(x: 20, y: 20),
        CGPoint(x: 100, y: 195),
        CGPoint(x: 400, y: 230),
        CGPoint(x: 100, y: 500)
    ]
    
    let rect = CGRect(x: 80, y: 120, width: 250, height: 250)
    
    private let shapeLayer: BlobsLayer = {
        let shapeLayer = BlobsLayer()
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.fillColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 0.7247699058)
        return shapeLayer
    }()
    
    private let button: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(startAnimation), for: .allTouchEvents)
        button.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        button.layer.cornerRadius = 90 / 2
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 90),
            button.heightAnchor.constraint(equalToConstant: 90)
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        shapeLayer.makeBlobs(inRect: rect)
        view.layer.addSublayer(shapeLayer)

    }
    
    
    @objc
    func startAnimation() {

    }
    

}
