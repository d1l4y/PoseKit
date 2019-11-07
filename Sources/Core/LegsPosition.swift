//
//  LegsPosition.swift
//  BodyDetection
//
//  Created by Vinicius Dilay on 31/10/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import ARKit
import RealityKit


//ver casos com as duas pernas (de pé, agachado, sentado, etc)

@available(iOS 13.0, *)
class LegsPosition  {
    let bodyPart = BodyPart()
    
    
    func LegToKneePos( kneeTransform: simd_float4, legTransform: simd_float4) -> LegToKneeSubcase {
        let vectorLegToKnee = bodyPart.vector(joint1: kneeTransform, joint2: legTransform)
        let legToKneeCase: LegToKneeCase
        
        //         print(vectorLegToKnee.y)//, "eixo z: ", vectorLegToKnee.z)
        if vectorLegToKnee.y < 0.15 { legToKneeCase = .Open }
        else if vectorLegToKnee.y < 0.35 { legToKneeCase = .halfOpen }
        else { legToKneeCase = .straight }
        
        return LegToKneePosZ(kneeTransform: kneeTransform, legTransform: legTransform, legToKneeCase: legToKneeCase )
    }
    
    
    func LegToKneePosZ(kneeTransform: simd_float4, legTransform: simd_float4, legToKneeCase : LegToKneeCase) -> LegToKneeSubcase {
        let vectorLegToKnee = bodyPart.vector(joint1: legTransform, joint2: kneeTransform)
 //print(vectorLegToKnee.z)
        if legToKneeCase == .straight {
            if vectorLegToKnee.z < -0.1 { return .straightBack }
            else {return .straightReto }
        } else if legToKneeCase == .halfOpen{
            if vectorLegToKnee.z < 0.05 { return .halfOpenReto}
            else if vectorLegToKnee.z < 0.15 { return .halfOpenMiddleFront}
            else {return .halfOpenFront}
        } else {
            if vectorLegToKnee.z < 0.05 { return .openReto}
            else if vectorLegToKnee.z < 0.15 { return .openMiddleFront}
            else { return .openFront}
        }
    }
    
    
    func KneeToFootPos(kneeTransform: simd_float4, legTransform: simd_float4, footTransform: simd_float4, legToKneeSubcase: LegToKneeSubcase ) -> KneeToFootCase {

        let vectorLegToKnee = bodyPart.vector(joint1: kneeTransform, joint2: legTransform)
        let vectorKneeToFoot = bodyPart.vector(joint1: kneeTransform, joint2: footTransform)
        
        let kneeBentAngle = bodyPart.angle(vector1: vectorLegToKnee, vector2: vectorKneeToFoot)
//        print(kneeBentAngle)
        if kneeBentAngle > 125 {return .straight}
        else if kneeBentAngle > 100 {return .bentOut}
        else if kneeBentAngle > 60 {return .bent}
        else {return .bentIn}
    }
}
