//
//  ARViewRepresentable.swift
//  ArPicker
//
//  Created by Akari Cloud on 08.04.22.
//

import SwiftUI
import RealityKit
import ARKit

struct ARViewRepresentable: UIViewRepresentable {
    
    //MARK: - Properties
    
    @Binding var modelConfirmedForPlacement: Model?
    
    //MARK: - UIViewRepresentable
    
    func makeUIView(context: Context) -> ARView {
        CustomARView(frame: .zero)
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        guard let model = modelConfirmedForPlacement else { return }
        
        if let modelEntity = model.modelEntity {
            print("Adding model to scene: \(model.modelName)")
            let anchorEntity = AnchorEntity(plane: .any)
            anchorEntity.addChild(modelEntity .clone(recursive: true))
            uiView.scene.addAnchor(anchorEntity)
        } else {
            print("Unable to load modelEntity for: \(model.modelName)")
        }
        
        DispatchQueue.main.async {
            modelConfirmedForPlacement = nil
        }
    }
}
