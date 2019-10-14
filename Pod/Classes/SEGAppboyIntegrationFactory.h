#import <Foundation/Foundation.h>
#import <Analytics/SEGIntegrationFactory.h>
#import "SEGAppboyIntegration.h"

@interface SEGAppboyIntegrationFactory : NSObject<SEGIntegrationFactory>

+ (instancetype)instance;
+ (instancetype)withLocalConfiguration:(AppBoyLocalConfiguration *)localConfiguration;

- (void)saveLaunchOptions:(NSDictionary *)launchOptions;
- (void)saveRemoteNotification:(NSDictionary *)userInfo;
@end
