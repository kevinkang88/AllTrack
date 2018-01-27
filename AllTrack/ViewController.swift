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
        bodyNode.geometry = SCNSphere(radius: 0.1)
        bodyNode.geometry?.firstMaterial?.diffuse.contents = UIColor.white
        bodyNode.geometry?.firstMaterial?.specular.contents = UIColor.lightGray
        let x = 0.1
        let y = 0.1
        let z = 0.1
        
        let headNode = SCNNode()
        headNode.geometry = SCNSphere(radius: 0.05)
        headNode.geometry?.firstMaterial?.diffuse.contents = UIColor.white
        headNode.geometry?.firstMaterial?.specular.contents = UIColor.lightGray
        headNode.position = SCNVector3(0,0.15,0)
        
        let leftEye = SCNNode()
        leftEye.geometry = SCNPlane(width: 0.01, height: 0.02)
        leftEye.geometry?.firstMaterial?.diffuse.contents = UIColor.black
        leftEye.geometry?.firstMaterial?.specular.contents = UIColor.lightGray
        leftEye.position = SCNVector3(-0.01,0,0.05)
        
        let rightEye = SCNNode()
        rightEye.geometry = SCNPlane(width: 0.01, height: 0.02)
        rightEye.geometry?.firstMaterial?.diffuse.contents = UIColor.black
        rightEye.geometry?.firstMaterial?.specular.contents = UIColor.lightGray
        rightEye.position = SCNVector3(0.01,0,0.05)
        
        bodyNode.position = SCNVector3(x,y,z)
        headNode.addChildNode(rightEye)
        headNode.addChildNode(leftEye)
        bodyNode.addChildNode(headNode)
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

