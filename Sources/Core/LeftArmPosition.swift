//
//  LeftArmTracking.swift
//  BodyDetection
//
//  Created by Vinicius Dilay on 29/10/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import ARKit
import RealityKit

/// This class is responsible for the **left arm**.
internal class LeftArmPosition: ArmsPosition {

    /// Shoulder's global coordinates.
    var lShoulderTransform : simd_float4!
    /// Elbow's global coordinates.
    var lForearmTransform : simd_float4!
    /// Hand's global coordinates.
    var lHandTransform : simd_float4!
    
/// Initiates the class and looks for the left forearm joint by getting the joint's index and global coordinates to the root.
    init(character: BodyTrackedEntity?, bodyAnchor: ARBodyAnchor) {

        guard let lForearmName = character?.jointName(forPath: "left_forearm_joint" ) else { print("left_forearm_joint not found!"); return}
        
        // Pega o index das joints necessárias
        let lForearmIndex = ARSkeletonDefinition.defaultBody3D.index(for: lForearmName)
        let lHandIndex = ARSkeletonDefinition.defaultBody3D.index(for: .leftHand)
        let lShoulderIndex = ARSkeletonDefinition.defaultBody3D.index(for: .leftShoulder)
        
        //Pega o transform global das joints(coordenadas em relação a root)
        lShoulderTransform = bodyAnchor.skeleton.jointModelTransforms[lShoulderIndex].columns.3
        lForearmTransform = bodyAnchor.skeleton.jointModelTransforms[lForearmIndex].columns.3
        lHandTransform = bodyAnchor.skeleton.jointModelTransforms[lHandIndex].columns.3
    
        
    }
    
/// Calculates the arm's position and returns the **HandCase** and **ForearmSubcase**.
    func lArmPosition(character: BodyTrackedEntity?, bodyAnchor: ARBodyAnchor) -> armCases{
        let lArmSubcase = LeftShoulderToForearmPos(character: character, bodyAnchor: bodyAnchor, lHandTransform: lHandTransform, lForearmTransform: lForearmTransform, lShoulderTransform: lShoulderTransform)
        let lForearmCase = ForearmToHandPos(character: character, bodyAnchor: bodyAnchor, forearmSubcase: lArmSubcase, HandTransform: lHandTransform, ForearmTransform: lForearmTransform, ShoulderTransform: lShoulderTransform, leftArm: true)
        return armCases(ArmCase: lArmSubcase, HandCase: lForearmCase)
    }
    
/// Gets the position of the **elbow** related to the **shoulder**.
    func LeftShoulderToForearmPos(character: BodyTrackedEntity?, bodyAnchor: ARBodyAnchor, lHandTransform: simd_float4, lForearmTransform: simd_float4, lShoulderTransform: simd_float4) -> ShoulderToForearmSubcase {
        let leftForearmCase = ShoulderToForearmPos(character: character, bodyAnchor: bodyAnchor, HandTransform: lHandTransform, ForearmTransform: lForearmTransform, ShoulderTransform: lShoulderTransform)
        
        return ShoulderToForearmPosZ(character: character, bodyAnchor: bodyAnchor, forearmCase: leftForearmCase, HandTransform: lHandTransform, ForearmTransform: lForearmTransform, ShoulderTransform: lShoulderTransform)
    }
    
}
