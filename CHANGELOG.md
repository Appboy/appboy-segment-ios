## 3.3.0
#### Changed
- Updated to [Braze iOS SDK 3.26.1](https://github.com/Appboy/appboy-ios-sdk/releases/tag/3.26.1).
- Deprecates the compilation macro `ABK_ENABLE_IDFA_COLLECTION` in favor of the `ABKIDFADelegate` implementation.
  - `ABK_ENABLE_IDFA_COLLECTION` will be removed in a future release and will stop functioning properly in iOS 14. To continue collecting IDFA on iOS 14 devices, you must upgrade to Xcode 12 and implement `App Tracking Transparency` and Braze's `ABKIDFADelegate` (see the [iOS 14 upgrade guide](https://www.braze.com/docs/developer_guide/platform_integration_guides/ios/ios_14/#idfa-and-app-tracking-transparency) for more information).
  - `ABKIDFADelegate` can be passed in through setting [`appboyOptions`](https://github.com/Appboy/appboy-segment-ios/blob/master/CHANGELOG.md#added-1) on the `SEGAppboyIntegrationFactory`.

#### Added
- Added Binary Project Specification file for more efficient Carthage integration. 
  - Update your Cartfile to use `binary "https://raw.githubusercontent.com/Appboy/appboy-segment-ios/master/Segment_Appboy.json"` instead of `github "appboy/appboy-segment-ios"`
  - Support for this integration method was added starting with version 3.2.0 of the SDK.

## 3.2.0

#### Added
- Added Carthage support

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

#### Changed
- Updated to [Braze iOS SDK 3.24.1](https://github.com/Appboy/appboy-ios-sdk/releases/tag/3.24.1).

## 3.1.0

#### Added
- Added ability to set `appboyOptions` on the `SEGAppboyIntegrationFactory` for example:
```
[SEGAppboyIntegrationFactory instance].appboyOptions = @{ABKMinimumTriggerTimeIntervalKey: @1}; 
```
The full list of options are documented in [Appboy.h](https://github.com/Appboy/appboy-ios-sdk/blob/master/AppboyKit/headers/AppboyKitLibrary/Appboy.h#L35). Shout out to @maloneranger for the feature suggestion and PR. 
- Added the ability to import one of our UI subspecs instead of the full SDK. To do this, update your `Podfile` to use `Segment-Appboy/InAppMessage`, `Segment-Appboy/NewsFeed`, or `Segment-Appboy/ContentCards` instead of `Segment-Appboy`. `Segment-Appboy` will continue to use the full SDK by default. Thanks @khaptonstall!

#### Changed
- Updated to [Braze iOS SDK 3.22.0](https://github.com/Appboy/appboy-ios-sdk/releases/tag/3.22.0).
- Updated code to call all Braze iOS SDK push handling methods that call UI APIs from the main thread. Thanks @gilserrap and @khaptonstall!

## 3.0.0

##### Breaking
- Log separate purchases for each product in the `products` array in a `track` call.
  - In the past we used the event name as the product ID.
  - Now if a `track` call has the event name `Order Completed` or the key `revenue` included in `properties` and also has a `products` array, we will log each object in the array as a separate purchase using `productId` as the product ID. `price` and `quantity` will be read from the individual array if available. All non-Braze recognized fields from the high level `properties` and each individual product will be combined and sent as event properties.
  - If there is no `products` array we will continue using the event name as the product ID if the key `revenue` is included in `properties`.
  
##### Added
- Added a push delegate method for apps using the `UserNotification` framework.
  - Follow our [documentation](https://www.braze.com/docs/developer_guide/platform_integration_guides/ios/push_notifications/integration/#using-usernotification-framework-ios-10) for registering for push notifications using the `UserNotification` framework.
  - In `userNotificationCenter:didReceiveNotificationResponse:withCompletionHandler` add the following block of code:
  ```
  if ([Appboy sharedInstance] == nil) {
   [[SEGAppboyIntegrationFactory instance].appboyHelper saveUserNotificationCenter:center
                                                              notificationResponse:response];
  }
  [[SEGAppboyIntegrationFactory instance].appboyHelper userNotificationCenter:center
                                                 receivedNotificationResponse:response];
  if (completionHandler) {
   completionHandler();
  }
  ```

## 2.3.0

##### Changed
- Updated to [Braze iOS SDK 3.21.0](https://github.com/Appboy/appboy-ios-sdk/releases/tag/3.21.0).

## 2.2.2

**Important:** This patch updates the Braze iOS SDK Dependency from 3.20.1 to 3.20.2, which contains important bugfixes. Integrators should upgrade to this patch version. Please see the [Braze iOS SDK Changelog](https://github.com/Appboy/appboy-ios-sdk/blob/master/CHANGELOG.md) for more information.

##### Changed
- Updated to [Braze iOS SDK 3.20.2](https://github.com/Appboy/appboy-ios-sdk/releases/tag/3.20.2).

## 2.2.1

**Important:** This release has known issues displaying HTML in-app messages. Do not upgrade to this version and upgrade to 2.2.2 and above instead. If you are using this version, you are strongly encouraged to upgrade to 2.2.2 or above if you make use of HTML in-app messages.

##### Changed
- Updated to [Braze iOS SDK 3.20.1](https://github.com/Appboy/appboy-ios-sdk/releases/tag/3.20.1).

## 2.2.0

**Important:** This release has known issues displaying HTML in-app messages. Do not upgrade to this version and upgrade to 2.2.2 and above instead. If you are using this version, you are strongly encouraged to upgrade to 2.2.2 or above if you make use of HTML in-app messages.

##### Breaking
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

**Important:** This release has known issues displaying HTML in-app messages. Do not upgrade to this version and upgrade to 2.2.2 and above instead. If you are using this version, you are strongly encouraged to upgrade to 2.2.2 or above if you make use of HTML in-app messages.

##### Breaking
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
