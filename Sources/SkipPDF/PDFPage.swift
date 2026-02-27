//
//  PDFPage.swift
//  skip-pdf
//
//  Created by Rodrigue de Guerre on 27/02/2026.
//

#if canImport(PDFKit)
import PDFKit
public typealias PDFPage = PDFKit.PDFPage
#else
public class PDFPage {
    internal let page: android.graphics.pdf.PdfRenderer.Page

    internal init(page: android.graphics.pdf.PdfRenderer.Page) {
        self.page = page
    }

    public var bounds: PDFRect {
        return CGRect(x: 0, y: 0, width: Double(page.width), height: Double(page.height))
    }

    public func close() {
        page.close()
    }
}
#endif
