#import <Foundation/Foundation.h>
#import <Analytics/SEGIntegration.h>
#import "AppboyLocalConfigurationProperty.h"

typedef NSDictionary<AppboyLocalConfigurationProperty *, id> AppBoyLocalConfiguration;

@interface SEGAppboyIntegration : NSObject<SEGIntegration>

@property(nonatomic, strong) NSDictionary *settings;

- (id)initWithSettings:(NSDictionary *)settings;
- (id)initWithSettings:(NSDictionary *)settings localConfiguration:(AppBoyLocalConfiguration *)localConfiguration;

@end
