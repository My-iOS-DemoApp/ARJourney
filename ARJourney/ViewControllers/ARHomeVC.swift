//
//  ARHomeVC.swift
//  ARJourney
//
//  Created by Shuvo on 9/26/17.
//  Copyright © 2017 S.M.Moinuddin (Shuvo). All rights reserved.
//

import UIKit
import ARKit

class ARHomeVC: UIViewController {
    
    @IBOutlet private var sceneView: ARSCNView!
    private var planes = [UUID : Plane]()
    
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSceneView()
        //addNormalCubeScene()
        //addPhysicsCubeScene()
        
        // assign tap gesture to sceneView
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ARHomeVC.handleSingleTap))
        tapGesture.numberOfTapsRequired = 1
        sceneView.addGestureRecognizer(tapGesture)
        
        // setup delegate for physicsWorld contact
        sceneView.scene.physicsWorld.contactDelegate = self
        
        // setup delegate for ARSCNView
        sceneView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // enable detecting horizontal plane
        // otherwise renderer delegate methods will not get called.
        configuration.planeDetection = .horizontal
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //addPhysicsCubeScene()
        addCubeScene()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    //MARK:- Button Actions
    @IBAction func stopPlaneDetection(_ sender: UISwitch) {
        if !sender.isOn {
            stopDetection()
        }
    }
    
    //MARK:- Private Methods
    private func setupSceneView() {
        sceneView.autoenablesDefaultLighting = true
        sceneView.automaticallyUpdatesLighting = true
        sceneView.preferredFramesPerSecond = 60
        
        /* Turn on debug option, to see
         * the area tracking performing well or not. */
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
    }
    
    private func stopDetection() {
        guard let configuration = sceneView.session.configuration as? ARWorldTrackingConfiguration else {return}
        configuration.planeDetection = .init(rawValue: 0)
        sceneView.session.run(configuration)
    }
    
    private func addNormalCubeScene() {
        let cubeScene = CubeScene(CubeType: .normal)
        sceneView.scene = cubeScene
    }
    
    private func addPhysicsCubeScene() {
        let cubeScene = CubeScene(CubeType: .physicsBody)
        sceneView.scene = cubeScene
    }
    
    private func addCubeScene() {
        let cubeScene = CubeScene(CubeType: .all)
        sceneView.scene = cubeScene
    }
    
    @objc private func handleSingleTap(recognizer: UITapGestureRecognizer) {
        
        let tapPoint = recognizer.location(in: sceneView)
        
        /* Throws a ray from camera to the
         * estimate horizontal plane, determined for the current frame.
         * return results if the throwed ray intersects with the
         * estimated horizontal plane.
         */
        let hitTestResults: [ARHitTestResult] = sceneView.hitTest(tapPoint, types: .existingPlaneUsingExtent)
        
        if hitTestResults.count == 0 {return}
        
        guard let hitResult = hitTestResults.first else {return}
        
        let dropCube = CubeFactory.createDropCube(hitTestResult: hitResult)
        sceneView.scene.rootNode.addChildNode(dropCube)
        
    }
    
}


extension ARHomeVC: SCNPhysicsContactDelegate {
    
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        print("contact delegate get called")
        let nodeAmask = contact.nodeA.physicsBody?.categoryBitMask
        let nodeBmask = contact.nodeB.physicsBody?.categoryBitMask
        
        let contactMask = nodeAmask! | nodeBmask!
        
        // sort out what kind of collision, dropCube or cube?
        if (contactMask == CollisionCategory.dropCube.rawValue | CollisionCategory.cube.rawValue) {
            
            // find out which body is the cube and which is dropCube
            if (contact.nodeA.physicsBody?.categoryBitMask == CollisionCategory.dropCube.rawValue) {
                // remove the cube node [which is nodeB]
                contact.nodeB.removeFromParentNode()
            } else {
                // remove the cube node [which is nodeA]
                contact.nodeA.removeFromParentNode()
            }
        }
        
    }
}


extension ARHomeVC: ARSCNViewDelegate {
    
    // called when new node has been mapped to the given anchor
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
        guard let arAnchor = anchor as? ARPlaneAnchor else {return}
        
        let plane = Plane(anchor: arAnchor)
        planes[anchor.identifier] = plane
        node.addChildNode(plane)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        
        guard let arAnchor = anchor as? ARPlaneAnchor else {return}
        guard let plane = planes[arAnchor.identifier] else {return}
        plane.update(anchor: arAnchor)
        
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
        
        guard let arAnchor = anchor as? ARPlaneAnchor else {return}
        planes.removeValue(forKey: arAnchor.identifier)
    }
    
    
}




