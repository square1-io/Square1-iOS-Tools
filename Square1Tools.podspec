Pod::Spec.new do |s|

  s.name         = "Square1Tools"
  s.version      = "1.8.0"
  s.summary      = "A collection of tools used in our Swift projects"
  s.description  = "A handy collection of helpers, types and hacks used on our Swift projects"
  s.homepage     = "https://https://github.com/krysztalzg/Square1-iOS-Tools"
  s.license      = { :type => "MIT", :file => "LICENSE.md" }
  s.author       = "Square1"
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://https://github.com/krysztalzg/Square1-iOS-Tools.git", :tag => s.version }
  s.source_files  = "Source/**/*.swift"
  s.swift_versions = "5.3"
end
