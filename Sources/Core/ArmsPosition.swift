//
//  ArmsPosition.swift
//  BodyDetection
//
//  Created by Vinicius Dilay on 29/10/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import ARKit
import RealityKit

/// This class gets the positions of the **arms** by creating vectors from a joint to another and comparing the axes and angles.
internal class ArmsPosition  {
    let bodyPart = BodyPart()

    struct armCases {
        let ArmCase : ShoulderToForearmSubcase
        let HandCase: ForearmToHandSubcase
    }
    
    
    /// Gets the **elbow's** position related to the **shoulder** by comparing the Y axe.
    func ShoulderToForearmPos(character: BodyTrackedEntity?, bodyAnchor: ARBodyAnchor, HandTransform: simd_float4, ForearmTransform: simd_float4, ShoulderTransform: simd_float4) -> ShoulderToForearmCase {
            let forearmShoulderVector : simd_float3 = [ForearmTransform.x - ShoulderTransform.x, ForearmTransform.y - ShoulderTransform.y, ForearmTransform.z - ShoulderTransform.z] //ajeitar
           
            //compara pelo eixo y (altura)
            if forearmShoulderVector.y < -0.1  { //cotovelo baixo
                return .verticalDown
            }
            else if  forearmShoulderVector.y > 0.1  { //alto
                return .verticalUp
            }
            else { //medio
                return .horizontal
            }
        }
    
    /// Gets the **hand's** position related to the **elbow** by comparing the angle between the forearm and the upper arm.
    func ForearmToHandPos(character: BodyTrackedEntity?, bodyAnchor: ARBodyAnchor, forearmSubcase: ShoulderToForearmSubcase, HandTransform: simd_float4, ForearmTransform: simd_float4, ShoulderTransform: simd_float4, leftArm: Bool) -> ForearmToHandSubcase {

        let handForearmVector = bodyPart.vector(joint1: ForearmTransform, joint2: HandTransform)
        let shoulderForearmVector  = bodyPart.vector(joint1: ForearmTransform, joint2: ShoulderTransform)
        
        let forearmAngle = abs(bodyPart.angle(vector1: handForearmVector, vector2: shoulderForearmVector))
        let crossVector = (simd_normalize(simd_cross(handForearmVector, shoulderForearmVector))) //produto vetorial deve bastar para saber o sentido
        
        if simd_distance(ShoulderTransform, HandTransform) > 0.57 && forearmAngle > 125.0 {
            return .straightHorizontal
        }
        if forearmSubcase == .verticalDownDiagonalBack || forearmSubcase == .verticalDownDiagonalFront || forearmSubcase == .verticalDownParallel || forearmSubcase == .horizontalTransverse {
            return ForearmToHandDownCase(forearmAngle: forearmAngle, crossVector: crossVector, leftArm: leftArm)
        } else if leftArm {
            if crossVector.z < 0 {
                if forearmAngle > 105.0 { return .bentDownOut }
                else if forearmAngle > 80 { return .bentDown }
                else if forearmAngle > 55 { return .bentDownIn }
                
            } else {
                if forearmAngle > 105.0 { return .bentUpOut }
                else if forearmAngle > 80 { return .bentUp }
                else if forearmAngle > 55 { return .bentUpIn }
            }
        } else {
            if crossVector.z < 0 {
                if forearmAngle > 105.0 { return .bentUpOut }
                else if forearmAngle > 80 { return .bentUp }
                else if forearmAngle > 55 { return .bentUpIn }
                
            } else {
                if forearmAngle > 105.0 { return .bentDownOut }
                else if forearmAngle > 80 { return .bentDown }
                else if forearmAngle > 55 { return .bentDownIn }
            }
        }
            return .horizontalBentIn
        }
    
    
    /// Gets the **hand's** position related to the **elbow**  in the verticalDown case, by comparing the angle between the forearm and the upper arm.
    func ForearmToHandDownCase(forearmAngle: Float, crossVector: simd_float3, leftArm: Bool) -> ForearmToHandSubcase {
        if leftArm {
            if crossVector.z < 0 {
                if forearmAngle > 125.0 { return .bentDownOut }
                else if forearmAngle > 95 { return .bentDown }
                else if forearmAngle > 70 { return .bentDownIn }
                
            } else {
                if forearmAngle > 125.0 { return .bentUpOut }
                else if forearmAngle > 95 { return .bentUp }
                else if forearmAngle > 70 { return .bentUpIn }
            }
        } else {
            if crossVector.z < 0 {
                if forearmAngle > 125.0 { return .bentUpOut }
                else if forearmAngle > 95 { return .bentUp }
                else if forearmAngle > 70 { return .bentUpIn }

            } else {
                if forearmAngle > 125.0 { return .bentDownOut }
                else if forearmAngle > 95 { return .bentDown }
                else if forearmAngle > 70 { return .bentDownIn }
            }
        }
        return .horizontalBentIn
    }
    
    
    /// Compares the **X axe** to classify the elbow's position.  Should be called at **ShoulderToForearmPos**
    func ShoulderToForearmPosZ(character: BodyTrackedEntity?, bodyAnchor: ARBodyAnchor, forearmCase: ShoulderToForearmCase, HandTransform: simd_float4, ForearmTransform: simd_float4, ShoulderTransform: simd_float4) -> ShoulderToForearmSubcase {
        let forearmShoulderVector  = bodyPart.vector(joint1: ShoulderTransform, joint2: ForearmTransform)
        
        switch forearmCase {
        case .verticalDown:
            if forearmShoulderVector.z < -0.05 {
                return .verticalDownDiagonalBack    //pra baixo pra tras
            } else if forearmShoulderVector.z > 0.05 {
                if forearmShoulderVector.z > 0.2 {return .verticalDownTransverse} else {return .verticalDownDiagonalBack} //pra tras pra frente ou totalmente pra frente
            } else {
                return .verticalUpParallel //pra trás reto
            }
            
        case .verticalUp:
            if forearmShoulderVector.z > 0.05 { //mais pra frente
                if forearmShoulderVector.z > 0.2 {return .verticalUpTransverse} else {return .verticalUpDiagonalFront}
            } else {
                return .verticalUpParallel //pra frente reto
            }
            
        case .horizontal:
            if forearmShoulderVector.z < -0.05 { //&& forearmCase != .up { //mais pra tras
                return .horizontalDiagonalBack       //reto pra tras
            } else if forearmShoulderVector.z > 0.05 {
                if forearmShoulderVector.z > 0.2 {return .horizontalTransverse} else {return .horizontalDiagonalFront}
            } else {
                return .horizontalParallel
            }
            
        }

    }
}
