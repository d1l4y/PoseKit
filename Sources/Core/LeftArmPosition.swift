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
internal class LeftArmPosition: ArmsPosition {

    
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
    
    func forearmPosition(character: BodyTrackedEntity?, bodyAnchor: ARBodyAnchor) -> String{
        let lArmSubcase = LeftShoulderToForearmPos(character: character, bodyAnchor: bodyAnchor, lHandTransform: lHandTransform, lForearmTransform: lForearmTransform, lShoulderTransform: lShoulderTransform)
        let lForearmCase = ForearmToHandPos(character: character, bodyAnchor: bodyAnchor, forearmSubcase: lArmSubcase, HandTransform: lHandTransform, ForearmTransform: lForearmTransform, ShoulderTransform: lShoulderTransform)
        
        return "\(lForearmCase)"
    }
    
    func armPosition(character: BodyTrackedEntity?, bodyAnchor: ARBodyAnchor) -> String{
        let lArmSubcase = LeftShoulderToForearmPos(character: character, bodyAnchor: bodyAnchor, lHandTransform: lHandTransform, lForearmTransform: lForearmTransform, lShoulderTransform: lShoulderTransform)
        let lForearmCase = ForearmToHandPos(character: character, bodyAnchor: bodyAnchor, forearmSubcase: lArmSubcase, HandTransform: lHandTransform, ForearmTransform: lForearmTransform, ShoulderTransform: lShoulderTransform)

        return "\(lArmSubcase)"
    }

    
/// posição do  cotovelo em relaçao ao ombro pra saber onde ele está
    func LeftShoulderToForearmPos(character: BodyTrackedEntity?, bodyAnchor: ARBodyAnchor, lHandTransform: simd_float4, lForearmTransform: simd_float4, lShoulderTransform: simd_float4) -> ShoulderToForearmSubcase {
        let leftForearmCase = ShoulderToForearmPos(character: character, bodyAnchor: bodyAnchor, HandTransform: lHandTransform, ForearmTransform: lForearmTransform, ShoulderTransform: lShoulderTransform)
        
        return ShoulderToForearmPosZ(character: character, bodyAnchor: bodyAnchor, forearmCase: leftForearmCase, HandTransform: lHandTransform, ForearmTransform: lForearmTransform, ShoulderTransform: lShoulderTransform)
    }
    
}
