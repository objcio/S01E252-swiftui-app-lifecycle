//
//  DrawingApp.swift
//  Drawing
//
//  Created by Chris Eidhof on 14.04.21.
//

import SwiftUI

struct DocumentKey: FocusedValueKey {
    typealias Value = Binding<DrawingDocument>
}

extension FocusedValues {
    var document: Binding<DrawingDocument>? {
        get { self[DocumentKey.self] }
        set { self[DocumentKey.self] = newValue }
    }
}

@main
struct DrawingApp: App {
    @FocusedValue(\.document) var document
    
    var body: some Scene {
        DocumentGroup(newDocument: DrawingDocument()) { file in
            ContentView(document: file.$document)
                .focusedValue(\.document, file.$document)
        }
        .commands {
            CommandMenu("Drawing") {
                if let d = document {
                    Toggle("Show Grid", isOn: d.drawing.snapsToGrid)
                }
            }
        }
    }
}
