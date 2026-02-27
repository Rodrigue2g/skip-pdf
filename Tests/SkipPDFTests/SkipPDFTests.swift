// Licensed under the GNU General Public License v3.0 with Linking Exception
// SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception

import XCTest
import OSLog
import Foundation
import SkipBridge
@testable import SkipPDF

let logger: Logger = Logger(subsystem: "SkipPDF", category: "Tests")

@available(macOS 13, *)
final class SkipPDFTests: XCTestCase {
    override func setUp() {
        #if os(Android)
        // needed to load the compiled bridge from the transpiled tests
        loadPeerLibrary(packageName: "skip-pdf", moduleName: "SkipPDF")
        #endif
    }

    func testSkipPDF() throws {
        logger.log("running testSkipPDF")
        XCTAssertEqual(1 + 2, 3, "basic test")
    }

    func testAsyncThrowsFunction() async throws {
        #if SKIP
        // when the native module is in kotlincompat, types are unwrapped Java classes
        let id = java.util.UUID.randomUUID()
        #else
        let id = UUID()
        #endif
        let type: SkipPDFModule.SkipPDFType = try await SkipPDFModule.createSkipPDFType(id: id, delay: 0.001)
        XCTAssertEqual(id, type.id)
    }

}
