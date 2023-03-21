//
//  CustomARView.swift
//  ArPicker
//
//  Created by Akari Cloud on 08.04.22.
//

import RealityKit
import ARKit
import FocusEntity

class CustomARView: ARView {
    
    //MARK: - Properties
    
    var focusEntity: FocusEntity?
    
    //MARK: - Lifecycle
    
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
        setupFocusEntity()
        setupARView()
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        setupFocusEntity()
        setupARView()
    }
}

//MARK: - Private

private extension CustomARView {
    
    func setupFocusEntity() {
        focusEntity = FocusEntity(on: self, style: .classic(color: UIColor.red))
        focusEntity?.setAutoUpdate(to: true)
    }
    
    func setupARView() {
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical]
        config.environmentTexturing = .automatic
        if ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh) {
            config.sceneReconstruction = .mesh
        }
        session.run(config)
    }
    
    func useNonARCameraSample() {
        cameraMode = .nonAR
        let cameraEntity = PerspectiveCamera()
        cameraEntity.camera.fieldOfViewInDegrees = 140
        let cameraAnchor = AnchorEntity(world: .one)
        cameraAnchor.addChild(cameraEntity)
        
        scene.addAnchor(cameraAnchor)
    }
}
