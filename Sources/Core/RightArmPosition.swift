//
//  RightArmPosition.swift
//  BodyDetection
//
//  Created by Vinicius Dilay on 30/10/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import ARKit

/// This class is responsible for the **right arm**.
internal class RightArmPosition: ArmsPosition {
    
    /// **Shoulder's** global coordinates.
    var rShoulderTransform : simd_float4!
    /// **Forearm's** global coordinates.
    var rForearmTransform : simd_float4!
    /// **Hand's** global coordinates.
    var rHandTransform : simd_float4!
    
/// Initiates the class and looks for the right knee and leg joint by getting the joint's index and global coordinates to the root.
    init( bodyAnchor: ARBodyAnchor) {

        let rForearmName = ARSkeleton.JointName(rawValue: "right_forearm_joint")

        let rForearmIndex = ARSkeletonDefinition.defaultBody3D.index(for: rForearmName)
        let rHandIndex = ARSkeletonDefinition.defaultBody3D.index(for: .rightHand)
        let rShoulderIndex = ARSkeletonDefinition.defaultBody3D.index(for: .rightShoulder)
        
        self.rShoulderTransform = bodyAnchor.skeleton.jointModelTransforms[rShoulderIndex].columns.3
        self.rForearmTransform = bodyAnchor.skeleton.jointModelTransforms[rForearmIndex].columns.3
        self.rHandTransform = bodyAnchor.skeleton.jointModelTransforms[rHandIndex].columns.3
  
    }

/// Calculates the arm's position and returns the **HandCase** and **ForearmSubcase**
    func rArmPosition( bodyAnchor: ARBodyAnchor) -> armCases {
        
        let rArmSubcase = RightShoulderToForearmPos( bodyAnchor: bodyAnchor, rHandTransform: rHandTransform, rForearmTransform: rForearmTransform, rShoulderTransform: rShoulderTransform)
        let rForearmCase = ForearmToHandPos(bodyAnchor: bodyAnchor, forearmSubcase: rArmSubcase, HandTransform: rHandTransform, ForearmTransform: rForearmTransform, ShoulderTransform: rShoulderTransform, leftArm: false)
        
        return armCases(ArmCase: rArmSubcase, HandCase: rForearmCase)
    }
    
    
/// Get's the **elbow's** position related to the **shoulder**.
    func RightShoulderToForearmPos( bodyAnchor: ARBodyAnchor, rHandTransform: simd_float4, rForearmTransform: simd_float4, rShoulderTransform: simd_float4) -> ShoulderToForearmSubcase {
        let rightForearmCase = ShoulderToForearmPos( bodyAnchor: bodyAnchor, HandTransform: rHandTransform, ForearmTransform: rForearmTransform, ShoulderTransform: rShoulderTransform)
        
        return ShoulderToForearmPosZ( bodyAnchor: bodyAnchor, forearmCase: rightForearmCase, HandTransform: rHandTransform, ForearmTransform: rForearmTransform, ShoulderTransform: rShoulderTransform)
    }
}
