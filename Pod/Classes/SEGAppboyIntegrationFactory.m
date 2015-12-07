#import "SEGAppboyIntegrationFactory.h"
#import "SEGAppboyIntegration.h"

@implementation SEGAppboyIntegrationFactory

+ (id)instance
{
  static dispatch_once_t once;
  static SEGAppboyIntegrationFactory *sharedInstance;
  dispatch_once(&once, ^{
    sharedInstance = [[self alloc] init];
  });
  return sharedInstance;
}

- (id)init
{
  self = [super init];
  return self;
}

- (id<SEGIntegration>)createWithSettings:(NSDictionary *)settings forAnalytics:(SEGAnalytics *)analytics
{
  return [[SEGAppboyIntegration alloc] initWithSettings:settings];
}

- (NSString *)key
{
  return @"Appboy";
}

@end