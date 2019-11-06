//
//  RightLegPosition.swift
//  BodyDetection
//
//  Created by Vinicius Dilay on 31/10/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import ARKit
import RealityKit
@available(iOS 13.0, *)

class RightLegPosition : LegsPosition {

    var rKneeTransform : simd_float4!
    var rootTransform : simd_float4!
    var rFootTransform : simd_float4!
    var rLegTransform : simd_float4!

    init(character: BodyTrackedEntity?, bodyAnchor: ARBodyAnchor) {
    
        guard let rKnee = character?.jointName(forPath: "right_leg_joint") else { print("falha de leitura right leg"); return}
        guard let rLeg = character?.jointName(forPath: "right_upLeg_joint") else { print("falha de leitura right up leg"); return}
        
        let rKneeIndex = ARSkeletonDefinition.defaultBody3D.index(for: rKnee)
        let rootIndex = ARSkeletonDefinition.defaultBody3D.index(for: .root)
        let rFootIndex = ARSkeletonDefinition.defaultBody3D.index(for: .rightFoot)
        let rLegIndex = ARSkeletonDefinition.defaultBody3D.index(for: rLeg)
        
        rKneeTransform = bodyAnchor.skeleton.jointModelTransforms[rKneeIndex].columns.3
        rootTransform = bodyAnchor.skeleton.jointModelTransforms[rootIndex].columns.3
        rFootTransform = bodyAnchor.skeleton.jointModelTransforms[rFootIndex].columns.3
        rLegTransform = bodyAnchor.skeleton.jointModelTransforms[rLegIndex].columns.3
        
//        let vectorRightFootToLeg = vector(joint1: rFootTransform, joint2: rLegTransform)
//        let vectorRootRightLeg = vector(joint1: rootTransform, joint2: rLegTransform)
//
//        let vectorRightLegToKnee = vector(joint1: rKneeTransform, joint2: rLegTransform)
//        let vectorRightLegFoot = vector(joint1: rLegTransform, joint2: rFootTransform)
//
//        let anguloJD = angle(vector1: vectorRightLegToKnee, vector2: vectorRightLegFoot)
    }
    
    func rLegPos(character: BodyTrackedEntity?, bodyAnchor: ARBodyAnchor){

        let rLegToKneeSubcase = LegToKneePos( kneeTransform: rKneeTransform, legTransform: rLegTransform)
        let lKneeToFootCase = KneeToFootPos(kneeTransform: rKneeTransform, legTransform: rLegTransform, footTransform: rFootTransform, legToKneeSubcase: rLegToKneeSubcase)
        
    }
}
