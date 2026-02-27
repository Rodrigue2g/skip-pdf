//
//  PDFRenderer.swift
//  skip-pdf
//
//  Created by Rodrigue de Guerre on 27/02/2026.
//

// Cross-platform equivalent of UIGraphicsPDFRenderer (UIKit)
// iOS:     wraps UIGraphicsPDFRenderer directly
// Android: uses android.graphics.pdf.PdfDocument + Canvas

import Foundation

#if canImport(UIKit)
import UIKit
public typealias PDFRendererFormat = UIGraphicsPDFRendererFormat
#elseif SKIP
public class PDFRendererFormat {
    public var bounds: PDFRect

    public init() {
        self.bounds = PDFRect(x: 0, y: 0, width: 595, height: 842) // A4 default
    }

    public static func `default`() -> PDFRendererFormat { PDFRendererFormat() }
}
#else
public class PDFRendererFormat {
    public init() {}
    public static func `default`() -> PDFRendererFormat { PDFRendererFormat() }
}
#endif


#if canImport(UIKit)
import UIKit
public typealias PDFGraphicsContext = UIGraphicsPDFRendererContext
#elseif SKIP
public class PDFGraphicsContext {
    public let canvas: android.graphics.Canvas
    internal let pdfDocument: android.graphics.pdf.PdfDocument
    internal var currentPage: android.graphics.pdf.PdfDocument.Page?
    public let bounds: PDFRect

    internal init(
        pdfDocument: android.graphics.pdf.PdfDocument,
        bounds: PDFRect
    ) {
        self.pdfDocument = pdfDocument
        self.bounds = bounds
        // start with a dummy canvas — replaced on first beginPage()
        self.canvas = android.graphics.Canvas()
    }

    /// Call at the start of each page (mirrors UIGraphicsPDFRendererContext.beginPage())
    public func beginPage() {
        if let page = currentPage {
            pdfDocument.finishPage(page)
        }
        let pageInfo = android.graphics.pdf.PdfDocument.PageInfo.Builder(
            Int(bounds.width), Int(bounds.height), (currentPage == nil ? 1 : 2)
        ).create()
        currentPage = pdfDocument.startPage(pageInfo)
    }
}
#else
public class PDFGraphicsContext {
    public let bounds: PDFRect
    internal init(bounds: PDFRect) { self.bounds = bounds }
    public func beginPage() {}
}
#endif


#if canImport(UIKit)
import UIKit

public class PDFRenderer {
    private let bounds: CGRect
    private let format: UIGraphicsPDFRendererFormat
    private let renderer: UIGraphicsPDFRenderer

    public init(bounds: PDFRect, format: PDFRendererFormat = PDFRendererFormat()) {
        self.bounds   = bounds
        self.format   = format
        self.renderer = UIGraphicsPDFRenderer(bounds: bounds, format: format)
    }

    public func pdfData(
        actions: (PDFGraphicsContext) -> Void
    ) -> Data {
        return renderer.pdfData { ctx in
            actions(ctx)
        }
    }

    public func writePDF(
        to url: URL,
        withActions actions: (PDFGraphicsContext) -> Void
    ) throws {
        try renderer.writePDF(to: url) { ctx in
            actions(ctx)
        }
    }
}
#elseif SKIP
public class PDFRenderer {
    private let bounds: PDFRect

    public init(bounds: PDFRect, format: PDFRendererFormat = PDFRendererFormat()) {
        self.bounds = bounds
    }

    public func pdfData(
        actions: (PDFGraphicsContext) -> Void
    ) -> Data {
        let document = android.graphics.pdf.PdfDocument()
        let ctx      = PDFGraphicsContext(pdfDocument: document, bounds: bounds)
        ctx.beginPage()      // open first page automatically
        actions(ctx)
        if let page = ctx.currentPage {
            document.finishPage(page)
        }
        let stream = java.io.ByteArrayOutputStream()
        document.writeTo(stream)
        document.close()
        let bytes: [UInt8] = Array(stream.toByteArray().toUByteArray().toMutableList())
        return Data(bytes: bytes)
    }

    public func writePDF(
        to url: URL,
        withActions actions: (PDFGraphicsContext) -> Void
    ) throws {
        let data = pdfData(actions: actions)
        try data.write(to: url)
    }
}
#else
public class PDFRenderer {
    public init(bounds: PDFRect, format: PDFRendererFormat = PDFRendererFormat()) {}

    public func pdfData(actions: (PDFGraphicsContext) -> Void) -> Data { Data() }

    public func writePDF(
        to url: URL,
        withActions actions: (PDFGraphicsContext) -> Void
    ) throws {}
}
#endif
