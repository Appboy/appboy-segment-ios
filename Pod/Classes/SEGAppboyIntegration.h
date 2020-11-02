#import <Foundation/Foundation.h>
#if __has_include(<Segment/SEGIntegration.h>)
#import <Segment/SEGIntegration.h>
#elif __has_include(<Analytics/SEGIntegration.h>)
#import <Analytics/SEGIntegration.h>
#endif

@class SEGAppboyIntegrationOptions;

NS_ASSUME_NONNULL_BEGIN

@interface SEGAppboyIntegration : NSObject<SEGIntegration>

@property(nonatomic, strong, nullable) NSDictionary *settings;
@property (nonatomic, nullable, strong, readonly) SEGAppboyIntegrationOptions *integrationOptions;

- (nullable id)initWithSettings:(nonnull NSDictionary *)settings;
- (nullable id)initWithSettings:(nonnull NSDictionary *)settings appboyOptions:(nullable NSDictionary *)appboyOptions integrationOptions:(nullable SEGAppboyIntegrationOptions *)options;

@end

NS_ASSUME_NONNULL_END
