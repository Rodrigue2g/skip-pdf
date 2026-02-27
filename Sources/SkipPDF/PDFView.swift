//
//  PDFView.swift
//  skip-pdf
//
//  Created by Rodrigue de Guerre on 27/02/2026.
//

public enum PDFDisplayMode: Int, Sendable {
    case singlePage = 0
    case singlePageContinuous = 1
    case twoUp = 2
    case twoUpContinuous = 3
}

public enum PDFDisplayDirection: Int, Sendable {
    case vertical = 0
    case horizontal = 1
}

public enum PDFInterpolationQuality: Int, Sendable {
    case none = 0
    case low = 1
    case high = 2
}

#if canImport(PDFKit) && canImport(UIKit)
import Foundation
import SwiftUI
import PDFKit
import UIKit

public struct PDFView: UIViewRepresentable {
    public var document: PDFDocument?
    public var autoScales: Bool = true
    public var displayMode: PDFDisplayMode = .singlePageContinuous
    public var displayDirection: PDFDisplayDirection = .vertical
    public var backgroundColor: Color = Color(UIColor.systemGroupedBackground)
    public var scaleFactor: CGFloat = 1.0
    public var minScaleFactor: CGFloat = 0.25
    public var maxScaleFactor: CGFloat = 4.0
    public var interpolationQuality: PDFInterpolationQuality = .high
    public var pageShadowsEnabled: Bool = true
    public var displaysPageBreaks: Bool = true
    public var displaysAsBook: Bool = false
    public var goToPageIndex: Int?

    public init(
        document: PDFDocument? = nil,
        autoScales: Bool = true,
        displayMode: PDFDisplayMode = .singlePageContinuous,
        displayDirection: PDFDisplayDirection = .vertical,
        backgroundColor: Color = Color(UIColor.systemGroupedBackground),
        scaleFactor: CGFloat = 1.0,
        minScaleFactor: CGFloat = 0.25,
        maxScaleFactor: CGFloat = 4.0,
        interpolationQuality: PDFInterpolationQuality = .high,
        pageShadowsEnabled: Bool = true,
        displaysPageBreaks: Bool = true,
        displaysAsBook: Bool = false,
        goToPageIndex: Int? = nil
    ) {
        self.document             = document
        self.autoScales           = autoScales
        self.displayMode          = displayMode
        self.displayDirection     = displayDirection
        self.backgroundColor      = backgroundColor
        self.scaleFactor          = scaleFactor
        self.minScaleFactor       = minScaleFactor
        self.maxScaleFactor       = maxScaleFactor
        self.interpolationQuality = interpolationQuality
        self.pageShadowsEnabled   = pageShadowsEnabled
        self.displaysPageBreaks   = displaysPageBreaks
        self.displaysAsBook       = displaysAsBook
        self.goToPageIndex        = goToPageIndex
    }

    public init(url: URL, autoScales: Bool = true) {
        self.init(document: PDFDocument(url: url), autoScales: autoScales)
    }

    public func makeUIView(context: Context) -> PDFKit.PDFView {
        let view = PDFKit.PDFView()
        view.autoScales           = autoScales
        view.displayMode          = toPDFKitDisplayMode(displayMode)
        view.displayDirection     = displayDirection == .vertical ? .vertical : .horizontal
        view.minScaleFactor       = minScaleFactor
        view.maxScaleFactor       = maxScaleFactor
        view.displaysPageBreaks   = displaysPageBreaks
        view.displaysAsBook       = displaysAsBook
        view.pageShadowsEnabled   = pageShadowsEnabled
        view.interpolationQuality = toPDFKitInterpolation(interpolationQuality)
        view.backgroundColor      = UIColor(backgroundColor)
        return view
    }

    public func updateUIView(_ pdfView: PDFKit.PDFView, context: Context) {
        pdfView.document       = document
        pdfView.autoScales     = autoScales
        pdfView.scaleFactor    = scaleFactor
        pdfView.minScaleFactor = minScaleFactor
        pdfView.maxScaleFactor = maxScaleFactor
        if let index = goToPageIndex,
           let doc   = document,
           let page  = doc.page(at: index) {
            pdfView.go(to: page)
        }
    }

    private func toPDFKitDisplayMode(_ mode: PDFDisplayMode) -> PDFKit.PDFDisplayMode {
        switch mode {
        case .singlePage:           return .singlePage
        case .singlePageContinuous: return .singlePageContinuous
        case .twoUp:                return .twoUp
        case .twoUpContinuous:      return .twoUpContinuous
        }
    }

    private func toPDFKitInterpolation(_ q: PDFInterpolationQuality) -> PDFKit.PDFInterpolationQuality {
        switch q {
        case .none: return .none
        case .low:  return .low
        case .high: return .high
        }
    }
}

#elseif SKIP
import Foundation
import SwiftUI

public struct PDFView: View {
    public var document: PDFDocument?
    public var autoScales: Bool = true
    public var displayMode: PDFDisplayMode = .singlePageContinuous
    public var displayDirection: PDFDisplayDirection = .vertical
    public var backgroundColor: Color = Color(red: 0.949, green: 0.949, blue: 0.969, opacity: 1.0)
    public var scaleFactor: Double = 1.0
    public var minScaleFactor: Double = 0.25
    public var maxScaleFactor: Double = 4.0
    public var interpolationQuality: PDFInterpolationQuality = .high
    public var pageShadowsEnabled: Bool = true
    public var displaysPageBreaks: Bool = true
    public var displaysAsBook: Bool = false
    public var goToPageIndex: Int?

    public init(
        document: PDFDocument? = nil,
        autoScales: Bool = true,
        displayMode: PDFDisplayMode = .singlePageContinuous,
        displayDirection: PDFDisplayDirection = .vertical,
        backgroundColor: Color = Color(red: 0.949, green: 0.949, blue: 0.969, opacity: 1.0),
        scaleFactor: Double = 1.0,
        minScaleFactor: Double = 0.25,
        maxScaleFactor: Double = 4.0,
        interpolationQuality: PDFInterpolationQuality = .high,
        pageShadowsEnabled: Bool = true,
        displaysPageBreaks: Bool = true,
        displaysAsBook: Bool = false,
        goToPageIndex: Int? = nil
    ) {
        self.document             = document
        self.autoScales           = autoScales
        self.displayMode          = displayMode
        self.displayDirection     = displayDirection
        self.backgroundColor      = backgroundColor
        self.scaleFactor          = scaleFactor
        self.minScaleFactor       = minScaleFactor
        self.maxScaleFactor       = maxScaleFactor
        self.interpolationQuality = interpolationQuality
        self.pageShadowsEnabled   = pageShadowsEnabled
        self.displaysPageBreaks   = displaysPageBreaks
        self.displaysAsBook       = displaysAsBook
        self.goToPageIndex        = goToPageIndex
    }

    public init(url: URL, autoScales: Bool = true) {
        self.init(document: PDFDocument.load(url: url), autoScales: autoScales)
    }

    // TODO: implement full Compose page rendering
    public var body: some View {
        backgroundColor
            .ignoresSafeArea()
    }
}

#elseif canImport(SwiftUI)
import Foundation
import SwiftUI

public struct PDFView: View {
    public var document: PDFDocument?
    public var autoScales: Bool = true
    public var displayMode: PDFDisplayMode = .singlePageContinuous
    public var displayDirection: PDFDisplayDirection = .vertical
    public var backgroundColor: Color = Color(red: 0.949, green: 0.949, blue: 0.969, opacity: 1.0)
    public var scaleFactor: Double = 1.0
    public var minScaleFactor: Double = 0.25
    public var maxScaleFactor: Double = 4.0
    public var interpolationQuality: PDFInterpolationQuality = .high
    public var pageShadowsEnabled: Bool = true
    public var displaysPageBreaks: Bool = true
    public var displaysAsBook: Bool = false
    public var goToPageIndex: Int?

    public init(
        document: PDFDocument? = nil,
        autoScales: Bool = true,
        displayMode: PDFDisplayMode = .singlePageContinuous,
        displayDirection: PDFDisplayDirection = .vertical,
        backgroundColor: Color = Color(red: 0.949, green: 0.949, blue: 0.969, opacity: 1.0),
        scaleFactor: Double = 1.0,
        minScaleFactor: Double = 0.25,
        maxScaleFactor: Double = 4.0,
        interpolationQuality: PDFInterpolationQuality = .high,
        pageShadowsEnabled: Bool = true,
        displaysPageBreaks: Bool = true,
        displaysAsBook: Bool = false,
        goToPageIndex: Int? = nil
    ) {
        self.document             = document
        self.autoScales           = autoScales
        self.displayMode          = displayMode
        self.displayDirection     = displayDirection
        self.backgroundColor      = backgroundColor
        self.scaleFactor          = scaleFactor
        self.minScaleFactor       = minScaleFactor
        self.maxScaleFactor       = maxScaleFactor
        self.interpolationQuality = interpolationQuality
        self.pageShadowsEnabled   = pageShadowsEnabled
        self.displaysPageBreaks   = displaysPageBreaks
        self.displaysAsBook       = displaysAsBook
        self.goToPageIndex        = goToPageIndex
    }

    public init(url: URL, autoScales: Bool = true) {
        self.init(document: nil, autoScales: autoScales)
    }

    public var body: some View { EmptyView() }
}

#else
import Foundation
import SkipUI

public struct PDFView: View {
    public var document: PDFDocument?
    public var autoScales: Bool = true
    public var displayMode: PDFDisplayMode = .singlePageContinuous
    public var displayDirection: PDFDisplayDirection = .vertical
    public var scaleFactor: Double = 1.0
    public var minScaleFactor: Double = 0.25
    public var maxScaleFactor: Double = 4.0
    public var interpolationQuality: PDFInterpolationQuality = .high
    public var pageShadowsEnabled: Bool = true
    public var displaysPageBreaks: Bool = true
    public var displaysAsBook: Bool = false
    public var goToPageIndex: Int?

    public init(
        document: PDFDocument? = nil,
        autoScales: Bool = true,
        displayMode: PDFDisplayMode = .singlePageContinuous,
        displayDirection: PDFDisplayDirection = .vertical,
        scaleFactor: Double = 1.0,
        minScaleFactor: Double = 0.25,
        maxScaleFactor: Double = 4.0,
        interpolationQuality: PDFInterpolationQuality = .high,
        pageShadowsEnabled: Bool = true,
        displaysPageBreaks: Bool = true,
        displaysAsBook: Bool = false,
        goToPageIndex: Int? = nil
    ) {
        self.document             = document
        self.autoScales           = autoScales
        self.displayMode          = displayMode
        self.displayDirection     = displayDirection
        self.scaleFactor          = scaleFactor
        self.minScaleFactor       = minScaleFactor
        self.maxScaleFactor       = maxScaleFactor
        self.interpolationQuality = interpolationQuality
        self.pageShadowsEnabled   = pageShadowsEnabled
        self.displaysPageBreaks   = displaysPageBreaks
        self.displaysAsBook       = displaysAsBook
        self.goToPageIndex        = goToPageIndex
    }

    public init(url: URL, autoScales: Bool = true) {
        self.init(document: nil, autoScales: autoScales)
    }

    public var body: some View { EmptyView() }
}
#endif
