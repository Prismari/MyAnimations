//
//  BlobsView.swift
//  MyAnimations
//
//  Created by UGORETS Maria on 28.08.2020.
//  Copyright © 2020 MariaUgorets. All rights reserved.
//

import UIKit

final class BlobsLayer: CAShapeLayer {
    
    func makeBlobs(inRect rect: CGRect) {
        self.path = path(inRect: rect)
    }
    
    func path(inRect rect: CGRect) -> CGMutablePath {

        let path = CGMutablePath()
        
        let p0 = CGPoint(x: rect.minX, y: rect.minY)
        path.move(to:p0)
        
        
        let p1 = CGPoint(x: rect.maxX, y: rect.minY)
        let middleOfZeroAndOne = calculateMiddle(from: p0.x, to: p1.x)
        path.addQuadCurve(to: p1,
                          control: CGPoint(
                            x: middleOfZeroAndOne + 20,
                            y: p1.y - 140))
        
        
        let p2 = CGPoint(x: rect.maxX, y: rect.maxY)
        let middleOfOneAndTwo = calculateMiddle(from: p1.y, to: p2.y)
        path.addQuadCurve(to: p2,
                          control: CGPoint(
                            x: p2.x + 70,
                            y: middleOfOneAndTwo - 35))
        
        
        let p3 = CGPoint(x: rect.minX, y: rect.maxY)
        let middleOfTwoToThree = calculateMiddle(from: p2.x, to: p3.x)
        path.addQuadCurve(to: p3,
                          control: CGPoint(
                            x: middleOfTwoToThree + 35,
                            y: p3.y + 130))
        
        let p4 = p0
        let middleOfThreeToFour = calculateMiddle(from: p3.y, to: p4.y)
        path.addQuadCurve(to: p4,
                          control: CGPoint(
                            x: p4.x - 120,
                            y: middleOfThreeToFour - 12))
        
        return path
    }
    
    func calculateMiddle(from start: CGFloat, to end: CGFloat) -> CGFloat {
        let way = abs(start - end) / 2
        if start > end {
            return start - way
        }
        return end - way
    }
    
}
