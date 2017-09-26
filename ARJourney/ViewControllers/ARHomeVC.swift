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
    
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSceneView()
        //addNormalCubeScene()
        //addPhysicsCubeScene()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
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
    
    //MARK:- Private Methods
    private func setupSceneView() {
        sceneView.autoenablesDefaultLighting = true
        sceneView.automaticallyUpdatesLighting = true
        sceneView.preferredFramesPerSecond = 60
        
        /* Turn on debug option, to see
         * the area tracking performing well or not. */
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
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
    
    
    
}
