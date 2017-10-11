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
    var planeGeometry: SCNBox!
    
    
    init(anchor: ARPlaneAnchor) {
        super.init()
        
        self.anchor = anchor
        let width = CGFloat(anchor.extent.x);
        let length = CGFloat(anchor.extent.z);
        
        // Using a SCNBox and not SCNPlane to make it easy for the geometry we add to the
        // scene to interact with the plane.
        
        // For the physics engine to work properly give the plane some height so we get interactions
        // between the plane and the gometry we add to the scene
        let planeHeight:CGFloat = 0.01;
        
        planeGeometry = SCNBox(width: width, height: planeHeight, length: length, chamferRadius: 0)
        
        
        // Since we are using a cube, we only want to render the tron grid
        // on the top face, make the other sides transparent
        let transparentMaterial = SCNMaterial()
        transparentMaterial.diffuse.contents = UIColor(white: 1, alpha: 0)
        
        // Visualizing Grid for plane
        let material = SCNMaterial()
        let gridImage = UIImage(named: "art.scnassets/tron/tron-albedo.png")
        material.diffuse.contents = gridImage
        
        // The plane is now a cube!!
        // so make the other 5 sides Transparent
        planeGeometry.materials = [transparentMaterial,transparentMaterial,transparentMaterial,transparentMaterial,material,transparentMaterial]
        
        
        
        let planeNode = SCNNode(geometry: planeGeometry)
        
        // Since our plane has some height, move it down to be at the actual surface
        planeNode.position = SCNVector3Make(0, -0.05, 0);
        
        // Give the plane a physics body so that items we add to the scene interact with it
        planeNode.physicsBody = SCNPhysicsBody(type: .kinematic, shape: nil)
        //SCNPhysicsShape(geometry: planeGeometry, options: nil)
        
        setTextureScale()
        addChildNode(planeNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func remove() {
        self.removeFromParentNode()
    }
    
    func update(anchor: ARPlaneAnchor) {
        planeGeometry.width = CGFloat(anchor.extent.x)
        planeGeometry.length = CGFloat(anchor.extent.z) // watchout this param
        
        // When the plane is first created it's center is 0,0,0 and the nodes
        // transform contains the translation parameters. As the plane is updated
        // the planes translation remains the same but it's center is updated so
        // we need to update the 3D geometry position
        position = SCNVector3(anchor.center.x, 0, anchor.center.z)
        
        guard let planeNode = childNodes.first else {return}
        planeNode.physicsBody = SCNPhysicsBody(type: .kinematic, shape: SCNPhysicsShape(geometry: planeGeometry, options: nil))
        
        setTextureScale()
    }
    
    private func setTextureScale() {
        let width = Float(planeGeometry.width)
        let height = Float(planeGeometry.length)

        // As the width/height of the plane updates, we want our tron grid material to
        // cover the entire plane, repeating the texture over and over. Also if the
        // grid is less than 1 unit, we don't want to squash the texture to fit, so
        // scaling updates the texture co-ordinates to crop the texture in that case

        let material = planeGeometry.materials[4]

        let scaleFactor: Float = 1
        let m = SCNMatrix4MakeScale(width * scaleFactor, height * scaleFactor, 1)
        
        material.diffuse.contentsTransform = m
        // tron overlaping/solid color problem solved
        material.diffuse.wrapS = .repeat
        material.diffuse.wrapT = .repeat
        
        material.roughness.contentsTransform = m
        material.metalness.contentsTransform = m
        material.normal.contentsTransform = m

    }
    
    
}
