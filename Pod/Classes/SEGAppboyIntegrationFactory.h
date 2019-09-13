#import <Foundation/Foundation.h>
#import <Analytics/SEGIntegrationFactory.h>
#import <Appboy_iOS_SDK/ABKIDFADelegate.h>

@interface SEGAppboyIntegrationFactory : NSObject<SEGIntegrationFactory>

+ (instancetype)instance;
+ (instancetype)withIDFADelegate:(id<ABKIDFADelegate>)idfaDelegate;

- (void)saveLaunchOptions:(NSDictionary *)launchOptions;
- (void)saveRemoteNotification:(NSDictionary *)userInfo;
@end