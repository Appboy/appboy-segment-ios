#import "AppDelegate.h"
#import "SEGAppboyIntegrationFactory.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    SEGAnalyticsConfiguration *config = [SEGAnalyticsConfiguration configurationWithWriteKey:@"YOUR-WRITE-KEY-HERE"];
    [config use:[SEGAppboyIntegrationFactory instance]];
    [[SEGAppboyIntegrationFactory instance] saveLaunchOptions:launchOptions];
    [SEGAnalytics setupWithConfiguration:config];
    [SEGAnalytics debug:YES];
    return YES;
}

@end
