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
    

    public func BodyTrackingPosition(character: BodyTrackedEntity?, bodyAnchor: ARBodyAnchor) -> String {
        
        let leftArmPos = LeftArmPosition(character: character, bodyAnchor: bodyAnchor)
        let rightArmPos = RightArmPosition(character: character, bodyAnchor: bodyAnchor)
        let leftLegPos = LeftLegPosition(character: character, bodyAnchor: bodyAnchor)
        let rightLegPos = RightLegPosition(character: character, bodyAnchor: bodyAnchor)
            
        let position_rightArm = rightArmPos.rArmPosition(character: character, bodyAnchor: bodyAnchor)
        let position_leftArm = leftArmPos.lArmPosition(character: character, bodyAnchor: bodyAnchor)
        let position_leftLeg = leftLegPos.lLegPosition(character: character, bodyAnchor: bodyAnchor)
        let position_rightLeg = rightLegPos.rLegPosition(character: character, bodyAnchor: bodyAnchor)
     
        let pos_leftArm = bodyPosition(name: "leftArm", position: "\(position_leftArm.ArmCase)")
        let pos_leftForearm = bodyPosition(name: "leftForearm", position: "\(position_leftArm.HandCase)")
        let pos_rightArm = bodyPosition(name: "rightArm", position: "\(position_rightArm.ArmCase)")
        let pos_rightForearm = bodyPosition(name: "rightForearm", position: "\(position_rightArm.HandCase)")
        let pos_leftLeg = bodyPosition(name: "leftLeg", position: "\(position_leftLeg.legCase)")
        let pos_leftForeleg = bodyPosition(name: "leftForeleg", position: "\(position_leftLeg.kneeCase)")
        let pos_rightLeg = bodyPosition(name: "rightLeg", position: "\(position_rightLeg.legCase)")
        let pos_rightForeleg = bodyPosition(name: "rightForeleg", position: "\(position_rightLeg.legCase)")
        
        let bodyPositions = json_BodyPositions(position_leftArm: pos_leftArm, position_leftForearm: pos_leftForearm, position_rightArm: pos_rightArm, position_rightForearm: pos_rightForearm, position_leftLeg: pos_leftLeg, position_leftForeleg: pos_leftForeleg, position_rightLeg: pos_rightLeg, position_rightForeleg: pos_rightForeleg)
        
        let encoder = JSONEncoder()
        
        encoder.outputFormatting = .prettyPrinted
        
        var str = String()

        do {
            let jsonData = try encoder.encode(bodyPositions)

            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print("JSON: \(jsonString)")

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
