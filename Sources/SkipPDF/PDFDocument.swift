//
//  PDFDocument.swift
//  skip-pdf
//
//  Created by Rodrigue de Guerre on 27/02/2026.
//

import Foundation
#if !SKIP
import PDFKit
public typealias PDFDocument = PDFKit.PDFDocument
#else
public class PDFDocument {
    private var pdfRenderer: android.graphics.pdf.PdfRenderer?

    public static func load(url: URL) -> PDFDocument? {
        let doc = PDFDocument()
        let file = java.io.File(url.path)
        guard file.exists() else { return nil }
        do {
            let fd = android.os.ParcelFileDescriptor.open(
                file, android.os.ParcelFileDescriptor.MODE_READ_ONLY
            )
            doc.pdfRenderer = android.graphics.pdf.PdfRenderer(fd)
            return doc
        } catch {
            return nil
        }
    }

    private init() {}

    public var pageCount: Int {
        return pdfRenderer?.pageCount ?? 0
    }

    public func page(at index: Int) -> PDFPage? {
        guard let renderer = pdfRenderer else { return nil }
        guard index >= 0 && index < renderer.pageCount else { return nil }
        let page = renderer.openPage(index)
        return PDFPage(page: page)
    }

    public func close() {
        pdfRenderer?.close()
        pdfRenderer = nil
    }
}
#endif
