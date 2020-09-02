# SecureKeychain

SecureKeychain is the simplest Swift wrapper for Keychain

## Installation

#### CocoaPods

KeychainAccess is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following lines to your Podfile:

```ruby
use_frameworks!
pod 'SecureKeychain'
```

#### Swift Package Manager

SecureKeychain is also available through [Swift Package Manager](https://github.com/apple/swift-package-manager/).

## Usage

##### See also:  
- [iOS Example Project](https://github.com/CoBug92/SecureKeychain/tree/master/iOSExample)

### Basics

#### Make instanse

```swift
let secureStore: SecureStore {
    let genericPasswordQueryable = GenericPasswordQueryable(service: "Example")
    return SecureStore(secureStoreQueryable: genericPasswordQueryable)
}
```

#### Saving application password

```swift
try? secureStore.setValue("12345", for: "Password")
```

#### Get application password

```swift
try? secureStore.getValue(for: "Password")
```

#### Remove application password

```swift
try? secureStore.removeValue(for: "Password")
```

#### Remove all password

```swift
try? secureStore.removeAllValues()
```

#### Saving Application Password

## License

KeychainAccess is available under the MIT license. See the LICENSE file for more info.
