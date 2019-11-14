//
//  RightLegPosition.swift
//  BodyDetection
//
//  Created by Vinicius Dilay on 31/10/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import ARKit
import RealityKit

/// This class is responsible for the **right leg**.
internal class RightLegPosition : LegsPosition {

    /// **Knee's** global coordinates.
    var rKneeTransform : simd_float4!
    /// **Root's** global coordinates.
    var rootTransform : simd_float4!
    /// **Foot's** global coordinates.
    var rFootTransform : simd_float4!
    /// **Leg's** global coordinates.
    var rLegTransform : simd_float4!

/// Initiates the class and looks for the right knee and leg joint by getting the joint's index and global coordinates to the root.
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
        
    }

/// Calculates the **leg's position**.
    func rLegPosition(character: BodyTrackedEntity?, bodyAnchor: ARBodyAnchor) -> legCases{

        let rLegToKneeSubcase = LegToKneePos( kneeTransform: rKneeTransform, legTransform: rLegTransform)
        let rKneeToFootCase = KneeToFootPos(kneeTransform: rKneeTransform, legTransform: rLegTransform, footTransform: rFootTransform, legToKneeSubcase: rLegToKneeSubcase)
        
        return legCases(legCase: rLegToKneeSubcase, kneeCase: rKneeToFootCase)
    }

}
