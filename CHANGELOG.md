## 2.0.2
* Supports analytics-ios 3.+ and Braze 3.10.0+.
* Fixes a potential race condition when calling `identify`.

## 2.0.1
* Supports analytics-ios 3.+ and Braze 3.1.0+.
* Fixes an issue for those using `use_frameworks!` in their Podfile.

## 2.0.0
* Supports analytics-ios 3.+ and Braze 3.0.0+.
* Adds support for custom attribute values with array types.
* Adds support for purchase revenue with NSNumber type.
* Adds support for custom endpoints which can be set on the Segment dashboard.

## 1.0.7
* Supports analytics-ios 3.+ and Braze 2.30.0+.
* Fixes an issue where install attribution data was being sent up as an event.

## 1.0.6
* Updates the wrapper SDK to work with Xcode 9 beta 2.

## 1.0.5
* Supports analytics-ios 3.+ and Braze 2.29.0+.
* Adds support for custom attribute values with date types.

## 1.0.4
* Supports analytics-ios 3.+ and Braze 2.21.0+.
* Updates the wrapper SDK to work with the Cocoapod 1.0.x.

## 1.0.3
* Supports analytics-ios 3.+ and Braze 2.20.1+.
* Updates the Podspec to use analytics-ios with the latest 3.x version.

## 1.0.2
* Supports analytics-ios 3.0.+ and Braze 2.19.1+.
* Adds support for custom attribute values with short, long, and float types.
* Modifies `SEGAppboyIntegrationFactory`'s `instance` method to return an `instancetype` for simpler Swift integration.

## 1.0.1
* Supports analytics-ios 3.0.+ and Braze 2.18.2+.
* Fixes an issue where calling `changeUser:` would sporadically result in deadlock.

## 1.0.0
* Supports analytics-ios 3.0.+ and Braze 2.18.2+.
* Initial release with push support.

## 1.0.0-alpha
* Supports analytics-ios 3.0.+ and Braze 2.15.+.
* Initial alpha release.
