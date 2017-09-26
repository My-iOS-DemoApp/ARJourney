//
//  CubeScene.swift
//  ARJourney
//
//  Created by Shuvo on 9/26/17.
//  Copyright © 2017 S.M.Moinuddin (Shuvo). All rights reserved.
//

import UIKit
import SceneKit

class CubeScene: SCNScene {

    enum CubeType {
        case normal, physicsBody
    }
    
    init(CubeType type: CubeType) {
        super.init()
        
        let cube: Cube
        switch type {
        case .normal:
            cube = CubeFactory.createNormalCube()
        case .physicsBody:
            cube = CubeFactory.createPhysicsCube()
        }
        
        rootNode.addChildNode(cube)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
