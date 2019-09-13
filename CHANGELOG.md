## 2.2.1
- Updated to [Braze iOS SDK 3.20.1](https://github.com/Appboy/appboy-ios-sdk/releases/tag/3.20.1).
- We recommend upgrading to this version instead of 2.2.0.

## 2.2.0
- Updated to [Braze iOS SDK 3.20.0](https://github.com/Appboy/appboy-ios-sdk/releases/tag/3.20.0).
- **Important:** Braze iOS SDK 3.20.0 contains updated push token registration methods. We recommend upgrading to this version as soon as possible to ensure a smooth transition as devices upgrade to iOS 13. In `application:didRegisterForRemoteNotificationsWithDeviceToken:`, replace
```
[[Appboy sharedInstance] registerPushToken:
                [NSString stringWithFormat:@"%@", deviceToken]];
``` 
with
```
[[Appboy sharedInstance] registerDeviceToken:deviceToken]];
```

## 2.1.0
- Updated to [Braze iOS SDK 3.19.0](https://github.com/Appboy/appboy-ios-sdk/releases/tag/3.19.0).

## 2.0.4
- Supports Braze 3.17.0.
  - Updates the podspec to explicitly require version 3.17.0 of the Braze iOS SDK.

## 2.0.3
- Fixed an issue where the Braze endpoint delegate would not correctly set the Segment-side configured endpoint when using Braze iOS SDK 3.14.1+.
- Added the ability to import only the `Appboy-iOS-SDK/Core` subspec instead of the full SDK. To do this, update your `Podfile` to use the `Segment-Appboy/Core` subspec instead of `Segment-Appboy`. `Segment-Appboy` will continue to use the full SDK by default. Thanks @foggy1 and @bdrelling! See https://github.com/Appboy/appboy-segment-ios/pull/20.

## 2.0.2
- Supports analytics-ios 3.+ and Braze 3.10.0+.
- Fixes a potential race condition when calling `identify`.

## 2.0.1
- Supports analytics-ios 3.+ and Braze 3.1.0+.
- Fixes an issue for those using `use_frameworks!` in their Podfile.

## 2.0.0
- Supports analytics-ios 3.+ and Braze 3.0.0+.
- Adds support for custom attribute values with array types.
- Adds support for purchase revenue with NSNumber type.
- Adds support for custom endpoints which can be set on the Segment dashboard.

## 1.0.7
- Supports analytics-ios 3.+ and Braze 2.30.0+.
- Fixes an issue where install attribution data was being sent up as an event.

## 1.0.6
- Updates the wrapper SDK to work with Xcode 9 beta 2.

## 1.0.5
- Supports analytics-ios 3.+ and Braze 2.29.0+.
- Adds support for custom attribute values with date types.

## 1.0.4
- Supports analytics-ios 3.+ and Braze 2.21.0+.
- Updates the wrapper SDK to work with the Cocoapod 1.0.x.

## 1.0.3
- Supports analytics-ios 3.+ and Braze 2.20.1+.
- Updates the Podspec to use analytics-ios with the latest 3.x version.

## 1.0.2
- Supports analytics-ios 3.0.+ and Braze 2.19.1+.
- Adds support for custom attribute values with short, long, and float types.
- Modifies `SEGAppboyIntegrationFactory`'s `instance` method to return an `instancetype` for simpler Swift integration.

## 1.0.1
- Supports analytics-ios 3.0.+ and Braze 2.18.2+.
- Fixes an issue where calling `changeUser:` would sporadically result in deadlock.

## 1.0.0
- Supports analytics-ios 3.0.+ and Braze 2.18.2+.
- Initial release with push support.

## 1.0.0-alpha
- Supports analytics-ios 3.0.+ and Braze 2.15.+.
- Initial alpha release.
