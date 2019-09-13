#import "SEGAppboyIntegrationFactory.h"
#import "SEGAppboyIntegration.h"

@interface SEGAppboyIntegrationFactory ()
@property NSDictionary *savedPushPayload;
@end

@implementation SEGAppboyIntegrationFactory

id<ABKIDFADelegate> _idfaDelegate;

+ (instancetype)instance
{
  static dispatch_once_t once;
  static SEGAppboyIntegrationFactory *sharedInstance;
  dispatch_once(&once, ^{
    sharedInstance = [[self alloc] init];
  });
  return sharedInstance;
}

+ (instancetype)withIDFADelegate:(id<ABKIDFADelegate>)idfaDelegate
{
  SEGAppboyIntegrationFactory *instance = [SEGAppboyIntegrationFactory instance];
  [instance setIDFADelegate:idfaDelegate];
  return instance;
}

- (id)init
{
  self = [super init];
  return self;
}

- (void)setIDFADelegate:(id<ABKIDFADelegate>)idfaDelegate
{
  _idfaDelegate = idfaDelegate;
}

- (id<SEGIntegration>)createWithSettings:(NSDictionary *)settings forAnalytics:(SEGAnalytics *)analytics
{
  return [[SEGAppboyIntegration alloc] initWithSettings:settings idfaDelegate:_idfaDelegate];
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