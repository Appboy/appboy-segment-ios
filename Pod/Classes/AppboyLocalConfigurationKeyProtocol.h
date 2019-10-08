#import <Foundation/Foundation.h>

@protocol AppboyLocalConfigurationKeyProtocol

+ (id<NSCopying> _Nonnull)requestProcessingPolicyOptionKey;
+ (id<NSCopying> _Nonnull)flushIntervalOptionKey;
+ (id<NSCopying> _Nonnull)enableAutomaticLocationCollectionKey;
+ (id<NSCopying> _Nonnull)enableGeofencesKey;
+ (id<NSCopying> _Nonnull)idfaDelegateKey;
+ (id<NSCopying> _Nonnull)URLDelegateKey;
+ (id<NSCopying> _Nonnull)inAppMessageControllerDelegateKey;
+ (id<NSCopying> _Nonnull)sessionTimeoutKey;
+ (id<NSCopying> _Nonnull)minimumTriggerTimeIntervalKey;
+ (id<NSCopying> _Nonnull)deviceWhitelistKey;
+ (id<NSCopying> _Nonnull)pushStoryAppGroupKey;

@end
