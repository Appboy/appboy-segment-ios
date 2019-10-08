#import "AppboyLocalConfigurationKey.h"
#if defined(__has_include) && __has_include(<Appboy_iOS_SDK/AppboyKit.h>)
#import <Appboy_iOS_SDK/AppboyKit.h>
#else
#import "Appboy-iOS-SDK/AppboyKit.h"
#endif

@implementation AppboyLocalConfigurationKey


+ (instancetype _Nonnull)requestProcessingPolicyOptionKey
{
    return (AppboyLocalConfigurationKey *)ABKRequestProcessingPolicyOptionKey;
}

+ (instancetype _Nonnull)flushIntervalOptionKey
{
    return (AppboyLocalConfigurationKey *)ABKFlushIntervalOptionKey;
}

+ (instancetype _Nonnull)enableAutomaticLocationCollectionKey
{
    return (AppboyLocalConfigurationKey *)ABKEnableAutomaticLocationCollectionKey;
}

+ (instancetype _Nonnull)enableGeofencesKey
{
    return (AppboyLocalConfigurationKey *)ABKEnableGeofencesKey;
}

+ (instancetype _Nonnull)idfaDelegateKey
{
    return (AppboyLocalConfigurationKey *)ABKIDFADelegateKey;
}

+ (instancetype _Nonnull)URLDelegateKey
{
    return (AppboyLocalConfigurationKey *)ABKURLDelegateKey;
}

+ (instancetype _Nonnull)inAppMessageControllerDelegateKey
{
    return (AppboyLocalConfigurationKey *)ABKInAppMessageControllerDelegateKey;
}

+ (instancetype _Nonnull)sessionTimeoutKey
{
    return (AppboyLocalConfigurationKey *)ABKSessionTimeoutKey;
}

+ (instancetype _Nonnull)minimumTriggerTimeIntervalKey
{
    return (AppboyLocalConfigurationKey *)ABKMinimumTriggerTimeIntervalKey;
}

+ (instancetype _Nonnull)deviceWhitelistKey
{
    return (AppboyLocalConfigurationKey *)ABKDeviceWhitelistKey;
}

+ (instancetype _Nonnull)pushStoryAppGroupKey
{
    return (AppboyLocalConfigurationKey *)ABKPushStoryAppGroupKey;
}

@end
