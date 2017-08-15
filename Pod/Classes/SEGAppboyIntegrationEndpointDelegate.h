#import "Foundation/Foundation.h"
#import "ABKAppboyEndpointDelegate.h"

@interface SEGAppboyIntegrationEndpointDelegate : NSObject <ABKAppboyEndpointDelegate>

@property NSString *customEndpoint;

- (instancetype)initWithCustomEndpoint:(NSString *)customEndpoint;

@end
