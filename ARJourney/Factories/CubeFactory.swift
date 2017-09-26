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
        
        // assign color to the cube
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.green
        boxGeometry.materials = [material]
        
        
        // position the cube just in front of camera
        let cubePosition = SCNVector3(0.3, 0, -0.55)
        
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
        
        // create force direction and magnitude.
        let force = SCNVector3(0.3, 0, 0)
        
        // create point/position where the force or impulse should apply
        //let fPosition = SCNVector3(0.2, 0, 0)
        
        /*
         * applies linear force in center of mass
         * if impulse is false then applied for one frame
         * treat direction param as a force, Unit Newton
         * other wise force will affect continuously/
         * instantaneous change in momentum.
         * Unit newton-second
         */
        physicsBody.applyForce(force, asImpulse: false)
        
        //physicsBody.applyForce(force, at: fPosition, asImpulse: false)
        
        let physicsCube = Cube(box: boxGeometry, cubePosition: cubePosition, cubePhysicsBody: physicsBody)
        return physicsCube
    }
    
    
}
