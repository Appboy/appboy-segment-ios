#import "SEGAppboyIntegrationFactory.h"
#import "SEGAppboyIntegration.h"
#import "AppboyKit.h"
#import <OCMock/OCMock.h>
#import <Segment/SEGIntegration.h>
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
