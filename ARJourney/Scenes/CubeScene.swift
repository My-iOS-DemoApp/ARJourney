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
        case normal, physicsBody, all
    }
    
    init(CubeType type: CubeType) {
        super.init()
        
        if type == .all {
            let nCube = CubeFactory.createNormalCube()
            let pCube = CubeFactory.createPhysicsCube()
            rootNode.addChildNode(nCube)
            rootNode.addChildNode(pCube)
            
        } else {
            let cube: Cube
            switch type {
            case .normal:
                cube = CubeFactory.createNormalCube()
            case .physicsBody:
                cube = CubeFactory.createPhysicsCube()
            default:
                cube = CubeFactory.createNormalCube()
                break
            }
            
            rootNode.addChildNode(cube)
        }
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
