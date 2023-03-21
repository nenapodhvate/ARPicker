//
//  Content.swift
//  ArPicker
//
//  Created by Akari Cloud on 08.04.22.
//

import SwiftUI


struct StartView: View {
    var body: some View {
        NavigationView {
            NavigationLink {
                ContentView()
            } label: {
                Text("START")
            }
        }
    }
}

struct ContentView: View {

    //MARK: - Properties

    @State private var isPlacementEnabled = false
    @State private var selectedModel: Model?
    @State private var modelConfirmedForPlacement: Model?

    private var models: [Model] = {
        let fileManager = FileManager.default
        guard let path = Bundle.main.resourcePath,
              let files = try? fileManager.contentsOfDirectory(atPath: path) else {
            return []
        }
        return files
            .filter { $0.hasSuffix(".usdz") }
            .compactMap { $0.replacingOccurrences(of: ".usdz", with: "") }
            .compactMap { Model(modelName: $0 ) }
    }()

    //MARK: Body
    
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ARViewRepresentable(
                modelConfirmedForPlacement: $modelConfirmedForPlacement
            )

            if isPlacementEnabled {
                PlacementButtonView(
                    isPlacementEnabled: $isPlacementEnabled,
                    selectedModel: $selectedModel,
                    modelConfirmedForPlacement: $modelConfirmedForPlacement
                )
            } else {
                ArPickerView(
                    isPlacementEnabled: $isPlacementEnabled,
                    selectedModel: $selectedModel,
                    models: models
                )
            }
        }
    }
}

//MARK: - Preview

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
