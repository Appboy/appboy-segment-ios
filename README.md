### ⚠ The new [Braze Segment Swift SDK](https://github.com/braze-inc/braze-segment-swift/) is now available! ⚠

The Braze Segment iOS SDK (Objective-C SDK) is no longer in active development, since it uses the deprecated [Appboy iOS SDK](https://github.com/Appboy/Appboy-ios-sdk). All the latest iOS features in new Braze releases, like Live Activities and Feature Flags, will only be supported when using the [Braze Segment Swift SDK](https://github.com/braze-inc/braze-segment-swift/), which leverages the new [Braze Swift SDK](https://github.com/braze-inc/braze-swift-sdk). Any further updates the Braze Segment iOS SDK receives will only address security or critical bugs.

See [our blog post](https://www.braze.com/resources/articles/introducing-the-new-braze-swift-sdk) for more information.

</br>

![Braze Logo](https://github.com/Appboy/appboy-segment-ios/blob/master/braze-logo.png)

Braze iOS Segment SDK
==========

[![Version](https://img.shields.io/cocoapods/v/Segment-Appboy.svg?style=flat)](http://cocoapods.org/pods/Segment-Appboy)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](https://img.shields.io/cocoapods/l/Segment-Appboy.svg?style=flat)](http://cocoapods.org/pods/Segment-Appboy)

Braze integration for analytics-ios.

## Installation

Analytics is available through [CocoaPods](http://cocoapods.org) and [Carthage](https://github.com/Carthage/Carthage). 

### Cocoapods
To install the Braze integration through Cocoapods, simply add the following line to your `Podfile`:

```ruby
pod "Segment-Appboy"
```

If you would like to use the `Appboy-iOS-SDK/Core` subspec instead of the full `Appboy-iOS-SDK` pod, edit your `Podfile` entry to:

```ruby
pod "Segment-Appboy/Core"
```

### Carthage

To install the Braze integration through Carthage, add the following lines to your `Cartfile`:

```
github "segmentio/analytics-ios"
github "appboy/appboy-segment-ios"
github "appboy/appboy-ios-sdk"
```

And run: 
```sh
carthage update
```

Follow the standard procedure to add the frameworks built/retrieved by Carthage to your project (see [Adding frameworks to an application](https://github.com/Carthage/Carthage#adding-frameworks-to-an-application))

### Swift Package Manager

To install the Braze integration through Swift Package Manager, follow these steps:

- Select `File > Swift Packages > Add Package Dependency`.
- In the search bar, enter https://github.com/Appboy/appboy-segment-ios. Select either `AppboySegment` or `AppboySegmentCore`, depending on your use case.
- In your app's target, under `Build Settings > Other Linker Flags`, add the `-ObjC` linker flag.
- In the Xcode menu, click `Product > Scheme > Edit Scheme...`
- Click the expand ▶️ next to `Build` and select `Post-actions`. Press `+` and select `New Run Script Action`.
- In the dropdown next to `Provide build settings from`, select your app's target.
- Copy this script into the open field:
```
bash "$BUILT_PRODUCTS_DIR/Appboy_iOS_SDK_AppboyKit.bundle/Appboy.bundle/appboy-spm-cleanup.sh"
```

## Usage

After adding the dependency, you must register the integration with our SDK. To do this, import the Braze integration in your AppDelegate:

```
#import "SEGAppboyIntegrationFactory.h"
```

**Note:** When using Swift Package Manager, you will need to import the SDK using `import AppboySegment` or `import AppboySegmentCore` depending on which package you are using.

And add the following lines:

#### Objective-C

```
NSString *const SEGMENT_WRITE_KEY = @" ... ";
SEGAnalyticsConfiguration *config = [SEGAnalyticsConfiguration configurationWithWriteKey:SEGMENT_WRITE_KEY];

[config use:[SEGAppboyIntegrationFactory instance]];

[SEGAnalytics setupWithConfiguration:config];
```

#### Swift

```
let SEGMENT_WRITE_KEY = " ... "
let config = SEGAnalyticsConfiguration(writeKey: SEGMENT_WRITE_KEY)

config.use(SEGAppboyIntegrationFactory.instance())

SEGAnalytics.setup(with: config)
```

Please see [our documentation](https://segment.com/docs/integrations/appboy/#ios) for more information.

## Endpoint Customization

- You must set your endpoint via the `ABKEndpointKey` inside the `appboyOptions` parameter passed to `startWithApiKey:inApplication:withLaunchOptions:withAppboyOptions:`. 
- Set the value to your custom endpoint URL’s authority (for example, `sdk.iad-01.braze.com`, not `https://sdk.iad-01.braze.com`).

## License

```
WWWWWW||WWWWWW
 W W W||W W W
      ||
    ( OO )__________
     /  |           \
    /o o|    MIT     \
    \___/||_||__||_|| *
         || ||  || ||
        _||_|| _||_||
       (__|__|(__|__|

The MIT License (MIT)

Copyright (c) 2014 Segment, Inc.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
