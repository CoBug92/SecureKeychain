//
//  GenericPasswordQueryable.swift
//  JobFair
//
//  Created by Bogdan Kostyuchenko on 29.08.2020.
//  Copyright © 2020 Bogdan Kostyuchenko. All rights reserved.
//

import Foundation

public struct GenericPasswordQueryable {

    private let service: String
    private let accessGroup: String?

    init(service: String, accessGroup: String? = nil) {
        self.service = service
        self.accessGroup = accessGroup
    }

}

extension GenericPasswordQueryable: SecureStoreQueryable {

    public var query: [String: Any] {
        var query: [String: Any] = [:]
        query[String(kSecClass)] = kSecClassGenericPassword
        query[String(kSecAttrService)] = service
        // Access group if target environment is not simulator
        #if !targetEnvironment(simulator)
        if let accessGroup = accessGroup {
            query[String(kSecAttrAccessGroup)] = accessGroup
        }
        #endif
        return query
    }
}
