#import "Foundation/Foundation.h"
#if defined(__has_include) && __has_include(<Appboy_iOS_SDK/AppboyKit.h>)
#import <Appboy_iOS_SDK/ABKAppboyEndpointDelegate.h>
#else
#import "Appboy-iOS-SDK/ABKAppboyEndpointDelegate.h"
#endif

@interface SEGAppboyIntegrationEndpointDelegate : NSObject <ABKAppboyEndpointDelegate>

@property NSString *customEndpoint;

- (instancetype)initWithCustomEndpoint:(NSString *)customEndpoint;

@end
