//
//  SecureStore.swift
//  JobFair
//
//  Created by Bogdan Kostyuchenko on 29.08.2020.
//  Copyright © 2020 Bogdan Kostyuchenko. All rights reserved.
//

import Foundation
import Security

public class SecureStore {

    // MARK: - Protocol properties
    private let secureStoreQueryable: SecureStoreQueryable

    // MARK: - Init
    public init(secureStoreQueryable: SecureStoreQueryable) {
        self.secureStoreQueryable = secureStoreQueryable
    }

    // MARK: - Public methods
    public func setValue(_ value: String, for userAccount: String) throws {
        guard let encodedToken = value.data(using: .utf8) else {
            throw SecureStoreError.string2DataConversionError
        }

        var query = secureStoreQueryable.query
        query[String(kSecAttrAccount)] = userAccount

        var status = SecItemCopyMatching(query as CFDictionary, nil)
        switch status {
        case errSecSuccess:
            var attributesToUpdate: [String: Any] = [:]
            attributesToUpdate[String(kSecValueData)] = encodedToken

            status = SecItemUpdate(query as CFDictionary,
                                   attributesToUpdate as CFDictionary)
            if status != errSecSuccess {
                throw error(from: status)
            }
        case errSecItemNotFound:
            query[String(kSecValueData)] = encodedToken

            status = SecItemAdd(query as CFDictionary, nil)
            if status != errSecSuccess {
                throw error(from: status)
            }
        default:
            throw error(from: status)
        }
    }

    public func getValue(for userAccount: String) throws -> String? {
        var query = secureStoreQueryable.query
        query[String(kSecMatchLimit)] = kSecMatchLimitOne
        query[String(kSecReturnAttributes)] = kCFBooleanTrue
        query[String(kSecReturnData)] = kCFBooleanTrue
        query[String(kSecAttrAccount)] = userAccount

        var queryResult: AnyObject?
        let status = withUnsafeMutablePointer(to: &queryResult) {
            SecItemCopyMatching(query as CFDictionary, $0)
        }

        switch status {
        case errSecSuccess:
            guard
                let queriedItem = queryResult as? [String: Any],
                let tokenData = queriedItem[String(kSecValueData)] as? Data,
                let token = String(data: tokenData, encoding: .utf8)
                else {
                    throw SecureStoreError.data2StringConversionError
            }
            return token
        case errSecItemNotFound:
            return nil
        default:
            throw error(from: status)
        }
    }

    public func removeValue(for userAccount: String) throws {
        var query = secureStoreQueryable.query
        query[String(kSecAttrAccount)] = userAccount

        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw error(from: status)
        }
    }

    public func removeAllValues() throws {
        let query = secureStoreQueryable.query

        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw error(from: status)
        }
    }

    // MARK: - Private methods
    private func error(from status: OSStatus) -> SecureStoreError {
        if #available(iOS 11.3, *) {
            let message = SecCopyErrorMessageString(status, nil) as String? ?? NSLocalizedString("Unhandled Error", comment: "")
            return SecureStoreError.unhandledError(message: message)
        } else {
            return SecureStoreError.unhandledError(message: "Something went wrong")
        }
    }

}
