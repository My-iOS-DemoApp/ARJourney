//
//  Plane.swift
//  ARMastering
//
//  Created by Shuvo on 9/24/17.
//  Copyright © 2017 S.M.Moinuddin (Shuvo). All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class Plane: SCNNode {

    var anchor: ARPlaneAnchor!
    var planeGeometry: SCNPlane!
    
    
    init(anchor: ARPlaneAnchor) {
        super.init()
        
        self.anchor = anchor
        let width = CGFloat(anchor.extent.x);
        let length = CGFloat(anchor.extent.z);
        
        // Create 3D plane geometry with the dimensions reported
        // by ARKit in the ARPlaneAchor instance
        planeGeometry = SCNPlane(width: width, height: length)
        
        // Visualizing Grid for plane
        let material = SCNMaterial()
        let gridImage = UIImage(named: "art.scnassets/tron/tron-albedo.png")
        material.diffuse.contents = gridImage
        planeGeometry.materials = [material]
        
        let planeNode = SCNNode(geometry: planeGeometry)
        
        // Move the plane to the position reported by ARKit
        planeNode.position = SCNVector3Make(anchor.center.x, 0, anchor.center.z);
        
        // Planes in Scenekit are Vertical by Default
        // rotate 90 degree to match planes in ARKit
        planeNode.transform = SCNMatrix4MakeRotation(Float(-Double.pi/2), 1.0, 0.0, 0.0)
        
        // Give the plane a physics body so that items we add to the scene interact with it
        planeNode.physicsBody = SCNPhysicsBody(type: .kinematic, shape: nil)
        //SCNPhysicsShape(geometry: planeGeometry, options: nil)
        
        setTextureScale()
        addChildNode(planeNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func update(anchor: ARPlaneAnchor) {
//        planeGeometry.width = CGFloat(anchor.extent.x)
//        planeGeometry.height = CGFloat(anchor.extent.z)
//
//        // When the plane is first created it's center is 0,0,0 and the nodes
//        // transform contains the translation parameters. As the plane is updated
//        // the planes translation remains the same but it's center is updated so
//        // we need to update the 3D geometry position
//        position = SCNVector3(anchor.center.x, 0, anchor.center.z)
//
//        guard let planeNode = childNodes.first else {return}
//        planeNode.physicsBody = SCNPhysicsBody(type: .kinematic, shape: nil)
//        //SCNPhysicsShape(geometry: planeGeometry, options: nil)
//
//        setTextureScale()
//    }
//
//    func setTextureScale() {
//        let width = Float(planeGeometry.width)
//        let height = Float(planeGeometry.length)
//
//        // As the width/height of the plane updates, we want our tron grid material to
//        // cover the entire plane, repeating the texture over and over. Also if the
//        // grid is less than 1 unit, we don't want to squash the texture to fit, so
//        // scaling updates the texture co-ordinates to crop the texture in that case
//
//        let material = planeGeometry.materials[4]
//
//        let scaleFactor: Float = 1;
//        let m = SCNMatrix4MakeScale(width * scaleFactor, height * scaleFactor, 1);
//        material.diffuse.contentsTransform = m;
//        material.roughness.contentsTransform = m;
//        material.metalness.contentsTransform = m;
//        material.normal.contentsTransform = m;
//
//    }
    
    func update(anchor: ARPlaneAnchor) {
        planeGeometry.width = CGFloat(anchor.extent.x)
        planeGeometry.height = CGFloat(anchor.extent.z)
        position = SCNVector3(anchor.center.x, 0, anchor.center.z)
        setTextureScale()
    }
    
    func setTextureScale() {
        let width = Float(planeGeometry.width)
        let height = Float(planeGeometry.height)

        /* As the width/height of the plane updates, we want our tron grid
         * material toccover the entire plane,
         * repeating the texture over and over. Also if the
         * grid is less than 1 unit,
         * we don't want to squash the texture to fit,
         * so scaling updates the texture co-ordinates
         * to crop the texture in that case
         */

        let material = planeGeometry.materials.first
        material?.diffuse.contentsTransform = SCNMatrix4MakeScale(width, height, 1)
        material?.diffuse.wrapS = .repeat
        material?.diffuse.wrapT = .repeat
    }
    
//    var planeGeometry: SCNPlane!
    
//    func previousPlaneSetup() {
//        /* create the 3D plane geometry with the dimension
//         * from ARPlaneAnchor instance reported by ARKit
//         */
//        planeGeometry = SCNPlane(width: CGFloat(anchor.extent.x), height: CGFloat(anchor.extent.y))
//
//        // Visualizing Grid for plane
//        let material = SCNMaterial()
//        let gridImage = UIImage(named: "art.scnassets/tron/tron-albedo.png")
//        material.diffuse.contents = gridImage
//
//        planeGeometry.materials = [material]
//
//        let planeNode = SCNNode(geometry: planeGeometry)
//
//        // move the plane to the position reported by ARKit
//        planeNode.position = SCNVector3(anchor.center.x, 0, anchor.center.z)
//
//        // Plane in SceneKit by default is vertical, so we rotate it by 90
//        // degrees to match planes in ARKit
//        planeNode.transform = SCNMatrix4MakeRotation(Float(-Double.pi/2), 1.0, 0.0, 0.0)
//
//        setTextureScale()
//        addChildNode(planeNode)
//    }
    
}
