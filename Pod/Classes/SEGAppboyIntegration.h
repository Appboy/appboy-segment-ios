#import <Foundation/Foundation.h>
#import <Analytics/SEGIntegration.h>

@class SEGAppboyIntegrationOptions;

NS_ASSUME_NONNULL_BEGIN

@interface SEGAppboyIntegration : NSObject<SEGIntegration>

@property (nonatomic, strong) NSDictionary *settings;
@property (nonatomic, nullable, strong, readonly) SEGAppboyIntegrationOptions *integrationOptions;

- (instancetype)initWithSettings:(NSDictionary *)settings;
- (instancetype)initWithSettings:(NSDictionary *)settings integrationOptions:(nullable SEGAppboyIntegrationOptions *)options;

@end

NS_ASSUME_NONNULL_END
