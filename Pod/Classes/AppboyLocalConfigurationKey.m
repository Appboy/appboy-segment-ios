#import "AppboyLocalConfigurationKey.h"
#if defined(__has_include) && __has_include(<Appboy_iOS_SDK/AppboyKit.h>)
#import <Appboy_iOS_SDK/AppboyKit.h>
#else
#import "Appboy-iOS-SDK/AppboyKit.h"
#endif

@implementation AppboyLocalConfigurationKey


+ (instancetype)requestProcessingPolicyOptionKey
{
    return (AppboyLocalConfigurationKey *)ABKRequestProcessingPolicyOptionKey;
}

+ (instancetype)flushIntervalOptionKey
{
    return (AppboyLocalConfigurationKey *)ABKFlushIntervalOptionKey;
}

+ (instancetype)enableAutomaticLocationCollectionKey
{
    return (AppboyLocalConfigurationKey *)ABKEnableAutomaticLocationCollectionKey;
}

+ (instancetype)enableGeofencesKey
{
    return (AppboyLocalConfigurationKey *)ABKEnableGeofencesKey;
}

+ (instancetype)idfaDelegateKey
{
    return (AppboyLocalConfigurationKey *)ABKIDFADelegateKey;
}

+ (instancetype)endpointKey
{
    return (AppboyLocalConfigurationKey *)ABKEndpointKey;
}

+ (instancetype)URLDelegateKey
{
    return (AppboyLocalConfigurationKey *)ABKURLDelegateKey;
}

+ (instancetype)inAppMessageControllerDelegateKey
{
    return (AppboyLocalConfigurationKey *)ABKInAppMessageControllerDelegateKey;
}

+ (instancetype)sessionTimeoutKey
{
    return (AppboyLocalConfigurationKey *)ABKSessionTimeoutKey;
}

+ (instancetype)minimumTriggerTimeIntervalKey
{
    return (AppboyLocalConfigurationKey *)ABKMinimumTriggerTimeIntervalKey;
}

+ (instancetype)SDKFlavorKey
{
    return (AppboyLocalConfigurationKey *)ABKSDKFlavorKey;
}

+ (instancetype)deviceWhitelistKey
{
    return (AppboyLocalConfigurationKey *)ABKDeviceWhitelistKey;
}

+ (instancetype)pushStoryAppGroupKey
{
    return (AppboyLocalConfigurationKey *)ABKPushStoryAppGroupKey;
}

@end
