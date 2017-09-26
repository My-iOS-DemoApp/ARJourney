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
        
        // create physics body
        
        /** type .dynamic affects the node with with force and collision
         ** shape nil -> Scenekit automaticaly generates shape based on
         ** the geometry of the node.
         */
        let physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        
        /* By default isAffectedByGravity is true
         * cube falls immediately after adding to the scene
         */
        physicsBody.isAffectedByGravity = false
        physicsBody.mass = 2 // Unit is in kilo gram (kg)
        
        // create force direction
        let force = SCNVector3(0.3, 0, -0.5)
        
        /*
         * applies linear force in center of mass
         * if impulse in true then applied for one frame
         * other wise force will affect continuously.
         */
        physicsBody.applyForce(force, asImpulse: true)
        
        let physicsCube = Cube(box: boxGeometry, cubePosition: cubePosition, cubePhysicsBody: physicsBody)
        return physicsCube
    }
    
    
}
