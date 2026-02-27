//
//  CGPDFContext.swift
//  skip-pdf
//
//  Created by Rodrigue de Guerre on 27/02/2026.
//

#if canImport(CoreGraphics) && canImport(UIKit)
import CoreGraphics

#elseif SKIP
//import _Builtin_stdint

//extension CGContext {
//
//    @available(iOS 2.0, *)
//    public /*not inherited*/ init?(consumer: CGDataConsumer, mediaBox: UnsafePointer<CGRect>?, _ auxiliaryInfo: CFDictionary?)
//
//    @available(iOS 2.0, *)
//    public /*not inherited*/ init?(_ url: CFURL, mediaBox: UnsafePointer<CGRect>?, _ auxiliaryInfo: CFDictionary?)
//
//    @available(iOS 2.0, *)
//    public func closePDF()
//
//    @available(iOS 2.0, *)
//    public func beginPDFPage(_ pageInfo: CFDictionary?)
//
//    @available(iOS 2.0, *)
//    public func endPDFPage()
//
//    @available(iOS 4.0, *)
//    public func addDocumentMetadata(_ metadata: CFData?)
//
//    @available(iOS 2.0, *)
//    public func setURL(_ url: CFURL, for rect: CGRect)
//
//    @available(iOS 2.0, *)
//    public func addDestination(_ name: CFString, at point: CGPoint)
//
//    @available(iOS 2.0, *)
//    public func setDestination(_ name: CFString, for rect: CGRect)
//}

//public func CGPDFContextSetParentTree(_ context: CGContext, _ parentTreeDictionary: CGPDFDictionaryRef) {
//    fatalError()
//}
//
//public func CGPDFContextSetIDTree(_ context: CGContext, _ IDTreeDictionary: CGPDFDictionaryRef) {
//    fatalError()
//}
//
//public func CGPDFContextSetPageTagStructureTree(_ context: CGContext, _ pageTagStructureTreeDictionary: CFDictionary) {
//    fatalError()
//}

public let kCGPDFContextMediaBox = "kCGPDFContextMediaBox"

public let kCGPDFContextCropBox = "kCGPDFContextCropBox"

public let kCGPDFContextBleedBox = "kCGPDFContextBleedBox"

public let kCGPDFContextTrimBox = "kCGPDFContextTrimBox"

public let kCGPDFContextArtBox = "kCGPDFContextArtBox"

public let kCGPDFContextTitle = "kCGPDFContextTitle"

public let kCGPDFContextAuthor = "kCGPDFContextAuthor"

public let kCGPDFContextSubject = "kCGPDFContextSubject"

public let kCGPDFContextKeywords = "kCGPDFContextKeywords"

public let kCGPDFContextCreator = "kCGPDFContextCreator"

public let kCGPDFContextOwnerPassword = "kCGPDFContextOwnerPassword"

public let kCGPDFContextUserPassword = "kCGPDFContextUserPassword"

public let kCGPDFContextEncryptionKeyLength = "kCGPDFContextEncryptionKeyLength"

public let kCGPDFContextAllowsPrinting = "kCGPDFContextAllowsPrinting"

public let kCGPDFContextAllowsCopying = "kCGPDFContextAllowsCopying"

public let kCGPDFContextOutputIntent = "kCGPDFContextOutputIntent"

public let kCGPDFXOutputIntentSubtype = "kCGPDFXOutputIntentSubtype"

public let kCGPDFXOutputConditionIdentifier = "kCGPDFXOutputConditionIdentifier"

public let kCGPDFXOutputCondition = "kCGPDFXOutputCondition"

public let kCGPDFXRegistryName = "kCGPDFXRegistryName"

public let kCGPDFXInfo = "kCGPDFXInfo"

public let kCGPDFXDestinationOutputProfile = "kCGPDFXDestinationOutputProfile"

public let kCGPDFContextOutputIntents = "kCGPDFContextOutputIntents"

public let kCGPDFContextAccessPermissions = "kCGPDFContextAccessPermissions"

//public func CGPDFContextSetOutline(_ context: CGContext, _ outline: CFDictionary?) {
//    fatalError()
//}


public let kCGPDFContextCreateLinearizedPDF = "kCGPDFContextCreateLinearizedPDF"


public let kCGPDFContextCreatePDFA = "kCGPDFContextCreatePDFA"


public enum CGPDFTagType : Int32, @unchecked Sendable {
    
    case document = 100
    
    case part = 101
    
    case art = 102
    
    case section = 103
    
    case div = 104
    
    case blockQuote = 105
    
    case caption = 106
    
    case TOC = 107
    
    case TOCI = 108
    
    case index = 109
    
    case nonStructure = 110
    
    case `private` = 111
    
    case paragraph = 200
    
    case header = 201
    
    case header1 = 202
    
    case header2 = 203
    
    case header3 = 204
    
    case header4 = 205
    
    case header5 = 206
    
    case header6 = 207
    
    case list = 300
    
    case listItem = 301
    
    case label = 302
    
    case listBody = 303
    
    case table = 400
    
    case tableRow = 401
    
    case tableHeaderCell = 402
    
    case tableDataCell = 403
    
    case tableHeader = 404
    
    case tableBody = 405
    
    case tableFooter = 406
    
    case span = 500
    
    case quote = 501
    
    case note = 502
    
    case reference = 503
    
    case bibliography = 504
    
    case code = 505
    
    case link = 506
    
    case annotation = 507
    
    case ruby = 600
    
    case rubyBaseText = 601
    
    case rubyAnnotationText = 602
    
    case rubyPunctuation = 603
    
    case warichu = 604
    
    case warichuText = 605
    
    case warichuPunctiation = 606
    
    case figure = 700
    
    case formula = 701
    
    case form = 702
    
    case object = 800
}

//extension CGPDFTagType {
//
//    @available(iOS 13.0, *)
//    public var name: UnsafePointer<CChar> {
//        fatalError()
//    }
//}

//public struct CGPDFTagProperty : Hashable, Equatable, RawRepresentable, @unchecked Sendable {
//
//    public init(rawValue: CFString)
//}
//
//extension CGPDFTagProperty {
//
//    @available(iOS 13.0, *)
//    public static let actualText: CGPDFTagProperty
//
//    @available(iOS 13.0, *)
//    public static let alternativeText: CGPDFTagProperty
//
//    @available(iOS 13.0, *)
//    public static let titleText: CGPDFTagProperty
//
//    @available(iOS 13.0, *)
//    public static let languageText: CGPDFTagProperty
//}
//
//@available(iOS 13.0, *)
//public func CGPDFContextBeginTag(_ context: CGContext, _ tagType: CGPDFTagType, _ tagProperties: CFDictionary)
//
//@available(iOS 13.0, *)
//public func CGPDFContextEndTag(_ context: CGContext)

#endif
