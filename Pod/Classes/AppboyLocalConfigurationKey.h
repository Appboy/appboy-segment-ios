#import "AppboyLocalConfigurationKeyProtocol.h"

@interface AppboyLocalConfigurationKey : NSString <AppboyLocalConfigurationKeyProtocol>

+ (instancetype)requestProcessingPolicyOptionKey;
+ (instancetype)flushIntervalOptionKey;
+ (instancetype)enableAutomaticLocationCollectionKey;
+ (instancetype)enableGeofencesKey;
+ (instancetype)idfaDelegateKey;
+ (instancetype)endpointKey;
+ (instancetype)URLDelegateKey;
+ (instancetype)inAppMessageControllerDelegateKey;
+ (instancetype)sessionTimeoutKey;
+ (instancetype)minimumTriggerTimeIntervalKey;
+ (instancetype)SDKFlavorKey;
+ (instancetype)deviceWhitelistKey;
+ (instancetype)pushStoryAppGroupKey;

@end
