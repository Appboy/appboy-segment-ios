#import <Foundation/Foundation.h>
#import <Analytics/SEGIntegrationFactory.h>

@class SEGAppboyIntegrationOptions;

@interface SEGAppboyIntegrationFactory : NSObject<SEGIntegrationFactory>

@property (nonatomic, nullable, strong) SEGAppboyIntegrationOptions *integrationOptions;

+ (instancetype)instance;

- (void)saveLaunchOptions:(NSDictionary *)launchOptions;
- (void)saveRemoteNotification:(NSDictionary *)userInfo;
@end
