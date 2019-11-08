//
//  poseKit.swift
//  poseKit
//
//  Created by Vinicius Dilay, Isabela Castro, Leonardo Palinkas, Lucas Ronnau, Saulo da Silva on 01/04/19.
//  Copyright © 2019 d1l4y. All rights reserved.
//

import ARKit
import RealityKit

// interface de comunicação com o resto do programa (facade pattern)
@available(iOS 13.0, *)
public class PoseKit {
    
    struct bodyPosition: Codable {
        var name : String
        var position : String
    }
    
    struct json_BodyPositions: Codable {
        var position_leftArm: bodyPosition
        var position_leftForearm: bodyPosition
        var position_rightArm: bodyPosition
        var position_rightForearm: bodyPosition
        var position_leftLeg: bodyPosition
        var position_leftForeleg: bodyPosition
        var position_rightLeg: bodyPosition
        var position_rightForeleg: bodyPosition
    }
    
    public func BodyTrackingPosition(character: BodyTrackedEntity?, bodyAnchor: ARBodyAnchor) {
        let leftArmPos = LeftArmPosition(character: character, bodyAnchor: bodyAnchor)
        let rightArmPos = RightArmPosition(character: character, bodyAnchor: bodyAnchor)
        leftArmPos.lArmPosition(character: character, bodyAnchor: bodyAnchor)
        rightArmPos.rArmPosition(character: character, bodyAnchor: bodyAnchor)
//        leftLeg.LeftLegPos(character: character, bodyAnchor: bodyAnchor)
//        leg.legPos(character: character, bodyAnchor: bodyAnchor)
    }
    
    public func retornaLeftArmJSON(character: BodyTrackedEntity, bodyAnchor: ARBodyAnchor) -> String {
        
        let leftArmPos = LeftArmPosition(character: character, bodyAnchor: bodyAnchor)
        let rightArmPos = RightArmPosition(character: character, bodyAnchor: bodyAnchor)
        let leftLegPos = LeftLegPosition(character: character, bodyAnchor: bodyAnchor)
        let rightLegPos = RightLegPosition(character: character, bodyAnchor: bodyAnchor)
            
        let position_leftArm = leftArmPos.armPosition(character: character, bodyAnchor: bodyAnchor)
        let position_rightArm = rightArmPos.armPosition(character: character, bodyAnchor: bodyAnchor)
        let position_leftForearm = leftArmPos.forearmPosition(character: character, bodyAnchor: bodyAnchor)
        let position_rightForearm = rightArmPos.forearmPosition(character: character, bodyAnchor: bodyAnchor)
        let position_leftLeg = leftLegPos.legPosition(character: character, bodyAnchor: bodyAnchor)
        let position_rightLeg = rightLegPos.legPosition(character: character, bodyAnchor: bodyAnchor)
        let position_leftForeleg = leftLegPos.forelegPosition(character: character, bodyAnchor: bodyAnchor)
        let position_rightForeleg = rightLegPos.forelegPosition(character: character, bodyAnchor: bodyAnchor)
        
        let pos_leftArm = bodyPosition(name: "leftArm", position: position_leftArm)
        let pos_leftForearm = bodyPosition(name: "leftForearm", position: position_leftForearm)
        let pos_rightArm = bodyPosition(name: "rightArm", position: position_rightArm)
        let pos_rightForearm = bodyPosition(name: "rightForearm", position: position_rightForearm)
        let pos_leftLeg = bodyPosition(name: "leftLeg", position: position_leftLeg)
        let pos_leftForeleg = bodyPosition(name: "leftForeleg", position: position_leftForeleg)
        let pos_rightLeg = bodyPosition(name: "rightLeg", position: position_rightLeg)
        let pos_rightForeleg = bodyPosition(name: "rightForeleg", position: position_rightForeleg)
        
        let bodyPositions = json_BodyPositions(position_leftArm: pos_leftArm, position_leftForearm: pos_leftForearm, position_rightArm: pos_rightArm, position_rightForearm: pos_rightForearm, position_leftLeg: pos_leftLeg, position_leftForeleg: pos_leftForeleg, position_rightLeg: pos_rightLeg, position_rightForeleg: pos_rightForeleg)
        
        let encoder = JSONEncoder()
        
        encoder.outputFormatting = .prettyPrinted
        
        var str = String()

        do {
            let jsonData = try encoder.encode(bodyPositions)

            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print("JSON: \(jsonString)")

    //                self.createAlert(jsonString)
                str = jsonString
            }
        } catch {
            print(error.localizedDescription)
        }
        return str
    }

    
}



@available(iOS 13.0, *)
extension BodyTrackedEntity {
    func jointName(forPath path: String) -> ARSkeleton.JointName {
        let splitPath = path.split(separator: "/")
        return ARSkeleton.JointName(rawValue: String(splitPath[splitPath.count - 1]))
    }
}
