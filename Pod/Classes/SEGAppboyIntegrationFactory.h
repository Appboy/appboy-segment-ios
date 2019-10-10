#import <Foundation/Foundation.h>
#import <Analytics/SEGIntegrationFactory.h>
#import <Appboy_iOS_SDK/ABKIDFADelegate.h>
#import "SEGAppboyIntegration.h"

@interface SEGAppboyIntegrationFactory : NSObject<SEGIntegrationFactory>

+ (instancetype)instance;
+ (instancetype)withLocalConfiguration:(AppBoyLocalConfiguration *)localConfiguration;

- (void)saveLaunchOptions:(NSDictionary *)launchOptions;
- (void)saveRemoteNotification:(NSDictionary *)userInfo;
@end
