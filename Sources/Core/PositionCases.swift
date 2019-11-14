//
//  PositionCases.swift
//  poseKit-iOS
//
//  Created by Vinicius Dilay on 07/11/19.
//  Copyright © 2019 d1l4y. All rights reserved.
//

import Foundation

/// Upper arm's position cases
public enum ShoulderToForearmCase {
    case verticalUp
    case verticalDown
    case horizontal
}

/// Upper arm's position subcases.
public enum ShoulderToForearmSubcase {
    case verticalUpDiagonalFront
    case verticalUpParallel
    case verticalUpTransverse
    case verticalDownDiagonalFront
    case verticalDownDiagonalBack
    case verticalDownParallel
    case verticalDownTransverse
    case horizontalParallel
    case horizontalDiagonalBack
    case horizontalDiagonalFront
    case horizontalTransverse
}

/// Forearm's position cases.
public enum ForearmToHandForearmCase {
    case straightHorizontal
    case bentUp
    case bentDown
}

/// Forearm's position subcases.
public enum ForearmToHandSubcase {
    case straightHorizontal
    case horizontalBentIn
    case bentUp
    case bentUpOut
    case bentUpIn
    case bentDown
    case bentDownOut
    case bentDownIn
}

/// Upper leg's position cases.
public enum LegToKneeCase {
    case straight
    case halfOpen
    case Open
}

/// Upper leg's position subcases.
public enum LegToKneeSubcase {
    case straightParallel
    case straightBack
    case halfOpenDiagonal
    case halfOpenParallel
    case halfOpenTransversal
    case openParallel
    case openDiagonal
    case openTransversal
}

/// Lower leg's position cases.
public enum KneeToFootCase {
    case outstretched
    case bentOut
    case bent
    case bentIn
}

/// Both leg's position cases.
public enum BothLegsCase {
    
}


