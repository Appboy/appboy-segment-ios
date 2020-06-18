#import "SEGAppboyIntegration.h"
#import "AppboyKit.h"
#import <OCMock/OCMock.h>
#import <Analytics/SEGIntegration.h>
#import "SEGAnalyticsUtils.h"

SpecBegin(InitialSpecs)

describe(@"SEGAppboyIntegration", ^{
  describe(@"initWithSettings", ^{
    it(@"initializes appboy if an apiKey is passed", ^{
      NSDictionary *settings = @{@"apiKey":@"foo"};
      id appboyMock = OCMClassMock([Appboy class]);
      OCMExpect([appboyMock startWithApiKey:@"foo" inApplication:[OCMArg any] withLaunchOptions:nil withAppboyOptions:[OCMArg any]]);
      SEGAppboyIntegration *appboyIntegration = [[SEGAppboyIntegration alloc] initWithSettings:settings];
      OCMVerifyAllWithDelay(appboyMock, 2);
    });
  });
  
  describe(@"identify", ^{
    it(@"calls appropriate Appboy method with valid values", ^{
      NSDictionary *settings = @{@"apiKey":@"foo"};
      NSDateComponents *comps = [[NSDateComponents alloc] init];
      [comps setDay:10];
      [comps setMonth:10];
      [comps setYear:2010];
      NSDate *testDate = [[NSCalendar currentCalendar] dateFromComponents:comps];
      id appboyMock = OCMClassMock([Appboy class]);
      id appboyUserMock = OCMClassMock([ABKUser class]);
      OCMStub([appboyMock sharedInstance]).andReturn(appboyMock);
      OCMStub([appboyMock user]).andReturn(appboyUserMock);
      OCMExpect([appboyMock startWithApiKey:@"foo" inApplication:[OCMArg any] withLaunchOptions:nil withAppboyOptions:[OCMArg any]]);
      OCMExpect([appboyMock changeUser:@"testUser"]);
      OCMExpect([appboyUserMock setDateOfBirth:testDate]);
      OCMExpect([appboyUserMock setEmail:@"brian@appboy.com"]);
      OCMExpect([appboyUserMock setFirstName:@"brian"]);
      OCMExpect([appboyUserMock setLastName:@"w"]);
      OCMExpect([appboyUserMock setGender:ABKUserGenderMale]);
      OCMExpect([appboyUserMock setPhone:@"9084891234"]);
      OCMExpect([appboyUserMock setHomeCity:@"belmar"]);
      OCMExpect([appboyUserMock setCountry:@"usa"]);
      
      SEGAppboyIntegration *appboyIntegration = [[SEGAppboyIntegration alloc] initWithSettings:settings];
      
      NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
      formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZZZZZ";
      NSString *birthdate = [formatter stringFromDate:testDate];
      
      NSDictionary *traits = @{
                               @"address" : @{ @"city" : @"belmar", @"country" : @"usa" },
                               @"birthday" : birthdate,
                               @"email" : @"brian@appboy.com",
                               @"firstName" : @"brian",
                               @"lastName" : @"w",
                               @"gender" : @"m",
                               @"phone" : @"9084891234"
                               };
      
      SEGIdentifyPayload *identifyPayload = [[SEGIdentifyPayload alloc] initWithUserId:@"testUser"
                                                                           anonymousId:nil
                                                                                traits:traits
                                                                               context:nil
                                                                          integrations:nil];
      [appboyIntegration identify:identifyPayload];
      OCMVerifyAllWithDelay(appboyMock, 2);
      OCMVerifyAllWithDelay(appboyUserMock, 2);
    });
    
    it(@"doesn't break if types are bad", ^{
      NSDictionary *settings = @{@"apiKey":@"foo"};
      id appboyMock = OCMClassMock([Appboy class]);
      id appboyUserMock = OCMClassMock([ABKUser class]);
      OCMStub([appboyMock sharedInstance]).andReturn(appboyMock);
      OCMStub([appboyMock user]).andReturn(appboyUserMock);
      OCMExpect([appboyMock startWithApiKey:@"foo" inApplication:[OCMArg any] withLaunchOptions:nil withAppboyOptions:[OCMArg any]]);
      OCMExpect([appboyMock changeUser:@"testUser"]);
      
      SEGAppboyIntegration *appboyIntegration = [[SEGAppboyIntegration alloc] initWithSettings:settings];
      
      NSDictionary *traits = @{
                               @"address" : @{ @1 : @2, @"country" : @{@"asdf": @"asdf"}},
                               @"birthday" : @"badDate",
                               @"email" : @22,
                               @"firstName" : @1,
                               @"lastName" : @2,
                               @"gender" : @3,
                               @"phone" : @4
                               };
      
      SEGIdentifyPayload *identifyPayload = [[SEGIdentifyPayload alloc] initWithUserId:@"testUser"
                                                                           anonymousId:nil
                                                                                traits:traits
                                                                               context:nil
                                                                          integrations:nil];
      [appboyIntegration identify:identifyPayload];
      OCMVerifyAllWithDelay(appboyMock, 2);
      OCMVerifyAllWithDelay(appboyUserMock, 2);
    });
  });
  
  
  describe(@"track", ^{
    it(@"calls purchase if there is revenue", ^{
      NSDictionary *settings = @{@"apiKey":@"foo"};
      id appboyMock = OCMClassMock([Appboy class]);
      OCMStub([appboyMock sharedInstance]).andReturn(appboyMock);
      OCMExpect([appboyMock startWithApiKey:@"foo" inApplication:[OCMArg any] withLaunchOptions:nil withAppboyOptions:[OCMArg any]]);
      OCMExpect([appboyMock logPurchase:@"testPurchase" inCurrency:@"USD" atPrice:[NSDecimalNumber decimalNumberWithString:@"55.5"]
                           withQuantity:1 andProperties:@{@"extraProperty" : @"extraValue"}]);
      
      SEGAppboyIntegration *appboyIntegration = [[SEGAppboyIntegration alloc] initWithSettings:settings];
      
      NSDictionary *properties = @{
                                   @"revenue" : @"55.5",
                                   @"currency" : @"USD",
                                   @"extraProperty" : @"extraValue"
                                   };
      
      SEGTrackPayload *trackPayload = [[SEGTrackPayload alloc] initWithEvent:@"testPurchase"
                                                                  properties:properties
                                                                     context:nil
                                                                integrations:nil];
      [appboyIntegration track:trackPayload];
      OCMVerifyAllWithDelay(appboyMock, 2);
    });
  
    it(@"calls logPurchase for each product in the products array", ^{
      NSDictionary *settings = @{@"apiKey":@"foo"};
      id appboyMock = OCMClassMock([Appboy class]);
      OCMStub([appboyMock sharedInstance]).andReturn(appboyMock);
      OCMExpect([appboyMock startWithApiKey:@"foo" inApplication:[OCMArg any] withLaunchOptions:nil withAppboyOptions:[OCMArg any]]);
      OCMExpect(([appboyMock logPurchase:@"product1" inCurrency:@"USD" atPrice:[NSDecimalNumber decimalNumberWithString:@"72.3"]
                            withQuantity:29 andProperties:@{@"extraProperty" : @"extraValue",
                                                            @"productProperty" : @"productValue"
                            }]));
      
      SEGAppboyIntegration *appboyIntegration = [[SEGAppboyIntegration alloc] initWithSettings:settings];
      
      NSDictionary *properties = @{
                                   @"currency" : @"USD",
                                   @"extraProperty" : @"extraValue",
                                   @"products" : @[@{@"productId" : @"product1",
                                                     @"price" : @"72.3",
                                                     @"quantity" : @(29),
                                                     @"productProperty" : @"productValue"
                                                  }]
                                   };
      
      SEGTrackPayload *trackPayload = [[SEGTrackPayload alloc] initWithEvent:@"Order Completed"
                                                                  properties:properties
                                                                     context:nil
                                                                integrations:nil];
      [appboyIntegration track:trackPayload];
      OCMVerifyAllWithDelay(appboyMock, 2);
    });
    
    it(@"logs an event if there isn't revenue", ^{
      NSDictionary *settings = @{@"apiKey":@"foo"};
      id appboyMock = OCMClassMock([Appboy class]);
      OCMStub([appboyMock sharedInstance]).andReturn(appboyMock);
      OCMExpect([appboyMock startWithApiKey:@"foo" inApplication:[OCMArg any] withLaunchOptions:nil withAppboyOptions:[OCMArg any]]);
      NSDictionary *propertiesDictionary = @{ @"asdf" : @1, @"extraProperty" : @"extraValue"};
      OCMExpect([appboyMock logCustomEvent:@"testEvent" withProperties:propertiesDictionary]);
      
      SEGAppboyIntegration *appboyIntegration = [[SEGAppboyIntegration alloc] initWithSettings:settings];
      NSDictionary *properties = @{
                                   @"asdf" : @1,
                                   @"extraProperty" : @"extraValue"
                                   };
      
      SEGTrackPayload *trackPayload = [[SEGTrackPayload alloc] initWithEvent:@"testEvent"
                                                                  properties:properties
                                                                     context:nil
                                                                integrations:nil];
      [appboyIntegration track:trackPayload];
      OCMVerifyAllWithDelay(appboyMock, 2);
    });
  });
  
  describe(@"flush", ^{
    it(@"calls [[Appboy sharedInstance] flushDataAndProcessRequestQueue]", ^{
      NSDictionary *settings = @{@"apiKey":@"foo"};
      id appboyMock = OCMClassMock([Appboy class]);
      OCMStub([appboyMock sharedInstance]).andReturn(appboyMock);
      OCMExpect([appboyMock startWithApiKey:@"foo" inApplication:[OCMArg any] withLaunchOptions:nil withAppboyOptions:[OCMArg any]]);
      OCMExpect([appboyMock flushDataAndProcessRequestQueue]);
      SEGAppboyIntegration *appboyIntegration = [[SEGAppboyIntegration alloc] initWithSettings:settings];
      [appboyIntegration flush];
      OCMVerifyAllWithDelay(appboyMock, 2);
    });
  });
  
  describe(@"registeredForRemoteNotificationsWithDeviceToken", ^{
    it(@"initializes calls [[Appboy sharedInstance] registerPushToken]", ^{
      NSDictionary *settings = @{@"apiKey":@"foo"};
      NSData *registerData = [[NSData alloc] init];
      id appboyMock = OCMClassMock([Appboy class]);
      OCMStub([appboyMock sharedInstance]).andReturn(appboyMock);
      OCMExpect([appboyMock startWithApiKey:@"foo" inApplication:[OCMArg any] withLaunchOptions:nil withAppboyOptions:[OCMArg any]]);
      OCMExpect([appboyMock registerDeviceToken:[OCMArg any]]);
      SEGAppboyIntegration *appboyIntegration = [[SEGAppboyIntegration alloc] initWithSettings:settings];
      [appboyIntegration registeredForRemoteNotificationsWithDeviceToken:registerData];
      OCMVerifyAllWithDelay(appboyMock, 2);
    });
  });
  
  describe(@"receivedRemoteNotification", ^{
    it(@"initializes calls [[Appboy sharedInstance] registerApplication:didReceiveRemoteNotification:]", ^{
      NSDictionary *settings = @{@"apiKey":@"foo"};
      NSDictionary *userInfo = @{@"test":@"userInfo"};
      id appboyMock = OCMClassMock([Appboy class]);
      OCMStub([appboyMock sharedInstance]).andReturn(appboyMock);
      OCMExpect([appboyMock startWithApiKey:@"foo" inApplication:[OCMArg any] withLaunchOptions:nil withAppboyOptions:[OCMArg any]]);
      OCMExpect([appboyMock registerApplication:[OCMArg any] didReceiveRemoteNotification:userInfo]);
      SEGAppboyIntegration *appboyIntegration = [[SEGAppboyIntegration alloc] initWithSettings:settings];
      [appboyIntegration receivedRemoteNotification:userInfo];
      OCMVerifyAllWithDelay(appboyMock, 2);
    });
  });
});

SpecEnd
