//
//  Cube.swift
//  ARJourney
//
//  Created by Shuvo on 9/26/17.
//  Copyright © 2017 S.M.Moinuddin (Shuvo). All rights reserved.
//

import UIKit
import SceneKit

class Cube: SCNNode {

    init(box: SCNBox, cubePosition: SCNVector3, cubePhysicsBody: SCNPhysicsBody?=nil) {
        super.init()
        
        let cubeNode = SCNNode(geometry: box)
        cubeNode.position = cubePosition
        cubeNode.physicsBody = cubePhysicsBody
        
        addChildNode(cubeNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
