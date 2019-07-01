#import "SEGAppboyIntegrationEndpointDelegate.h"

@implementation SEGAppboyIntegrationEndpointDelegate

- (instancetype)initWithCustomEndpoint:(NSString *)customEndpoint {
  if (self = [super init]) {
    self.customEndpoint = customEndpoint;
  }
  return self;
}

- (NSString *)getApiEndpoint:(NSString *)appboyApiEndpoint {
  NSString *customEndpoint = [appboyApiEndpoint stringByReplacingOccurrencesOfString:@"dev.appboy.com" withString:self.customEndpoint];
  return [customEndpoint stringByReplacingOccurrencesOfString:@"sdk.iad-01.braze.com" withString:self.customEndpoint];
}

@end
