//
//  Helpers.swift
//  BaseProject
//
//  Created by Alex on 22/07/2017.
//  Copyright © 2017 AleksZilla. All rights reserved.
//

import Foundation
import SpriteKit

func radianToDegree(radian: Double)->CGFloat {
    return CGFloat(radian * 180 / .pi)
}

func degreeToRadian(degree: Double)->CGFloat {
    return CGFloat(degree * .pi / 180)
}

func vectorXMultiply(v: CGVector, k: CGFloat) -> CGVector {
    return CGVector(dx: v.dx*k, dy: v.dy)
}

func vectorXYMultiply(v: CGVector, k: CGFloat) -> CGVector {
    return CGVector(dx: v.dx*k, dy: v.dy*k)
}
