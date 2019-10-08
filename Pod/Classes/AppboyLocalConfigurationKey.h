#import "AppboyLocalConfigurationKeyProtocol.h"

@interface AppboyLocalConfigurationKey : NSString <AppboyLocalConfigurationKeyProtocol>

+ (instancetype _Nonnull)requestProcessingPolicyOptionKey;
+ (instancetype _Nonnull)flushIntervalOptionKey;
+ (instancetype _Nonnull)enableAutomaticLocationCollectionKey;
+ (instancetype _Nonnull)enableGeofencesKey;
+ (instancetype _Nonnull)idfaDelegateKey;
+ (instancetype _Nonnull)URLDelegateKey;
+ (instancetype _Nonnull)inAppMessageControllerDelegateKey;
+ (instancetype _Nonnull)sessionTimeoutKey;
+ (instancetype _Nonnull)minimumTriggerTimeIntervalKey;
+ (instancetype _Nonnull)deviceWhitelistKey;
+ (instancetype _Nonnull)pushStoryAppGroupKey;

@end
