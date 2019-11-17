[![Platforms](https://img.shields.io/cocoapods/p/poseKit.svg)](https://cocoapods.org/pods/poseKit) [![License](https://img.shields.io/cocoapods/l/poseKit.svg)](https://raw.githubusercontent.com/d1l4y/poseKit/master/LICENSE) [![Swift Package Manager](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager) [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) [![CocoaPods compatible](https://img.shields.io/cocoapods/v/poseKit.svg)](https://cocoapods.org/pods/poseKit) [![Travis](https://img.shields.io/travis/d1l4y/poseKit/master.svg)](https://travis-ci.org/d1l4y/poseKit/branches) [![SwiftFrameworkTemplate](https://img.shields.io/badge/SwiftFramework-Template-red.svg)](http://github.com/RahulKatariya/SwiftFrameworkTemplate)

![Banner Git](https://user-images.githubusercontent.com/17486329/68477479-5bb9fc80-020c-11ea-8ebc-1b3ef5a0006b.png)


**Note:** This project is not complete and under development, since it is a project made by students of the Apple Developer Academy in Curitiba, Brazil. 

## Overview ##
PoseKit is a Library that uses ARKit and RealityKit to track a body position and return the position in a json. It has more than 4 million of different position possibilities

## Summary ##

- [Requirements](#requirements)
- [Installation](#installation)
- [Contributing](#contributing)
- [References](#references)
- [Author](#author)
- [License](#license)

## Requirements ##
- iOS 13+
- Xcode 11+
- Swift 5+ 

## References ##

- [WWDC 2019 session 607: Bringing People into AR](https://developer.apple.com/videos/play/wwdc2019/607)
- [Apple’s ARKit](https://developer.apple.com/documentation/arkit)
- Demo Game using PoseKit (Link do jogo)


## Installation

### Dependency Managers
<details>
  <summary><strong>CocoaPods</strong></summary>

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate poseKit into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

pod 'poseKit', '~> 0.0.5'
```

Then, run the following command:

```bash
$ pod install
```

</details>

<details>
  <summary><strong>Carthage</strong></summary>

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that automates the process of adding frameworks to your Cocoa application.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate poseKit into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "d1l4y/poseKit" ~> 0.0.5
```

</details>

<details>
  <summary><strong>Swift Package Manager</strong></summary>

To use poseKit as a [Swift Package Manager](https://swift.org/package-manager/) package just add the following in your Package.swift file.

``` swift
// swift-tools-version:4.2

import PackageDescription

let package = Package(
    name: "HelloposeKit",
    dependencies: [
        .package(url: "https://github.com/d1l4y/poseKit.git", .upToNextMajor(from: "0.0.5"))
    ],
    targets: [
        .target(name: "HelloposeKit", dependencies: ["poseKit"])
    ]
)
```
</details>

### Manually

If you prefer not to use either of the aforementioned dependency managers, you can integrate poseKit into your project manually.

<details>
  <summary><strong>Git Submodules</strong></summary><p>

- Open up Terminal, `cd` into your top-level project directory, and run the following command "if" your project is not initialized as a git repository:

```bash
$ git init
```

- Add poseKit as a git [submodule](http://git-scm.com/docs/git-submodule) by running the following command:

```bash
$ git submodule add https://github.com/d1l4y/poseKit.git
$ git submodule update --init --recursive
```

- Open the new `poseKit` folder, and drag the `poseKit.xcodeproj` into the Project Navigator of your application's Xcode project.

    > It should appear nested underneath your application's blue project icon. Whether it is above or below all the other Xcode groups does not matter.

- Select the `poseKit.xcodeproj` in the Project Navigator and verify the deployment target matches that of your application target.
- Next, select your application project in the Project Navigator (blue project icon) to navigate to the target configuration window and select the application target under the "Targets" heading in the sidebar.
- In the tab bar at the top of that window, open the "General" panel.
- Click on the `+` button under the "Embedded Binaries" section.
- You will see two different `poseKit.xcodeproj` folders each with two different versions of the `poseKit.framework` nested inside a `Products` folder.

    > It does not matter which `Products` folder you choose from.

- Select the `poseKit.framework`.

- And that's it!

> The `poseKit.framework` is automagically added as a target dependency, linked framework and embedded framework in a copy files build phase which is all you need to build on the simulator and a device.

</p></details>

<details>
  <summary><strong>Embedded Binaries</strong></summary><p>

- Download the latest release from https://github.com/d1l4y/poseKit/releases
- Next, select your application project in the Project Navigator (blue project icon) to navigate to the target configuration window and select the application target under the "Targets" heading in the sidebar.
- In the tab bar at the top of that window, open the "General" panel.
- Click on the `+` button under the "Embedded Binaries" section.
- Add the downloaded `poseKit.framework`.
- And that's it!

</p></details>

## Contributing

Issues and pull requests are welcome!
To learn more see [Contributor Covenant](https://www.contributor-covenant.org/).

## Author

[Vinicius Dilay](https://github.com/d1l4y), [Isabela Castro](https://github.com/isacastro), [Leonardo Palinkas](https://github.com/LeonardoPalinkas), [Lucas Ronnau](https://github.com/lucasronnau), [Saulo da Silva](https://github.com/sau-tech) 
- [Discord](https://discord.gg/ssmGeb)

## License

poseKit is released under the MIT license. See [LICENSE](https://github.com/d1l4y/poseKit/blob/master/LICENSE) for details.
