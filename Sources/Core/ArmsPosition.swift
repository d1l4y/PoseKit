//
//  ArmsPosition.swift
//  BodyDetection
//
//  Created by Vinicius Dilay on 29/10/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import ARKit
import RealityKit

@available(iOS 13.0, *)

class ArmsPosition  {
    let bodyPart = BodyPart()

    
    /// posição do  cotovelo em relaçao ao ombro pra saber onde ele está
    func ShoulderToForearmPos(character: BodyTrackedEntity?, bodyAnchor: ARBodyAnchor, HandTransform: simd_float4, ForearmTransform: simd_float4, ShoulderTransform: simd_float4) -> ShoulderToForearmCase {
            let forearmShoulderVector : simd_float3 = [ForearmTransform.x - ShoulderTransform.x, ForearmTransform.y - ShoulderTransform.y, ForearmTransform.z - ShoulderTransform.z] //ajeitar
           
            //compara pelo eixo y (altura)
            if forearmShoulderVector.y < -0.1  { //cotovelo baixo
                return .down
            }
            else if  forearmShoulderVector.y > 0.1  { //alto
                return .up
            }
            else { //medio
                return .straight
            }
        }
    
    /// posição da mão em relaçao ao cotovelo pra saber onde ela está
        func ForearmToHandPos(character: BodyTrackedEntity?, bodyAnchor: ARBodyAnchor, forearmSubcase: ShoulderToForearmSubcase, HandTransform: simd_float4, ForearmTransform: simd_float4, ShoulderTransform: simd_float4) -> ForearmToHandSubcase {

            let handForearmVector = bodyPart.vector(joint1: ForearmTransform, joint2: HandTransform)
            let shoulderForearmVector  = bodyPart.vector(joint1: ForearmTransform, joint2: ShoulderTransform)

            let forearmAngle = abs(bodyPart.angle(vector1: handForearmVector, vector2: shoulderForearmVector))
            let crossVector = (simd_normalize(simd_cross(handForearmVector, shoulderForearmVector))) //produto vetorial deve bastar para saber o sentido
            
            if bodyPart.distance(joint1: ShoulderTransform, joint2: HandTransform) > 0.57 && forearmAngle > 125.0 {
                return .retoOutstretched    //braço esticados
            } else if crossVector.z < 0 {   //braço pra baixo
                if forearmAngle > 105.0 { return .bentDownOut }
                else if forearmAngle > 80 { return .bentDown }
                else if forearmAngle > 55 { return .bentDownIn }
            
            } else {

                if forearmAngle > 105.0 { return .bentUpOut }
                else if forearmAngle > 80 { return .bentUp }
                else if forearmAngle > 55 { return .bentUpIn }
            
            }
            return .bentRetoFront
        }
    
    /// chamada em ShoulderToForearmPos, compara o eixo z pra classificar o cotovelo
    func ShoulderToForearmPosZ(character: BodyTrackedEntity?, bodyAnchor: ARBodyAnchor, forearmCase: ShoulderToForearmCase, HandTransform: simd_float4, ForearmTransform: simd_float4, ShoulderTransform: simd_float4) -> ShoulderToForearmSubcase {
        let forearmShoulderVector  = bodyPart.vector(joint1: ShoulderTransform, joint2: ForearmTransform)
        
        switch forearmCase {
        case .down:
            if forearmShoulderVector.z < -0.05 {
                return .downBack    //pra baixo pra tras
            } else if forearmShoulderVector.z > 0.05 {
                if forearmShoulderVector.z > 0.2 {return .downTotFront} else {return .downFront} //pra tras pra frente ou totalmente pra frente
            } else {
                return .downStraight //pra trás reto
            }
            
        case .up:
            if forearmShoulderVector.z > 0.05 { //mais pra frente
                if forearmShoulderVector.z > 0.2 {return .upTotFront} else {return .upFront}
            } else {
                return .upStraight //pra frente reto
            }
            
        case .straight:
            if forearmShoulderVector.z < -0.05 { //&& forearmCase != .up { //mais pra tras
                return .retoBack        //reto pra tras
            } else if forearmShoulderVector.z > 0.05 {
                if forearmShoulderVector.z > 0.2 {return .retoTotFront} else {return .retoFrente}
            } else {
                return .reto
            }
            
        }

    }
}
