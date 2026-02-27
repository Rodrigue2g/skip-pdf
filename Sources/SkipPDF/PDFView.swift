//
//  PDFView.swift
//  skip-pdf
//
//  Created by Rodrigue de Guerre on 27/02/2026.
//

import Foundation
import SwiftUI

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
import PDFKit
import UIKit

public struct PDFView: UIViewRepresentable {
    // MARK: - Properties (matching Android API surface)
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

    // MARK: - Init

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
        self.document              = document
        self.autoScales            = autoScales
        self.displayMode           = displayMode
        self.displayDirection      = displayDirection
        self.backgroundColor       = backgroundColor
        self.scaleFactor           = scaleFactor
        self.minScaleFactor        = minScaleFactor
        self.maxScaleFactor        = maxScaleFactor
        self.interpolationQuality  = interpolationQuality
        self.pageShadowsEnabled    = pageShadowsEnabled
        self.displaysPageBreaks    = displaysPageBreaks
        self.displaysAsBook        = displaysAsBook
        self.goToPageIndex         = goToPageIndex
    }

    public init(url: URL, autoScales: Bool = true) {
        self.init(document: PDFDocument(url: url), autoScales: autoScales)
    }

    // MARK: - UIViewRepresentable

    public func makeUIView(context: Context) -> PDFKit.PDFView {
        let view = PDFKit.PDFView()
        view.autoScales          = autoScales
        view.displayMode         = toPDFKitDisplayMode(displayMode)
        view.displayDirection    = displayDirection == .vertical ? .vertical : .horizontal
        view.minScaleFactor      = minScaleFactor
        view.maxScaleFactor      = maxScaleFactor
        view.displaysPageBreaks  = displaysPageBreaks
        view.displaysAsBook      = displaysAsBook
        view.pageShadowsEnabled  = pageShadowsEnabled
        view.interpolationQuality = toPDFKitInterpolation(interpolationQuality)
        view.backgroundColor     = UIColor(backgroundColor)
        return view
    }

    public func updateUIView(_ pdfView: PDFKit.PDFView, context: Context) {
        pdfView.document         = document
        pdfView.autoScales       = autoScales
        pdfView.scaleFactor      = scaleFactor
        pdfView.minScaleFactor   = minScaleFactor
        pdfView.maxScaleFactor   = maxScaleFactor

        if let index = goToPageIndex,
           let doc   = document,
           let page  = doc.page(at: index) {
            pdfView.go(to: page)
        }
    }

    // MARK: - Helpers

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
public struct PDFView: View {
    public var document: PDFDocument?
    public var autoScales: Bool                      = true
    public var displayMode: PDFDisplayMode           = .singlePageContinuous
    public var displayDirection: PDFDisplayDirection = .vertical
    public var backgroundColor: Color                = Color(0xFFF2F2F7)
    public var scaleFactor: Double                   = 1.0
    public var minScaleFactor: Double                = 0.25
    public var maxScaleFactor: Double                = 4.0
    public var goToPageIndex: Int?

    public init(
        document: PDFDocument? = nil,
        autoScales: Bool = true,
        displayMode: PDFDisplayMode = .singlePageContinuous,
        displayDirection: PDFDisplayDirection = .vertical,
        backgroundColor: Color = Color(0xFFF2F2F7),
        scaleFactor: Double = 1.0,
        minScaleFactor: Double = 0.25,
        maxScaleFactor: Double = 4.0,
        goToPageIndex: Int? = nil
    ) {
        self.document         = document
        self.autoScales       = autoScales
        self.displayMode      = displayMode
        self.displayDirection = displayDirection
        self.backgroundColor  = backgroundColor
        self.scaleFactor      = scaleFactor
        self.minScaleFactor   = minScaleFactor
        self.maxScaleFactor   = maxScaleFactor
        self.goToPageIndex    = goToPageIndex
    }

    public init(url: URL, autoScales: Bool = true) {
        self.init(document: PDFDocument.load(url: url), autoScales: autoScales)
    }

    public var body: some View {
        if let doc = document {
            ComposeView { context in
                PDFPageComposer(
                    document:         doc,
                    autoScales:       autoScales,
                    displayMode:      displayMode,
                    displayDirection: displayDirection,
                    scaleFactor:      scaleFactor,
                    goToPageIndex:    goToPageIndex
                ).Compose(context: context)
            }
        } else {
            backgroundColor.ignoresSafeArea()
        }
    }
}

struct PDFPageComposer: ContentComposer {
    let document: PDFDocument
    let autoScales: Bool
    let displayMode: PDFDisplayMode
    let displayDirection: PDFDisplayDirection
    let scaleFactor: Double
    let goToPageIndex: Int?

    @Composable
    func Compose(context: ComposeContext) {
        let pageCount      = document.pageCount
        let density        = androidx.compose.ui.platform.LocalDensity.current
        let config         = androidx.compose.ui.platform.LocalConfiguration.current
        let screenWidthDp  = config.screenWidthDp
        let screenHeightDp = config.screenHeightDp
        let paddingDp      = 12
        let isHorizontal   = displayDirection == .horizontal
        let isSinglePage   = displayMode == .singlePage || displayMode == .twoUp
        let listState      = androidx.compose.foundation.lazy.rememberLazyListState()

        if let targetIndex = goToPageIndex, targetIndex < pageCount {
            androidx.compose.runtime.LaunchedEffect(key1: targetIndex) {
                listState.animateScrollToItem(index: targetIndex)
            }
        }

        let bgModifier = context.modifier
            .fillMaxSize()
            .background(androidx.compose.ui.graphics.Color(0xFFF2F2F7))

        let hSpacing = isSinglePage ? screenWidthDp.dp  : 12.dp
        let vSpacing = isSinglePage ? screenHeightDp.dp : 12.dp

        if isHorizontal {
            androidx.compose.foundation.lazy.LazyRow(
                state: listState,
                modifier: bgModifier,
                contentPadding: androidx.compose.foundation.layout.PaddingValues(
                    horizontal: paddingDp.dp, vertical: paddingDp.dp
                ),
                horizontalArrangement: androidx.compose.foundation.layout.Arrangement
                    .spacedBy(hSpacing)
            ) {
                items(count: pageCount) { index in
                    renderPage(
                        document:      document,
                        index:         index,
                        autoScales:    autoScales,
                        scaleFactor:   scaleFactor,
                        screenWidthDp: screenWidthDp,
                        paddingDp:     paddingDp,
                        density:       density,
                        isHorizontal:  true
                    )
                }
            }
        } else {
            androidx.compose.foundation.lazy.LazyColumn(
                state: listState,
                modifier: bgModifier,
                contentPadding: androidx.compose.foundation.layout.PaddingValues(
                    horizontal: paddingDp.dp, vertical: paddingDp.dp
                ),
                verticalArrangement: androidx.compose.foundation.layout.Arrangement
                    .spacedBy(vSpacing)
            ) {
                items(count: pageCount) { index in
                    renderPage(
                        document:      document,
                        index:         index,
                        autoScales:    autoScales,
                        scaleFactor:   scaleFactor,
                        screenWidthDp: screenWidthDp,
                        paddingDp:     paddingDp,
                        density:       density,
                        isHorizontal:  false
                    )
                }
            }
        }
    }

    @Composable
    func renderPage(
        document: PDFDocument,
        index: Int,
        autoScales: Bool,
        scaleFactor: Double,
        screenWidthDp: Int,
        paddingDp: Int,
        density: androidx.compose.ui.unit.Density,
        isHorizontal: Bool
    ) {
        guard let pdfPage = document.page(at: index) else { return }
        let bounds     = pdfPage.bounds
        let availableW = screenWidthDp - paddingDp * 2
        let widthPx    = Int(Double(availableW) * Double(density.density) * scaleFactor)
        let heightPx   = Int(Double(widthPx) * bounds.height / bounds.width)

        let bitmap = android.graphics.Bitmap.createBitmap(
            widthPx, heightPx,
            android.graphics.Bitmap.Config.ARGB_8888
        )
        bitmap.eraseColor(android.graphics.Color.WHITE)
        pdfPage.renderToBitmap(bitmap: bitmap)
        pdfPage.close()

        // Pre-compute modifier — fixes inline-if-in-arg issue
        let baseModifier: androidx.compose.ui.Modifier = isHorizontal
            ? androidx.compose.ui.Modifier.width((screenWidthDp - paddingDp * 2).dp)
            : androidx.compose.ui.Modifier.fillMaxWidth()

        let cardModifier = baseModifier
            .clip(androidx.compose.foundation.shape.RoundedCornerShape(8.dp))
            .background(androidx.compose.ui.graphics.Color.White)

        // Pre-compute contentScale — fixes inline-if-in-arg issue
        let contentScale = autoScales
            ? androidx.compose.ui.layout.ContentScale.FillWidth
            : androidx.compose.ui.layout.ContentScale.None

        androidx.compose.foundation.Image(
            bitmap: bitmap.asImageBitmap(),
            contentDescription: "Page \(index + 1)",
            modifier: cardModifier,
            contentScale: contentScale
        )
    }
}
#endif
