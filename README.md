# Square1 iOS Tools

<p align="center">
<img src="https://img.shields.io/cocoapods/v/Square1Tools.svg" alt="Cocoapods"/>
<img src="https://img.shields.io/badge/platform-ios-red.svg" alt="Platform"/>
</p>

A handy collection of helpers, types and hacks used on our Swift projects.

## Index
* [Prerequisites](#prerequisites)
* [Installing](#installing)
    * [Cocoapods](#cocoapods)
* [Running the tests](#running-the-tests)
* [How to use](#how-to-use)
    * [Keychain](#keychain)
    * [Log](#log)
* [Contributing](#contributing)
* [Authors](#authors)
* [License](#license)
* [Acknowledgments](#acknowledgments)

### Prerequisites
* iOS 9.0+
* XCode 10+
* Swift 4.2+

## Installing

### Cocoapods

If you're already using Cocoapods in your project, just skip to step 3
1. Install [Cocoapods](https://guides.cocoapods.org/using/getting-started.html)
2. Create a [Podfile](https://guides.cocoapods.org/using/using-cocoapods.html) for your project
3. Make sure you use 
```swift
use_frameworks!
```
4. Add this pod to your Podfile
```swift
pod 'Square1Tools'
```
5. Run ```pod install```
6. Use this import on every file you want to use the pod
```swift
import Square1Tools
```

## Running the tests

1. Download the source project
2. Hit ```Cmd + U``` to run the tests.

## How to use

Check the [documentation page](http://htmlpreview.github.io/?https://github.com/square1-io/Square1-iOS-Tools/blob/master/docs/index.html).

### Keychain

*Keychain* is a helper class to quickly access to stored values in iOS Keychain.

You can instance a Keychain object like this:

```swift
let keychain = Keychain()

// You can also instance it with a specific access group.
let anotherKeychain = Keychain(accessGroup: "MyGroup")
```

Using Keychain is straightforward :
```swift
// Save into keychain
keychain.save("Hello World!!", forKey: "MyKey") // returns true if ok, otherwise false

// Read from keychain
keychain.get("MyKey") // returns String?

// Delete from keychain
keychain.delete("MyKey") // returns true if ok, otherwise false
```

### Log

*Log* is a helper method for more accurate console prints. From iOS 10 we use [OSLog](https://developer.apple.com/documentation/os/oslog) class to print logs. You can use the Mac's Console app to filter and manage logs by subsystem and category. We add more util info in debug mode like line, function and emojis.

More info [Unified logging](https://developer.apple.com/documentation/os/logging).


Usage
```Swift
Log("Default message with default OSLog")
```

```Swift
let testLog = OSLog(subsystem: "S1.Square1ToolsApp.test", category: "test")
Log("Info message", log: testLog, type: .info)
```
Console app output(filter for subsystem)
![Console Logs](resources/img/ConsoleLogs.png)

Console Xcode output
![Xcode Logs](resources/img/XcodeLogs.png)

## Contributing

Please read [CONTRIBUTING](CONTRIBUTING.md) for details on our code of conduct, and the process for submitting pull requests to us.
Make sure you comment modified and new code and use [Jazzy](https://github.com/realm/jazzy) to generate new documentation before making a pull request.

## Authors

* [Roberto Pastor](https://github.com/WedgeSparda)
* [Ginés Navarro](https://github.com/ginesguiropa)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE.md) file for details

## Acknowledgments

To all the great Swift community out there.