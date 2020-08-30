//
//  SecureStoreError.swift
//  JobFair
//
//  Created by Bogdan Kostyuchenko on 29.08.2020.
//  Copyright © 2020 Bogdan Kostyuchenko. All rights reserved.
//

import Foundation

public enum SecureStoreError: Error {

    case string2DataConversionError
    case data2StringConversionError
    case unhandledError(message: String)

}

extension SecureStoreError: LocalizedError {

    public var errorDescription: String? {
        switch self {
        case .string2DataConversionError:
            return NSLocalizedString("String to Data conversion error", comment: "")
        case .data2StringConversionError:
            return NSLocalizedString("Data to String conversion error", comment: "")
        case .unhandledError(let message):
            return NSLocalizedString(message, comment: "")
        }
    }

}
