Pod::Spec.new do |s|

  s.name         = "Square1Tools"
  s.version      = "1.5.1"
  s.summary      = "A collection of tools used in our Swift projects"
  s.description  = "A handy collection of helpers, types and hacks used on our Swift projects"
  s.homepage     = "https://github.com/square1-io/Square1-iOS-Tools"
  s.license      = { :type => "MIT", :file => "LICENSE.md" }
  s.author       = "Square1"
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/square1-io/Square1-iOS-Tools.git", :tag => s.version }
  s.source_files  = "Source/**/*.swift"

  # s.preserve_paths = 'CommonCrypto/*'
  # s.xcconfig = { 
  #               'HEADER_SEARCH_PATHS' => '$(SDKROOT)/usr/include/CommonCrypto',
  #               'SWIFT_INCLUDE_PATHS' => '$(inherited) ${PODS_TARGET_SRCROOT}/CommonCrypto' 
  #              }
end
