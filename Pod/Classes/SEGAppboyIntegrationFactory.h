#import <Foundation/Foundation.h>
#if __has_include(<Segment/SEGIntegrationFactory.h>)
#import <Segment/SEGIntegrationFactory.h>
#elif __has_include(<Analytics/SEGIntegrationFactory.h>)
#import <Analytics/SEGIntegrationFactory.h>
#endif
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
