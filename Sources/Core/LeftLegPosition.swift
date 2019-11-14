//
//  LeftLegPosition.swift
//  BodyDetection
//
//  Created by Vinicius Dilay on 31/10/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import ARKit
import RealityKit

/// This class is responsible for the **left leg**.
internal class LeftLegPosition : LegsPosition {
    
    /// Knee's global coordinates.
    var lKneeTransform : simd_float4!
    /// Root's global coordinates.
    var rootTransform : simd_float4!
    /// Foot's global coordinates.
    var lFootTransform : simd_float4!
    /// Leg's global coordinates.
    var lLegTransform : simd_float4!
    
/// Initiates the class and looks for the left knee and leg joint by getting the joint's index and global coordinates to the root.
    init(character: BodyTrackedEntity?, bodyAnchor: ARBodyAnchor) {
        
        guard let lKnee = character?.jointName(forPath: "left_leg_joint") else { print("falha de leitura left leg"); return}
        guard let lLeg = character?.jointName(forPath: "left_upLeg_joint") else { print("falha de leitura left up leg"); return}
        let lKneeIndex = ARSkeletonDefinition.defaultBody3D.index(for: lKnee)
        let rootIndex = ARSkeletonDefinition.defaultBody3D.index(for: .root)
        let lFootIndex = ARSkeletonDefinition.defaultBody3D.index(for: .leftFoot)
        let lLegIndex = ARSkeletonDefinition.defaultBody3D.index(for: lLeg)
        


        lKneeTransform = bodyAnchor.skeleton.jointModelTransforms[lKneeIndex].columns.3
        rootTransform = bodyAnchor.skeleton.jointModelTransforms[rootIndex].columns.3
        lFootTransform = bodyAnchor.skeleton.jointModelTransforms[lFootIndex].columns.3
        lLegTransform = bodyAnchor.skeleton.jointModelTransforms[lLegIndex].columns.3
        
    }
    
/// Calculates the **leg's position**.
    func lLegPosition(character: BodyTrackedEntity?, bodyAnchor: ARBodyAnchor) -> legCases{
        
        let lLegToKneeSubcase = LegToKneePos( kneeTransform: lKneeTransform, legTransform: lLegTransform)
        let lKneeToFootCase = KneeToFootPos(kneeTransform: lKneeTransform, legTransform: lLegTransform, footTransform: lFootTransform, legToKneeSubcase: lLegToKneeSubcase)

        return legCases(legCase: lLegToKneeSubcase, kneeCase: lKneeToFootCase)
    }
    
}

