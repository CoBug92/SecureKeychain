Pod::Spec.new do |spec|

  spec.name                 = "SecureKeychain"
  spec.version              = "1.0.0"
  spec.summary              = "SecureKeychain is the simplest Swift wrapper for Keychain."
  spec.description          = "SecureKeychain is a simple Swift wrapper for Keychain. Makes using Keychain APIs extremely easy and much more palatable to use in Swift."
  spec.homepage             = "https://github.com/CoBug92/SecureKeychain"
  # spec.screenshots        = "link", "link"
  spec.license              = "MIT"
  spec.author               = "Bogdan Kostyuchenko"
  spec.social_media_url     = "https://www.instagram.com/cobug/"
  spec.platform             = :ios
  spec.swift_version        = '5.0'
  spec.source               = { :git => "https://github.com/CoBug92/SecureKeychain.git", :tag => "#{spec.version}" }
  spec.source_files         = "SecureKeychain/**/*.swift"

end
