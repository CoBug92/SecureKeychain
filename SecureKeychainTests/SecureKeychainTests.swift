//
//  SecureKeychainTests.swift
//  SecureKeychainTests
//
//  Created by Bogdan Kostyuchenko on 30.08.2020.
//  Copyright © 2020 Bogdan Kostyuchenko. All rights reserved.
//

@testable import SecureKeychain
import XCTest

class SecureStoreTest: XCTestCase {

    var secureStoreWithGenericPassword: SecureStore!
    var secureStoreWithInternetPassword: SecureStore!

    override func setUp() {
        super.setUp()

        let genericPasswordQueryable = GenericPasswordQueryable(service: "firstService")
        secureStoreWithGenericPassword = SecureStore(secureStoreQueryable: genericPasswordQueryable)

        let internetPwdQueryable = InternetPasswordQueryable(server: "secondServer",
                                                             port: 8080,
                                                             path: "somePath",
                                                             securityDomain: "someDomain",
                                                             internetConnectionType: .https,
                                                             internetAuthenticationType: .httpBasic)
        secureStoreWithInternetPassword = SecureStore(secureStoreQueryable: internetPwdQueryable)
    }

    override func tearDown() {
        try? secureStoreWithGenericPassword.removeAllValues()
        try? secureStoreWithInternetPassword.removeAllValues()

        super.tearDown()
    }

    func testSaveGenericPassword() {
        do {
            try secureStoreWithGenericPassword.setValue("Password", for: "genericPassword")
        } catch let e {
            XCTFail("Saving generic password failed with \(e.localizedDescription).")
        }
    }

    func testReadGenericPassword() {
        do {
            try secureStoreWithGenericPassword.setValue("Password", for: "genericPassword")
            let password = try secureStoreWithGenericPassword.getValue(for: "genericPassword")
            XCTAssertEqual("pwd_1234", password)
        } catch let e {
            XCTFail("Reading generic password failed with \(e.localizedDescription).")
        }
    }

    func testUpdateGenericPassword() {
        do {
            try secureStoreWithGenericPassword.setValue("Password1", for: "genericPassword")
            try secureStoreWithGenericPassword.setValue("Password2", for: "genericPassword")
            let password = try secureStoreWithGenericPassword.getValue(for: "genericPassword")
            XCTAssertEqual("Password2", password)
        } catch let e {
            XCTFail("Updating generic password failed with \(e.localizedDescription).")
        }
    }

    func testRemoveGenericPassword() {
        do {
            try secureStoreWithGenericPassword.setValue("Password", for: "genericPassword")
            try secureStoreWithGenericPassword.removeValue(for: "genericPassword")
            XCTAssertNil(try secureStoreWithGenericPassword.getValue(for: "genericPassword"))
        } catch let e {
            XCTFail("Saving generic password failed with \(e.localizedDescription).")
        }
    }

    func testRemoveAllGenericPasswords() {
        do {
            try secureStoreWithGenericPassword.setValue("Password", for: "genericPassword")
            try secureStoreWithGenericPassword.setValue("Password", for: "genericPassword2")
            try secureStoreWithGenericPassword.removeAllValues()
            XCTAssertNil(try secureStoreWithGenericPassword.getValue(for: "genericPassword"))
            XCTAssertNil(try secureStoreWithGenericPassword.getValue(for: "genericPassword2"))
        } catch let e {
            XCTFail("Removing generic passwords failed with \(e.localizedDescription).")
        }
    }

}
