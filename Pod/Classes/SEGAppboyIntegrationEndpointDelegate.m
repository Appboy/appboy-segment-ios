#import "SEGAppboyIntegrationEndpointDelegate.h"

@implementation SEGAppboyIntegrationEndpointDelegate

- (instancetype)initWithCustomEndpoint:(NSString *)customEndpoint {
  if (self = [super init]) {
    self.customEndpoint = customEndpoint;
  }
  return self;
}

- (NSString *)getApiEndpoint:(NSString *)appboyApiEndpoint {
  return [appboyApiEndpoint stringByReplacingOccurrencesOfString:@"dev.appboy.com" withString:self.customEndpoint];
}

@end
