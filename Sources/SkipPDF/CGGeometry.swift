//
//  CGGeometry.swift
//  skip-pdf
//
//  Created by Rodrigue de Guerre on 27/02/2026.
//

#if canImport(CoreGraphics)
import CoreGraphics
public typealias PDFRect  = CGRect
public typealias PDFPoint = CGPoint
public typealias PDFSize  = CGSize
#else
// Used on Android (#if SKIP) and on macOS CI runner (no CoreGraphics)
public struct PDFRect {
    public var x: Double
    public var y: Double
    public var width: Double
    public var height: Double
    public init(x: Double, y: Double, width: Double, height: Double) {
        self.x = x; self.y = y; self.width = width; self.height = height
    }
    public static let zero = PDFRect(x: 0, y: 0, width: 0, height: 0)
}
public struct PDFPoint {
    public var x: Double
    public var y: Double
    public init(x: Double, y: Double) { self.x = x; self.y = y }
    public static let zero = PDFPoint(x: 0, y: 0)
}
public struct PDFSize {
    public var width: Double
    public var height: Double
    public init(width: Double, height: Double) { self.width = width; self.height = height }
    public static let zero = PDFSize(width: 0, height: 0)
}
#endif
