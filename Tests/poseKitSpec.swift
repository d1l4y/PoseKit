//
//  poseKitSpec.swift
//  poseKit
//
//  Created by Vinicius Dilay, Isabela Castro, Leonardo Palinkas, Lucas Ronnau, Saulo da Silva on 01/04/19.
//  Copyright © 2019 d1l4y. All rights reserved.
//

import Quick
import Nimble
@testable import poseKit

class poseKitSpec: QuickSpec {
    override func spec() {
        describe("poseKitSpec") {
            it("works") {
                expect(poseKit.name) == "poseKit"
            }
        }
    }
}
