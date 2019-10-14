#import "AppboyLocalConfigurationProperty.h"
#if defined(__has_include) && __has_include(<Appboy_iOS_SDK/AppboyKit.h>)
#import <Appboy_iOS_SDK/AppboyKit.h>
#else
#import "Appboy-iOS-SDK/AppboyKit.h"
#endif

@implementation AppboyLocalConfigurationProperty

AppboyLocalConfigurationKey _key;

- (instancetype)initWithKey:(AppboyLocalConfigurationKey)key
{
    if (self = [super init]) {
        _key = key;
    }

    return self;
}

- (nonnull id)copyWithZone:(nullable NSZone *)zone
{
    return [[AppboyLocalConfigurationProperty alloc] initWithKey:_key];
}

- (NSString *_Nonnull)stringValue
{
    switch (_key)
    {
        case RequestProcessingPolicyOption:
            return ABKRequestProcessingPolicyOptionKey;
        case FlushIntervalOption:
            return ABKFlushIntervalOptionKey;
        case EnableAutomaticLocationCollection:
            return ABKEnableAutomaticLocationCollectionKey;
        case EnableGeofences:
            return ABKEnableGeofencesKey;
        case IDFADelegate:
            return ABKIDFADelegateKey;
        case URLDelegate:
            return ABKURLDelegateKey;
        case InAppMessageControllerDelegate:
            return ABKInAppMessageControllerDelegateKey;
        case SessionTimeout:
            return ABKSessionTimeoutKey;
        case MinimumTriggerTimeInterval:
            return ABKMinimumTriggerTimeIntervalKey;
        case DeviceWhitelist:
            return ABKDeviceWhitelistKey;
        case PushStoryAppGroup:
            return ABKPushStoryAppGroupKey;
    }
}

@end
