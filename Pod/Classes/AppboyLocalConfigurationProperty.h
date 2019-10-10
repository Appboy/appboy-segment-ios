typedef NS_ENUM(NSUInteger, AppboyLocalConfigurationKey){
    requestProcessingPolicyOption,
    flushIntervalOption,
    enableAutomaticLocationCollection,
    enableGeofences,
    idfaDelegate,
    uRLDelegate,
    inAppMessageControllerDelegate,
    sessionTimeout,
    minimumTriggerTimeInterval,
    deviceWhitelist,
    pushStoryAppGroup
};

@interface AppboyLocalConfigurationProperty: NSObject <NSCopying>

- (instancetype)initWithKey:(AppboyLocalConfigurationKey)key;
- (NSString *)stringValue;

@end
