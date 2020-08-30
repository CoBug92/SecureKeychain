//
//  InternetPasswordQueryable.swift
//  JobFair
//
//  Created by Bogdan Kostyuchenko on 30.08.2020.
//  Copyright © 2020 Bogdan Kostyuchenko. All rights reserved.
//

import Foundation

struct InternetPasswordQueryable {

    let server: String
    let port: Int
    let path: String
    let securityDomain: String
    let internetConnectionType: InternetConnectionType
    let internetAuthenticationType: InternetAuthenticationType

}

extension InternetPasswordQueryable: SecureStoreQueryable {

    var query: [String: Any] {
        var query: [String: Any] = [:]
        query[String(kSecClass)] = kSecClassInternetPassword
        query[String(kSecAttrPort)] = port
        query[String(kSecAttrServer)] = server
        query[String(kSecAttrSecurityDomain)] = securityDomain
        query[String(kSecAttrPath)] = path
        query[String(kSecAttrProtocol)] = internetConnectionType.rawValue
        query[String(kSecAttrAuthenticationType)] = internetAuthenticationType.rawValue
        return query
    }

}
