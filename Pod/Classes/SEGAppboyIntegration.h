#import <Foundation/Foundation.h>
#import <Analytics/SEGIntegration.h>
#import "AppboyLocalConfigurationKey.h"

typedef NSDictionary<AppboyLocalConfigurationKey *, id> AppBoyConfiguration;

@interface SEGAppboyIntegration : NSObject<SEGIntegration>

@property(nonatomic, strong) NSDictionary *settings;

- (id)initWithSettings:(NSDictionary *)settings;
- (id)initWithSettings:(NSDictionary *)settings localConfiguration:(AppBoyConfiguration *)localConfiguration;

@end
