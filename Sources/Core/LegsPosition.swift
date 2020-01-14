//
//  LegsPosition.swift
//  BodyDetection
//
//  Created by Vinicius Dilay on 31/10/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import ARKit

/// This class gets the positions of the legs by creating vectors from a joint to another and comparing the axes and angles.
internal class LegsPosition  {
    let bodyPart = BodyPart()
    
    struct legCases {
        let legCase : LegToKneeSubcase
        let kneeCase: KneeToFootCase
    }
    
/// Get's the **upper leg's** position related to the **knee** by comparing the Y axe.
    func LegToKneePos( kneeTransform: simd_float4, legTransform: simd_float4) -> LegToKneeSubcase {
        let vectorLegToKnee = bodyPart.vector(joint1: kneeTransform, joint2: legTransform)
        let legToKneeCase: LegToKneeCase
        
        if vectorLegToKnee.y < 0.15 { legToKneeCase = .Open }
        else if vectorLegToKnee.y < 0.35 { legToKneeCase = .halfOpen }
        else { legToKneeCase = .straight }
        
        return LegToKneePosZ(kneeTransform: kneeTransform, legTransform: legTransform, legToKneeCase: legToKneeCase )
    }
    
/// Get's the **upper leg's** position related to the **knee** by comparing the Z axe.
    func LegToKneePosZ(kneeTransform: simd_float4, legTransform: simd_float4, legToKneeCase : LegToKneeCase) -> LegToKneeSubcase {
        let vectorLegToKnee = bodyPart.vector(joint1: legTransform, joint2: kneeTransform)
        
        if legToKneeCase == .straight {
            if vectorLegToKnee.z < -0.1 { return .straightBack }
            else {return .straightParallel }
        } else if legToKneeCase == .halfOpen{
            if vectorLegToKnee.z < 0.05 { return .halfOpenParallel}
            else if vectorLegToKnee.z < 0.15 { return .halfOpenDiagonal}
            else {return .halfOpenTransversal}
        } else {
            if vectorLegToKnee.z < 0.05 { return .openParallel}
            else if vectorLegToKnee.z < 0.15 { return .openDiagonal}
            else { return .openTransversal}
        }
    }
    
    /// Get's the **knee's** position related to the **foot** by comparing the angle between the knee and the upper leg.
    func KneeToFootPos(kneeTransform: simd_float4, legTransform: simd_float4, footTransform: simd_float4, legToKneeSubcase: LegToKneeSubcase ) -> KneeToFootCase {
        let vectorLegToKnee = bodyPart.vector(joint1: kneeTransform, joint2: legTransform)
        let vectorKneeToFoot = bodyPart.vector(joint1: kneeTransform, joint2: footTransform)
        
        let kneeBentAngle = bodyPart.angle(vector1: vectorLegToKnee, vector2: vectorKneeToFoot)

        if kneeBentAngle > 125 {return .outstretched}
        else if kneeBentAngle > 100 {return .bentOut}
        else if kneeBentAngle > 60 {return .bent}
        else {return .bentIn}
    }
}
