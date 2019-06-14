#import <Foundation/Foundation.h>
#import <Analytics/SEGIntegration.h>

@class SEGAppboyIntegrationOptions;

@interface SEGAppboyIntegration : NSObject<SEGIntegration>

@property (nonatomic, strong) NSDictionary *settings;
@property (nonatomic, nullable, strong, readonly) SEGAppboyIntegrationOptions *integrationOptions;

- (id)initWithSettings:(NSDictionary *)settings;
- (id)initWithSettings:(NSDictionary *)settings integrationOptions:(SEGAppboyIntegrationOptions *)options;

@end
