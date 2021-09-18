//
//  ProgressBarViewController.swift
//  MyAnimations
//
//  Created by Maria Ugorets on 18.09.2021.
//  Copyright © 2021 MariaUgorets. All rights reserved.
//

import UIKit

class ProgressBarViewController: UIViewController {
    private let progressBar = SegmentedCircularGradientProgressBar()
    private var countFired = -1
    private let segmentsNumber = 12
    private var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setProgressBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startAnimation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
    }
    
    private func setProgressBar() {
        let size: CGFloat = 200.0
        progressBar.frame = CGRect(x: view.center.x - (size / 2),
                                   y: view.center.y - (size / 2),
                                   width: size,
                                   height: size)
        progressBar.settings.segmentCount = segmentsNumber
        progressBar.setup()
        view.addSubview(progressBar)
    }
    
    private func startAnimation() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { (timer) in
            self.countFired += 1
            
            DispatchQueue.main.async {
                if self.countFired >= self.segmentsNumber {
                    self.countFired = -1
                    self.progressBar.reset()
                    return
                }
                self.progressBar.updateProgress(segmentCount: self.countFired)
            }
        }
    }
}
