//
//  ViewController.swift
//  iOSExample
//
//  Created by Bogdan Kostyuchenko on 30.08.2020.
//  Copyright © 2020 Bogdan Kostyuchenko. All rights reserved.
//

import SecureKeychain
import UIKit

final class ViewController: UIViewController {

    // MARK: - Properties
    private var secureStore: SecureStore {
        let genericPasswordQueryable = GenericPasswordQueryable(service: "Example")
        return SecureStore(secureStoreQueryable: genericPasswordQueryable)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func saveValue() {
        try? secureStore.setValue("12345", for: "Password")
    }

    private func getValue() {
        guard let password = try? secureStore.getValue(for: "Password") else {
            return
        }
        print(password)
    }

    private func removeAllValues() {
        try? secureStore.removeAllValues()
    }

    private func removeValue() {
        try? secureStore.removeValue(for: "Password")
    }

}

