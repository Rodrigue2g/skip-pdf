//
//  XCSkipTests.swift
//  skip-pdf
//
//  Created by Rodrigue de Guerre on 27/02/2026.
//

import XCTest
import SkipTest

/// Runs the transpiled Kotlin tests for SkipPDF on Android via Robolectric.
final class XCSkipTests: XCTestCase, XCSkipTestObserver {
    override func setUp() {
        super.setUp()
        SkipTestObserver.start()
    }
}
