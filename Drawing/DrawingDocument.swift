//
//  DrawingDocument.swift
//  Drawing
//
//  Created by Chris Eidhof on 14.04.21.
//

import SwiftUI
import UniformTypeIdentifiers

struct DrawingDocument: FileDocument {
    var drawing: Drawing = Drawing()

    init() {
    }

    static var readableContentTypes: [UTType] { [.json] }

    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
        self.drawing = try JSONDecoder().decode(Drawing.self, from: data)
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = try JSONEncoder().encode(drawing)
        return FileWrapper(regularFileWithContents: data)
    }
}
