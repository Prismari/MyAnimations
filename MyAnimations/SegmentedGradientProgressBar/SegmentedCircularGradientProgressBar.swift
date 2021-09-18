//
//  SegmentedCircularGradientProgressBar.swift
//  MyAnimations
//
//  Created by Maria Ugorets on 18.09.2021.
//  Copyright © 2021 MariaUgorets. All rights reserved.
//

import UIKit

struct SegmentedProgressBarSettings {
    var lineWidth: CGFloat = 12.0
    var colors = (#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1),
                  #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1))
    var size: CGFloat = 200.0
    var segmentCount = 10

    // Сalculated values
    let radius: CGFloat
    let fullRadius: CGFloat
    let borderLength: CGFloat
    let segmentLength: CGFloat
    let gapSize: CGFloat

    init() {
        self.radius = (size - lineWidth) / 2
        self.fullRadius = size / 2
        self.borderLength = CGFloat(2 * Double.pi) * fullRadius
        self.segmentLength = (borderLength / CGFloat(segmentCount)) / fullRadius
        self.gapSize = segmentLength / CGFloat(segmentCount)
    }
}

class SegmentedCircularGradientProgressBar: UIView {
    var settings = SegmentedProgressBarSettings()

    private var segments: [(segment: CAShapeLayer, shadow: CALayer)] = []
    private let segmentedCircleMask = CAShapeLayer()
    private let shadowProgressLayer = CAShapeLayer()
    private let circleView = UIView()
    private let shadowView = UIView()

    func setup() {
        for i in 0..<settings.segmentCount {
            let circleLayer = makeSegment(index: i)
            let shadowLayer = makeShadowSegment(index: i)
            segments.insert((circleLayer, shadowLayer), at: i)
        }

        circleView.layer.addSublayer(gradient())
        circleView.layer.mask = segmentedCircleMask
        addSubview(shadowView)
        addSubview(circleView)
    }

    func addAtIndex(_ index: Int) {
        if index > segments.count - 1 {
            return
        }
        segmentedCircleMask.addSublayer(segments[index].segment)
        shadowProgressLayer.addSublayer(segments[index].shadow)
        shadowView.layer.addSublayer(shadowProgressLayer)
    }

    func reset() {
        segmentedCircleMask.sublayers?.removeAll()
        shadowProgressLayer.sublayers?.removeAll()
    }

    func removeAtIndex(_ index: Int) {
        if let count = segmentedCircleMask.sublayers?.count,
           index < count {
            segmentedCircleMask.sublayers?.remove(at: index)
            shadowProgressLayer.sublayers?.remove(at: index)
        }
    }

    func updateProgress(segmentCount: Int) {
        reset()
        if segmentCount < 0 {
            return
        }
        for index in 0...segmentCount {
            segmentedCircleMask.addSublayer(segments[index].segment)
            shadowProgressLayer.addSublayer(segments[index].shadow)
            shadowView.layer.addSublayer(shadowProgressLayer)
        }
    }

    private func makeSegment(index: Int) -> CAShapeLayer {
        let circleLayer = CAShapeLayer()

        circleLayer.lineWidth = settings.lineWidth
        circleLayer.strokeColor = UIColor.white.cgColor
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.path = calculatePath(index: index)

        return circleLayer
    }

    private func makeShadowSegment(index: Int) -> CALayer {
        let shadowLayer = CALayer()
        shadowLayer.shadowPath = calculatePath(index: index)
        shadowLayer.shadowColor = UIColor.black.cgColor
        shadowLayer.shadowRadius = 4
        shadowLayer.shadowOpacity = 1
        shadowLayer.shadowOffset = .init(width: 0.0, height: 10.0)

        return shadowLayer
    }

    private func gradient() -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            settings.colors.0.cgColor,
            settings.colors.1.cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 1, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        gradientLayer.frame = bounds
        return gradientLayer
    }

    private func calculatePath(index: Int) -> CGPath {
        let center = CGPoint(x: settings.size / 2, y: settings.size / 2)
        let start = settings.segmentLength * CGFloat(index) + (-CGFloat.pi / 2)
        let end = start + (settings.segmentLength - settings.gapSize)
        let path = UIBezierPath(arcCenter: center,
                                radius: settings.radius,
                                startAngle: start,
                                endAngle: end,
                                clockwise: true).cgPath
        return path
    }
}
