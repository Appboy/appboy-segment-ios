#import <Foundation/Foundation.h>
#import <Analytics/SEGIntegrationFactory.h>
#import "SEGAppboyHelper.h"
#import "SEGAppboyIntegration.h"

@class SEGAppboyIntegrationOptions;

NS_ASSUME_NONNULL_BEGIN

@interface SEGAppboyIntegrationFactory : NSObject<SEGIntegrationFactory>

@property (nonatomic, nullable, strong) SEGAppboyIntegrationOptions *integrationOptions;
@property (readonly) SEGAppboyHelper *appboyHelper;
// Passed to Appboy as appboyOptions, available keys for configuration
// are documented in Appboy.h
@property NSDictionary *appboyOptions;

+ (instancetype)instance;

- (void)saveLaunchOptions:(nullable NSDictionary *)launchOptions;
- (void)saveRemoteNotification:(nullable NSDictionary *)userInfo;
@end

NS_ASSUME_NONNULL_END
