#import <Foundation/Foundation.h>
#import <Analytics/SEGIntegrationFactory.h>
#import "SEGAppboyHelper.h"

@interface SEGAppboyIntegrationFactory : NSObject<SEGIntegrationFactory>

@property (readonly) SEGAppboyHelper *appboyHelper;

+ (instancetype)instance;

- (void)saveLaunchOptions:(NSDictionary *)launchOptions;
- (void)saveRemoteNotification:(NSDictionary *)userInfo;

@end
