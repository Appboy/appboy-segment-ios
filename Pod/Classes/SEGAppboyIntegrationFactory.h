#import <Foundation/Foundation.h>
#import <Analytics/SEGIntegrationFactory.h>

@class SEGAppboyIntegrationOptions;

NS_ASSUME_NONNULL_BEGIN

@interface SEGAppboyIntegrationFactory : NSObject<SEGIntegrationFactory>

@property (nonatomic, nullable, strong) SEGAppboyIntegrationOptions *integrationOptions;

+ (instancetype)instance;

- (void)saveLaunchOptions:(nullable NSDictionary *)launchOptions;
- (void)saveRemoteNotification:(nullable NSDictionary *)userInfo;
@end

NS_ASSUME_NONNULL_END
