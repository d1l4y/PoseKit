//
//  LeftArmTracking.swift
//  BodyDetection
//
//  Created by Vinicius Dilay on 29/10/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import ARKit
import RealityKit

@available(iOS 13.0, *)
class LeftArmPosition: ArmsPosition {

    
    //Pega o transform global das joints(coordenadas em relação a root)
    var lShoulderTransform : simd_float4!
    var lForearmTransform : simd_float4!
    var lHandTransform : simd_float4!
    
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
    
    func lArmPosition(character: BodyTrackedEntity?, bodyAnchor: ARBodyAnchor){
        let lForearmSubcase = LeftShoulderToForearmPos(character: character, bodyAnchor: bodyAnchor, lHandTransform: lHandTransform, lForearmTransform: lForearmTransform, lShoulderTransform: lShoulderTransform)
        let lHandCase = ForearmToHandPos(character: character, bodyAnchor: bodyAnchor, forearmSubcase: lForearmSubcase, HandTransform: lHandTransform, ForearmTransform: lForearmTransform, ShoulderTransform: lShoulderTransform)
        print("Left Arm: ", lForearmSubcase, ", ", lHandCase )
    
    }

    
/// posição do  cotovelo em relaçao ao ombro pra saber onde ele está
    func LeftShoulderToForearmPos(character: BodyTrackedEntity?, bodyAnchor: ARBodyAnchor, lHandTransform: simd_float4, lForearmTransform: simd_float4, lShoulderTransform: simd_float4) -> ShoulderToForearmSubcase {
        let leftForearmCase = ShoulderToForearmPos(character: character, bodyAnchor: bodyAnchor, HandTransform: lHandTransform, ForearmTransform: lForearmTransform, ShoulderTransform: lShoulderTransform)
        
        return ShoulderToForearmPosZ(character: character, bodyAnchor: bodyAnchor, forearmCase: leftForearmCase, HandTransform: lHandTransform, ForearmTransform: lForearmTransform, ShoulderTransform: lShoulderTransform)
    }
    
    
///// chamada em ShoulderToForearmPos, compara o eixo z pra classificar o cotovelo
//    func ShoulderToForearmPosZ(character: BodyTrackedEntity?, bodyAnchor: ARBodyAnchor, forearmCase: ShoulderToForearmCase, lHandTransform: simd_float4, lForearmTransform: simd_float4, lShoulderTransform: simd_float4) -> ShoulderToForearmSubcase {
//        let forearmShoulderVector  = vector(joint1: lShoulderTransform, joint2: lForearmTransform)
//
//
//        if forearmCase == .down {//compara pelo eixo z
//            if forearmShoulderVector.z < -0.05 {
//                return .downBack    //pra baixo pra tras
//            } else if forearmShoulderVector.z > 0.05 {
//                if forearmShoulderVector.z > 0.2 {return .downTotFront} else {return .downFront} //pra tras pra frente ou totalmente pra frente
//            } else {
//                return .downStraight //pra trás reto
//            }
//            
//        } else if forearmCase == .up {//compara pelo eixo z
//            if forearmShoulderVector.z > 0.05 { //mais pra frente
//                if forearmShoulderVector.z > 0.2 {return .upTotFront} else {return .upFront}
//            } else {
//                return .upStraight //pra frente reto
//            }
//            
//        } else {
//            if forearmShoulderVector.z < -0.05 { //&& forearmCase != .up { //mais pra tras
//                return .retoBack        //reto pra tras
//            } else if forearmShoulderVector.z > 0.05 { 
//                if forearmShoulderVector.z > 0.2 {return .retoTotFront} else {return .retoFrente}
//            } else {
//                return .reto
//            }
//        }
//        
//    }
    
    
/// posição da mão em relaçao ao cotovelo pra saber onde ela está  **mudei pra ArmsPosition.swift**
//    func ForearmToHandPos(character: BodyTrackedEntity?, bodyAnchor: ARBodyAnchor, forearmSubcase: ShoulderToForearmSubcase, lHandTransform: simd_float4, lForearmTransform: simd_float4, lShoulderTransform: simd_float4) -> ForearmToShoulderSubcase {
//
//
//        let handForearmVector = vector(joint1: lForearmTransform, joint2: lHandTransform)
//        let shoulderForearmVector  = vector(joint1: lForearmTransform, joint2: lShoulderTransform)
//
//        let forearmAngle = abs(angle(vector1: handForearmVector, vector2: shoulderForearmVector))
////        print(forearmAngle, "nha")
//        let crossVector = (simd_normalize(simd_cross(handForearmVector, shoulderForearmVector))) //produto vetorial deve bastar para saber o sentido
//
//        if distance(joint1: lShoulderTransform, joint2: lHandTransform) > 0.57 && forearmAngle > 125.0 {//&& handForearmVector.y > -0.075 && handForearmVector.y < 0.075  { // continuar daqui, ver bug de dobrado pra frente
//            return .retoOutstretched    //braço esticados
//        }
//        else if crossVector.z < 0 {
//            if forearmAngle > 105.0 { return .bentDownOut }
//            else if forearmAngle > 80 { return .bentDown }
//            else if forearmAngle > 55 { return .bentDownIn }
//        }
//        else {
//            if forearmAngle > 105.0 { return .bentUpOut }
//            else if forearmAngle > 80 { return .bentUp }
//            else if forearmAngle > 55 { return .bentUpIn }
//        }
//        return .bentRetoFront
//    }
}


//            var handToShoulderOffset: Float {
//                //Pega as coordenadas dessas joints em relação a root (cintura) **pegando as coordenadas de ARSkeletonDefinition, ele pega do esqueleto padrão, do jeito que vem em robot.usdz**
//                let lForearmTransform = ARSkeletonDefinition.defaultBody3D.neutralBodySkeleton3D!.jointModelTransforms[lForearmIndex].columns.3
//                let lHandTransform = ARSkeletonDefinition.defaultBody3D.neutralBodySkeleton3D!.jointModelTransforms[lHandIndex].columns.3
//                let lShoulderTransform = ARSkeletonDefinition.defaultBody3D.neutralBodySkeleton3D!.jointModelTransforms[lShoulderIndex].columns.3
//                let lLocalForearmTransform = ARSkeletonDefinition.defaultBody3D.neutralBodySkeleton3D!.jointLocalTransforms[lForearmIndex].columns.3
//                let lLocalHandTransform = ARSkeletonDefinition.defaultBody3D.neutralBodySkeleton3D!.jointLocalTransforms[lHandIndex].columns.3
//                let lLocalShoulderTransform = ARSkeletonDefinition.defaultBody3D.neutralBodySkeleton3D!.jointLocalTransforms[lShoulderIndex].columns.3
//
//
//                //calcula a distância entre duas joints
//                return distance(joint1: lHandTransform, joint2: lShoulderTransform)
//            }
            
