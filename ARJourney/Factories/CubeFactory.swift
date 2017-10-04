//
//  CubeFactory.swift
//  ARJourney
//
//  Created by Shuvo on 9/26/17.
//  Copyright © 2017 S.M.Moinuddin (Shuvo). All rights reserved.
//

import Foundation
import SceneKit
import ARKit

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
        let cubePosition = SCNVector3(0.15, -0.3, -0.5)
        
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
        physicsBody.categoryBitMask = CollisionCategory.cube.rawValue
        physicsBody.collisionBitMask = CollisionCategory.dropCube.rawValue
        
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
    
    static func createDropCube(hitTestResult result: ARHitTestResult) -> Cube {
        let dimension: CGFloat = 0.1
        // The 3D Cube geometry we want to draw
        let boxGeometry = SCNBox(width: dimension, height: dimension, length: dimension, chamferRadius: 0.0)
        
        // assign color to the cube
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.red
        boxGeometry.materials = [material]
        
        let physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        physicsBody.mass = 2
        physicsBody.categoryBitMask = CollisionCategory.dropCube.rawValue
        physicsBody.collisionBitMask = CollisionCategory.cube.rawValue
        
        // position the cube slightly above the point user tapped
        let insertionYOffset:Float = 0.5
        let hitPosition = result.worldTransform.columns.3
        let cubePosition = SCNVector3(hitPosition.x, hitPosition.y + insertionYOffset, -0.5) //hitPosition.z
        
        let dropCube = Cube(box: boxGeometry, cubePosition: cubePosition, cubePhysicsBody: physicsBody)
        return dropCube
        
    }
    
    
}
