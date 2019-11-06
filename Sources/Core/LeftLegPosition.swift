//
//  LeftLegPosition.swift
//  BodyDetection
//
//  Created by Vinicius Dilay on 31/10/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import ARKit
import RealityKit
@available(iOS 13.0, *)

class LeftLegPosition : LegsPosition {
    
    var lKneeTransform : simd_float4!
    var rootTransform : simd_float4!
    var lFootTransform : simd_float4!
    var lLegTransform : simd_float4!
    
    init(character: BodyTrackedEntity?, bodyAnchor: ARBodyAnchor) {
        
        guard let lKnee = character?.jointName(forPath: "left_leg_joint") else { print("falha de leitura left leg"); return}
        guard let lLeg = character?.jointName(forPath: "left_upLeg_joint") else { print("falha de leitura left up leg"); return}
        let lKneeIndex = ARSkeletonDefinition.defaultBody3D.index(for: lKnee)
        let rootIndex = ARSkeletonDefinition.defaultBody3D.index(for: .root)
        let lFootIndex = ARSkeletonDefinition.defaultBody3D.index(for: .leftFoot)
        let lLegIndex = ARSkeletonDefinition.defaultBody3D.index(for: lLeg)
        

        //Pega o transform global das joints(coordenadas em relação a root)

        lKneeTransform = bodyAnchor.skeleton.jointModelTransforms[lKneeIndex].columns.3
        rootTransform = bodyAnchor.skeleton.jointModelTransforms[rootIndex].columns.3
        lFootTransform = bodyAnchor.skeleton.jointModelTransforms[lFootIndex].columns.3
        lLegTransform = bodyAnchor.skeleton.jointModelTransforms[lLegIndex].columns.3
        
    }
    
    
    func rLegPos(character: BodyTrackedEntity?, bodyAnchor: ARBodyAnchor){
        
        let lLegToKneeSubcase = LegToKneePos( kneeTransform: lKneeTransform, legTransform: lLegTransform)
        let lKneeToFootCase = KneeToFootPos(kneeTransform: lKneeTransform, legTransform: lLegTransform, footTransform: lFootTransform, legToKneeSubcase: lLegToKneeSubcase)
    }
    
        
//        let vectorRootLeftLeg = vector(joint1: rootTransform, joint2: lLegTransform)
//
//        let vectorLeftLegToKnee = vector(joint1: lKneeTransform, joint2: lLegTransform)
//
//        let vectorLeftLegFoot = vector(joint1: lLegTransform, joint2: lFootTransform)
//
//        let distanciaLeftLegToLeftFoot = simd_distance(lLegTransform, lFootTransform)
//
////        print(vectorLeftKneeToLeg.y)
//
//
//        let angulo = angle(vector1: vectorRootLeftLeg, vector2: vectorRootRightLeg)
//        let anguloJE = angle(vector1: vectorLeftLegToKnee, vector2: vectorLeftLegFoot)
       // print(anguloJE)
        //print(anguloJE)
        
        //            let angulo = angle(vector1: vetorId, vector2: simd_float4(1,vetorId.y,vetorId.z,vetorId.w))
        
        
        
//        print("angulo entre pernas: ", angulo)
//        print("angulo joelho esquerdo: ", anguloJE)
//        print("angulo joelho direito: ", anguloJD)
        
        
        
        //            switch angulo {
        //            case 0..<35:
        //                print("pernas fechadas")
        //            case 35..<70:
        //                print("pernas abertas")
        //            case 70..<105:
        //                print("pernas muito abertas")
        //            default:
        //                print("espacate")
        //            }
    

    // pensar nos casos para ambos as pernas
    // se ambos muito dobrados, agachado
    // se ambos retos, de pé
    //se ambos dobrados, pernas abertas
}

