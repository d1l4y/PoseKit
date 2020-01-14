//
//  LeftArmTracking.swift
//  BodyDetection
//
//  Created by Vinicius Dilay on 29/10/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import ARKit

/// This class is responsible for the **left arm**.
internal class LeftArmPosition: ArmsPosition {

    /// Shoulder's global coordinates.
    var lShoulderTransform : simd_float4!
    /// Elbow's global coordinates.
    var lForearmTransform : simd_float4!
    /// Hand's global coordinates.
    var lHandTransform : simd_float4!
    
/// Initiates the class and looks for the left forearm joint by getting the joint's index and global coordinates to the root.
    init( bodyAnchor: ARBodyAnchor) {

        let lForearmName = ARSkeleton.JointName(rawValue: "left_forearm_joint")

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
    func lArmPosition( bodyAnchor: ARBodyAnchor) -> armCases{
        let lArmSubcase = LeftShoulderToForearmPos( bodyAnchor: bodyAnchor, lHandTransform: lHandTransform, lForearmTransform: lForearmTransform, lShoulderTransform: lShoulderTransform)
        let lForearmCase = ForearmToHandPos( bodyAnchor: bodyAnchor, forearmSubcase: lArmSubcase, HandTransform: lHandTransform, ForearmTransform: lForearmTransform, ShoulderTransform: lShoulderTransform, leftArm: true)
        return armCases(ArmCase: lArmSubcase, HandCase: lForearmCase)
    }
    
/// Gets the position of the **elbow** related to the **shoulder**.
    func LeftShoulderToForearmPos( bodyAnchor: ARBodyAnchor, lHandTransform: simd_float4, lForearmTransform: simd_float4, lShoulderTransform: simd_float4) -> ShoulderToForearmSubcase {
        let leftForearmCase = ShoulderToForearmPos( bodyAnchor: bodyAnchor, HandTransform: lHandTransform, ForearmTransform: lForearmTransform, ShoulderTransform: lShoulderTransform)
        
        return ShoulderToForearmPosZ( bodyAnchor: bodyAnchor, forearmCase: leftForearmCase, HandTransform: lHandTransform, ForearmTransform: lForearmTransform, ShoulderTransform: lShoulderTransform)
    }
    
}
