//
//  SecureStoreQueryable.swift
//  JobFair
//
//  Created by Bogdan Kostyuchenko on 30.08.2020.
//  Copyright © 2020 Bogdan Kostyuchenko. All rights reserved.
//

import Foundation

public protocol SecureStoreQueryable {

    var query: [String: Any] { get }

}
