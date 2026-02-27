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
// SKIP INSERT: import androidx.compose.foundation.*
// SKIP INSERT: import androidx.compose.foundation.layout.*
// SKIP INSERT: import androidx.compose.ui.*
// SKIP INSERT: import androidx.compose.ui.graphics.*
// SKIP INSERT: import androidx.compose.ui.graphics.asImageBitmap
// SKIP INSERT: import androidx.compose.ui.layout.*
// SKIP INSERT: import androidx.compose.ui.unit.*
// SKIP INSERT: import androidx.compose.ui.draw.*
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

    public var body: some View {
        if let doc = document {
            ComposeView { context in
                PDFPageComposer(
                    document:         doc,
                    autoScales:       autoScales,
                    displayMode:      displayMode,
                    displayDirection: displayDirection,
                    backgroundColor:  backgroundColor,
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
    let backgroundColor: Color
    let scaleFactor: Double
    let goToPageIndex: Int?

    @Composable
    func Compose(context: ComposeContext) {
        let pageCount      = document.pageCount
        let density        = androidx.compose.ui.platform.LocalDensity.current
        let config         = androidx.compose.ui.platform.LocalConfiguration.current
        let screenWidthDp  = config.screenWidthDp
        let screenHeightDp = config.screenHeightDp
        let paddingDp: androidx.compose.ui.unit.Dp = 12.dp
        let isHorizontal   = displayDirection == .horizontal
        let isSinglePage   = displayMode == .singlePage || displayMode == .twoUp
        let listState      = androidx.compose.foundation.lazy.rememberLazyListState()

        if let targetIndex = goToPageIndex, targetIndex < pageCount {
            androidx.compose.runtime.LaunchedEffect(key1: targetIndex) {
                listState.animateScrollToItem(index: targetIndex)
            }
        }

        let bgModifier: androidx.compose.ui.Modifier = context.modifier
            .fillMaxSize()
            .background(backgroundColor.asComposeColor())

        let hSpacing: androidx.compose.ui.unit.Dp = isSinglePage ? screenWidthDp.dp  : 12.dp
        let vSpacing: androidx.compose.ui.unit.Dp = isSinglePage ? screenHeightDp.dp : 12.dp

        let paddingPx = 12

        if isHorizontal {
            androidx.compose.foundation.lazy.LazyRow(
                state: listState,
                modifier: bgModifier,
                contentPadding: androidx.compose.foundation.layout.PaddingValues(
                    horizontal: paddingDp, vertical: paddingDp
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
                        paddingPx:     paddingPx,
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
                    horizontal: paddingDp, vertical: paddingDp
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
                        paddingPx:     paddingPx,
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
        paddingPx: Int,
        density: androidx.compose.ui.unit.Density,
        isHorizontal: Bool
    ) {
        guard let pdfPage = document.page(at: index) else { return }
        let bounds     = pdfPage.bounds
        let availableW = screenWidthDp - paddingPx * 2
        let widthPx    = Int(Double(availableW) * Double(density.density) * scaleFactor)
        let heightPx   = Int(Double(widthPx) * bounds.height / bounds.width)

        let bitmap = android.graphics.Bitmap.createBitmap(
            widthPx, heightPx,
            android.graphics.Bitmap.Config.ARGB_8888
        )
        bitmap.eraseColor(android.graphics.Color.WHITE)
        pdfPage.renderToBitmap(bitmap: bitmap)
        pdfPage.close()

        let baseModifier: androidx.compose.ui.Modifier = isHorizontal
            ? androidx.compose.ui.Modifier.width((screenWidthDp - paddingPx * 2).dp)
            : androidx.compose.ui.Modifier.fillMaxWidth()

        let cardModifier: androidx.compose.ui.Modifier = baseModifier
            .clip(androidx.compose.foundation.shape.RoundedCornerShape(8.dp))
            .background(androidx.compose.ui.graphics.Color.White)

        let contentScale: androidx.compose.ui.layout.ContentScale = autoScales
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

#elseif canImport(SwiftUI)
import Foundation
import SwiftUI

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
        self.init(document: PDFDocument(url: url), autoScales: autoScales)
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
