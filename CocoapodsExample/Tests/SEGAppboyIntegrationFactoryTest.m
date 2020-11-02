#import "SEGAppboyIntegrationFactory.h"
#import "SEGAppboyIntegration.h"
#import "AppboyKit.h"
#import <OCMock/OCMock.h>
#if __has_include(<Segment/SEGIntegration.h>)
#import <Segment/SEGIntegration.h>
#elif __has_include(<Analytics/SEGIntegration.h>)
#import <Analytics/SEGIntegration.h>
#endif
#import "SEGAnalyticsUtils.h"

SpecBegin(SEGAppboyIntegrationFactory)

describe(@"SEGAppboyIntegrationFactory", ^{
  describe(@"appboyOptionsPassedByFactory", ^{
     it(@"initializes appboy with options", ^{
       NSDictionary *settings = @{@"apiKey": @"foo"};
       NSDictionary *options = @{ABKMinimumTriggerTimeIntervalKey: @42,
                                 ABKSDKFlavorKey: @(SEGMENT)
       };
       id appboyMock = OCMClassMock([Appboy class]);
       OCMExpect([appboyMock startWithApiKey:@"foo" inApplication:[OCMArg any] withLaunchOptions:nil withAppboyOptions:options]);
       [SEGAppboyIntegrationFactory instance].appboyOptions = options;
       
       [[SEGAppboyIntegrationFactory instance] createWithSettings:settings forAnalytics:[SEGAnalytics sharedAnalytics]];
       OCMVerifyAllWithDelay(appboyMock, 2);
     });
   });
});

SpecEnd
