//
//  poseKit.swift
//  poseKit
//
//  Created by Vinicius Dilay, Isabela Castro, Leonardo Palinkas, Lucas Ronnau, Saulo da Silva on 01/04/19.
//  Copyright © 2019 d1l4y. All rights reserved.
//

import ARKit
import RealityKit

// interface de comunicação com o resto do programa (facade pattern)
@available(iOS 13.0, *)
public class PoseKit {
    
    public func BodyTrackingPosition(character: BodyTrackedEntity?, bodyAnchor: ARBodyAnchor) {
        let leftArmPos = LeftArmPosition(character: character, bodyAnchor: bodyAnchor)
        let rightArmPos = RightArmPosition(character: character, bodyAnchor: bodyAnchor)
        
        leftArmPos.lArmPosition(character: character, bodyAnchor: bodyAnchor)
        rightArmPos.rArmPosition(character: character, bodyAnchor: bodyAnchor)
//        leftLeg.LeftLegPos(character: character, bodyAnchor: bodyAnchor)
//        leg.legPos(character: character, bodyAnchor: bodyAnchor)
    }
    
}

@available(iOS 13.0, *)
extension BodyTrackedEntity {
    func jointName(forPath path: String) -> ARSkeleton.JointName {
        let splitPath = path.split(separator: "/")
        return ARSkeleton.JointName(rawValue: String(splitPath[splitPath.count - 1]))
    }
}
