//
//  ViewController.swift
//  AllTrack
//
//  Created by kevin on 1/23/18.
//  Copyright © 2018 yooniverse. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {
    
    @IBOutlet var sceneView: ARSCNView!
    let config = ARWorldTrackingConfiguration()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        self.sceneView.session.run(config)
        self.sceneView.autoenablesDefaultLighting = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addButtonTapped(_ sender: Any) {
        let bodyNode = SCNNode()
        bodyNode.geometry = SCNSphere(radius: 0.3)
        bodyNode.geometry?.firstMaterial?.specular.contents = UIColor.white
        bodyNode.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        let x = 0.3
        let y = 0.3
        let z = 0.3
        bodyNode.position = SCNVector3(x,y,z)
        self.sceneView.scene.rootNode.addChildNode(bodyNode)
    }
    
    @IBAction func resetButtonTapped(_ sender: Any) {
        pauseSession()
    }
    
    func pauseSession() {
        self.sceneView.session.pause()
        self.sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
            node.removeFromParentNode()
        }
        self.sceneView.session.run(config, options: [.resetTracking, .removeExistingAnchors])
    }
    
    func randomNumbers(numOne:CGFloat, numTwo:CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(numOne - numTwo) + min(numOne, numTwo)
    }
}

