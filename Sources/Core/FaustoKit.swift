//
//  FaustoKit.swift
//  BodyDetection
//
//  Created by Vinicius Dilay on 30/10/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import ARKit
import RealityKit

// interface de comunicação com o resto do programa (facade pattern)
@available(iOS 13.0, *)
public class FaustoKit {
    
    public func BodyTrackingPosition(character: BodyTrackedEntity?, bodyAnchor: ARBodyAnchor) {
        let leftArmPos = LeftArmPosition(character: character, bodyAnchor: bodyAnchor)
        let rightArmPos = RightArmPosition(character: character, bodyAnchor: bodyAnchor)
        
        leftArmPos.lArmPosition(character: character, bodyAnchor: bodyAnchor)
        rightArmPos.rArmPosition(character: character, bodyAnchor: bodyAnchor)
//        leftLeg.LeftLegPos(character: character, bodyAnchor: bodyAnchor)
//        leg.legPos(character: character, bodyAnchor: bodyAnchor)
    }
    
}
