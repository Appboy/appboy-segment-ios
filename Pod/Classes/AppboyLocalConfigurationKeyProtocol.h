#import <Foundation/Foundation.h>

@protocol AppboyLocalConfigurationKeyProtocol

+ (id<NSCopying>)requestProcessingPolicyOptionKey;
+ (id<NSCopying>)flushIntervalOptionKey;
+ (id<NSCopying>)enableAutomaticLocationCollectionKey;
+ (id<NSCopying>)enableGeofencesKey;
+ (id<NSCopying>)idfaDelegateKey;
+ (id<NSCopying>)endpointKey;
+ (id<NSCopying>)URLDelegateKey;
+ (id<NSCopying>)inAppMessageControllerDelegateKey;
+ (id<NSCopying>)sessionTimeoutKey;
+ (id<NSCopying>)minimumTriggerTimeIntervalKey;
+ (id<NSCopying>)SDKFlavorKey;
+ (id<NSCopying>)deviceWhitelistKey;
+ (id<NSCopying>)pushStoryAppGroupKey;

@end
