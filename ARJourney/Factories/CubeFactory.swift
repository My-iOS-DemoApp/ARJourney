//
//  CubeFactory.swift
//  ARJourney
//
//  Created by Shuvo on 9/26/17.
//  Copyright © 2017 S.M.Moinuddin (Shuvo). All rights reserved.
//

import Foundation
import SceneKit

struct CubeFactory {
    
    static func createNormalCube() -> Cube {
        // The 3D Cube geometry we want to draw
        let boxGeometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.0)
        
        // position the cube just in front of camera
        let cubePosition = SCNVector3(0, 0, -0.5)
        
        let normalCube = Cube(box: boxGeometry, cubePosition: cubePosition)
        return normalCube
    }
    
    static func createPhysicsCube() -> Cube {
        // The 3D Cube geometry we want to draw
        let boxGeometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.0)
        
        // position the cube just in front of camera
        let cubePosition = SCNVector3(0, 0, -0.5)
        
        let normalCube = Cube(box: boxGeometry, cubePosition: cubePosition)
        return normalCube
    }
    
    
}
