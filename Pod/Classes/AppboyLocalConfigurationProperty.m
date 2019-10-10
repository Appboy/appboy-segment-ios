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
        case requestProcessingPolicyOption:
            return ABKRequestProcessingPolicyOptionKey;
        case flushIntervalOption:
            return ABKFlushIntervalOptionKey;
        case enableAutomaticLocationCollection:
            return ABKEnableAutomaticLocationCollectionKey;
        case enableGeofences:
            return ABKEnableGeofencesKey;
        case idfaDelegate:
            return ABKIDFADelegateKey;
        case uRLDelegate:
            return ABKURLDelegateKey;
        case inAppMessageControllerDelegate:
            return ABKInAppMessageControllerDelegateKey;
        case sessionTimeout:
            return ABKSessionTimeoutKey;
        case minimumTriggerTimeInterval:
            return ABKMinimumTriggerTimeIntervalKey;
        case deviceWhitelist:
            return ABKDeviceWhitelistKey;
        case pushStoryAppGroup:
            return ABKPushStoryAppGroupKey;
    }
}

@end
