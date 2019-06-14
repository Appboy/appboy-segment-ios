#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SEGAppboyIntegrationOptions : NSObject

@property (nonatomic, assign) BOOL disableIdentifyEvents;
@property (nonatomic, assign) BOOL enableTraitDiffing;
@property (nonatomic, copy) NSString* (^userIdMapper)(NSString *segmentUserId);

@end

NS_ASSUME_NONNULL_END
