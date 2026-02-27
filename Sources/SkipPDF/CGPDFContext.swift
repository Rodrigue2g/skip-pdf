//
//  CGPDFContext.swift
//  skip-pdf
//
//  Created by Rodrigue de Guerre on 27/02/2026.
//

#if canImport(CoreGraphics) && canImport(UIKit)
import CoreGraphics

#elseif SKIP
import _Builtin_stdint

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

public func CGPDFContextSetParentTree(_ context: CGContext, _ parentTreeDictionary: CGPDFDictionaryRef) {
    fatalError()
}

public func CGPDFContextSetIDTree(_ context: CGContext, _ IDTreeDictionary: CGPDFDictionaryRef) {
    fatalError()
}

public func CGPDFContextSetPageTagStructureTree(_ context: CGContext, _ pageTagStructureTreeDictionary: CFDictionary) {
    fatalError()
}

public let kCGPDFContextMediaBox: CFString = "kCGPDFContextMediaBox"

public let kCGPDFContextCropBox: CFString = "kCGPDFContextCropBox"

public let kCGPDFContextBleedBox: CFString = "kCGPDFContextBleedBox"

public let kCGPDFContextTrimBox: CFString = "kCGPDFContextTrimBox"

public let kCGPDFContextArtBox: CFString = "kCGPDFContextArtBox"

public let kCGPDFContextTitle: CFString = "kCGPDFContextTitle"

public let kCGPDFContextAuthor: CFString = "kCGPDFContextAuthor"

public let kCGPDFContextSubject: CFString = "kCGPDFContextSubject"

public let kCGPDFContextKeywords: CFString = "kCGPDFContextKeywords"

public let kCGPDFContextCreator: CFString = "kCGPDFContextCreator"

public let kCGPDFContextOwnerPassword: CFString = "kCGPDFContextOwnerPassword"

public let kCGPDFContextUserPassword: CFString = "kCGPDFContextUserPassword"

public let kCGPDFContextEncryptionKeyLength: CFString = "kCGPDFContextEncryptionKeyLength"

public let kCGPDFContextAllowsPrinting: CFString = "kCGPDFContextAllowsPrinting"

public let kCGPDFContextAllowsCopying: CFString = "kCGPDFContextAllowsCopying"

public let kCGPDFContextOutputIntent: CFString = "kCGPDFContextOutputIntent"

public let kCGPDFXOutputIntentSubtype: CFString = "kCGPDFXOutputIntentSubtype"

public let kCGPDFXOutputConditionIdentifier: CFString = "kCGPDFXOutputConditionIdentifier"

public let kCGPDFXOutputCondition: CFString = "kCGPDFXOutputCondition"

public let kCGPDFXRegistryName: CFString = "kCGPDFXRegistryName"

public let kCGPDFXInfo: CFString = "kCGPDFXInfo"

public let kCGPDFXDestinationOutputProfile: CFString = "kCGPDFXDestinationOutputProfile"

public let kCGPDFContextOutputIntents: CFString = "kCGPDFContextOutputIntents"

public let kCGPDFContextAccessPermissions: CFString = "kCGPDFContextAccessPermissions"

public func CGPDFContextSetOutline(_ context: CGContext, _ outline: CFDictionary?) {
    fatalError()
}


public let kCGPDFContextCreateLinearizedPDF: CFString = "kCGPDFContextCreateLinearizedPDF"


public let kCGPDFContextCreatePDFA: CFString = "kCGPDFContextCreatePDFA"


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
