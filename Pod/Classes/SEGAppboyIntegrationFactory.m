#import "SEGAppboyIntegrationFactory.h"

@interface SEGAppboyIntegrationFactory ()
@property NSDictionary *savedPushPayload;
@end

@implementation SEGAppboyIntegrationFactory

AppBoyLocalConfiguration *_localConfiguration;

+ (instancetype)instance
{
  static dispatch_once_t once;
  static SEGAppboyIntegrationFactory *sharedInstance;
  dispatch_once(&once, ^{
    sharedInstance = [[self alloc] init];
  });
  return sharedInstance;
}

+ (instancetype)withLocalConfiguration:(AppBoyLocalConfiguration *)localConfiguration
{
  SEGAppboyIntegrationFactory *instance = [SEGAppboyIntegrationFactory instance];
  [instance setLocalConfiguration:localConfiguration];
  return instance;
}

- (id)init
{
  self = [super init];
  return self;
}

- (void)setLocalConfiguration:(AppBoyLocalConfiguration *)localConfiguration
{
  _localConfiguration = localConfiguration;
}

- (id<SEGIntegration>)createWithSettings:(NSDictionary *)settings forAnalytics:(SEGAnalytics *)analytics
{
  return [[SEGAppboyIntegration alloc] initWithSettings:settings localConfiguration:_localConfiguration];
}

- (NSString *)key
{
  return @"Appboy";
}

- (void) saveLaunchOptions:(NSDictionary *)launchOptions {
  NSDictionary *pushPayLoad = launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey];
  if (pushPayLoad != nil && pushPayLoad.count > 0) {
    self.savedPushPayload = [pushPayLoad copy];
  }
}

- (void)saveRemoteNotification:(NSDictionary *)userInfo {
  self.savedPushPayload = [userInfo copy];
}

- (NSDictionary *) getPushPayload {
  return self.savedPushPayload;
}
@end
