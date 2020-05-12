#import <Foundation/Foundation.h>
#import <Analytics/SEGIntegration.h>

@interface SEGAppboyIntegration : NSObject<SEGIntegration>

@property(nonatomic, strong, nullable) NSDictionary *settings;

- (nullable id)initWithSettings:(nonnull NSDictionary *)settings;
- (nullable id)initWithSettings:(nonnull NSDictionary *)settings appboyOptions:(nullable NSDictionary *)appboyOptions;

@end
