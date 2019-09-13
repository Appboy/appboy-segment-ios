#import <Foundation/Foundation.h>
#import <Analytics/SEGIntegration.h>
#import <Appboy_iOS_SDK/ABKIDFADelegate.h>

@interface SEGAppboyIntegration : NSObject<SEGIntegration>

@property(nonatomic, strong) NSDictionary *settings;

- (id)initWithSettings:(NSDictionary *)settings;
- (id)initWithSettings:(NSDictionary *)settings idfaDelegate:(id<ABKIDFADelegate>)idfaDelegate;

@end