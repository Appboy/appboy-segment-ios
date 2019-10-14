typedef NS_ENUM(NSUInteger, AppboyLocalConfigurationKey){
    RequestProcessingPolicyOption,
    FlushIntervalOption,
    EnableAutomaticLocationCollection,
    EnableGeofences,
    IDFADelegate,
    URLDelegate,
    InAppMessageControllerDelegate,
    SessionTimeout,
    MinimumTriggerTimeInterval,
    DeviceWhitelist,
    PushStoryAppGroup
};

@interface AppboyLocalConfigurationProperty: NSObject <NSCopying>

- (instancetype)initWithKey:(AppboyLocalConfigurationKey)key;
- (NSString *)stringValue;

@end
 
