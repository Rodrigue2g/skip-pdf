//
//  PDFPage.swift
//  skip-pdf
//
//  Created by Rodrigue de Guerre on 27/02/2026.
//

import Foundation
#if canImport(PDFKit)
import PDFKit
public typealias PDFPage = PDFKit.PDFPage
#elseif SKIP
public class PDFPage {
    internal let page: android.graphics.pdf.PdfRenderer.Page

    internal init(page: android.graphics.pdf.PdfRenderer.Page) {
        self.page = page
    }

    public var bounds: PDFRect {
        return PDFRect(x: 0, y: 0, width: Double(page.width), height: Double(page.height))
    }

    public func close() {
        page.close()
    }
}
#else
public class PDFPage {
    internal init() {}
    public var bounds: PDFRect { return PDFRect.zero }
    public func close() {}
}
#endif
