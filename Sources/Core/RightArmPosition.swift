//
//  RightArmPosition.swift
//  BodyDetection
//
//  Created by Vinicius Dilay on 30/10/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import ARKit
import RealityKit
@available(iOS 13.0, *)

internal class RightArmPosition: ArmsPosition {

    //Pega o transform global das joints(coordenadas em relação a root)
    var rShoulderTransform : simd_float4!
    var rForearmTransform : simd_float4!
    var rHandTransform : simd_float4!
    
    init(character: BodyTrackedEntity?, bodyAnchor: ARBodyAnchor) {

        guard let rForearmName = character?.jointName(forPath: "right_forearm_joint" ) else { print("right_forearm_joint not found!"); return}
        
        // Pega o index das joints necessárias
        let rForearmIndex = ARSkeletonDefinition.defaultBody3D.index(for: rForearmName)
        let rHandIndex = ARSkeletonDefinition.defaultBody3D.index(for: .rightHand)
        let rShoulderIndex = ARSkeletonDefinition.defaultBody3D.index(for: .rightShoulder)
        
        //Pega o transform global das joints(coordenadas em relação a root)
        self.rShoulderTransform = bodyAnchor.skeleton.jointModelTransforms[rShoulderIndex].columns.3
        self.rForearmTransform = bodyAnchor.skeleton.jointModelTransforms[rForearmIndex].columns.3
        self.rHandTransform = bodyAnchor.skeleton.jointModelTransforms[rHandIndex].columns.3
  
    }
    

    
    func rArmPosition(character: BodyTrackedEntity?, bodyAnchor: ARBodyAnchor) {
        
        let rForearmSubcase = RightShoulderToForearmPos(character: character, bodyAnchor: bodyAnchor, rHandTransform: rHandTransform, rForearmTransform: rForearmTransform, rShoulderTransform: rShoulderTransform)
        let rHandCase = ForearmToHandPos(character: character, bodyAnchor: bodyAnchor, forearmSubcase: rForearmSubcase, HandTransform: rHandTransform, ForearmTransform: rForearmTransform, ShoulderTransform: rShoulderTransform)
        
        print("right Arm: ", rForearmSubcase, ", ", rHandCase )
        
    }
    
    func forearmPosition(character: BodyTrackedEntity?, bodyAnchor: ARBodyAnchor) -> String {
        
        let rArmSubcase = RightShoulderToForearmPos(character: character, bodyAnchor: bodyAnchor, rHandTransform: rHandTransform, rForearmTransform: rForearmTransform, rShoulderTransform: rShoulderTransform)
        let rForearmCase = ForearmToHandPos(character: character, bodyAnchor: bodyAnchor, forearmSubcase: rArmSubcase, HandTransform: rHandTransform, ForearmTransform: rForearmTransform, ShoulderTransform: rShoulderTransform)
        
        return "\(rForearmCase)"
    }
    
    func armPosition(character: BodyTrackedEntity?, bodyAnchor: ARBodyAnchor) -> String {
        
        let rArmSubcase = RightShoulderToForearmPos(character: character, bodyAnchor: bodyAnchor, rHandTransform: rHandTransform, rForearmTransform: rForearmTransform, rShoulderTransform: rShoulderTransform)
        let rForearmCase = ForearmToHandPos(character: character, bodyAnchor: bodyAnchor, forearmSubcase: rArmSubcase, HandTransform: rHandTransform, ForearmTransform: rForearmTransform, ShoulderTransform: rShoulderTransform)
        
        return "\(rArmSubcase)"
    }
    
    
    /// posição do  cotovelo em relaçao ao ombro pra saber onde ele está
    func RightShoulderToForearmPos(character: BodyTrackedEntity?, bodyAnchor: ARBodyAnchor, rHandTransform: simd_float4, rForearmTransform: simd_float4, rShoulderTransform: simd_float4) -> ShoulderToForearmSubcase {
        let rightForearmCase = ShoulderToForearmPos(character: character, bodyAnchor: bodyAnchor, HandTransform: rHandTransform, ForearmTransform: rForearmTransform, ShoulderTransform: rShoulderTransform)
        
        return ShoulderToForearmPosZ(character: character, bodyAnchor: bodyAnchor, forearmCase: rightForearmCase, HandTransform: rHandTransform, ForearmTransform: rForearmTransform, ShoulderTransform: rShoulderTransform)
    }
}
