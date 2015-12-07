#import "SEGAppboyIntegration.h"
#import "Appboy-iOS-SDK/AppboyKit.h"
#import "Appboy-iOS-SDK/ABKUser.h"
#import <Analytics/SEGAnalyticsUtils.h>

@implementation SEGAppboyIntegration

- (id)initWithSettings:(NSDictionary *)settings
{
  if (self = [super init]) {
    self.settings = settings;
    dispatch_async(dispatch_get_main_queue(), ^{
      NSString *appboyAPIKey = [self.settings objectForKey:@"apiKey"];
      [Appboy startWithApiKey:appboyAPIKey
                inApplication:[UIApplication sharedApplication]
            withLaunchOptions:nil];
      SEGLog(@"[Appboy startWithApiKey:inApplication:withLaunchOptions:]");
    });
  }
  
  return self;
}

- (void)identify:(SEGIdentifyPayload *)payload
{
  // Ensure that the userID is set and valid (i.e. a non-empty string).
  if (payload.userId != nil && [payload.userId length] != 0) {
    // `changeUser:` should always be called in the main thread. If we are already in the main thread,
    // calling dispatch_sync will cause hanging.
    if ([NSThread isMainThread]) {
      [[Appboy sharedInstance] changeUser:payload.userId];
      SEGLog(@"[[Appboy sharedInstance] changeUser:%@]", payload.userId);
    } else {
      dispatch_sync(dispatch_get_main_queue(), ^{
        [[Appboy sharedInstance] changeUser:payload.userId];
        SEGLog(@"[[Appboy sharedInstance] changeUser:%@]", payload.userId);
      });
    }
  }
  
  if ([payload.traits[@"birthday"] isKindOfClass:[NSString class]]) {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *enUSPOSIXLocale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
    [dateFormatter setLocale:enUSPOSIXLocale];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZZ"];
    [Appboy sharedInstance].user.dateOfBirth = [dateFormatter dateFromString:payload.traits[@"birthday"]];
    SEGLog(@"Logged [Appboy sharedInstance].user.dateOfBirth");
  }
  
  if ([payload.traits[@"email"] isKindOfClass:[NSString class]]) {
    [Appboy sharedInstance].user.email = payload.traits[@"email"];
    SEGLog(@"Logged [Appboy sharedInstance].user.email");
  }
  
  if ([payload.traits[@"firstName"] isKindOfClass:[NSString class]]) {
    [Appboy sharedInstance].user.firstName = payload.traits[@"firstName"];
    SEGLog(@"Logged [Appboy sharedInstance].user.firstName");
  }
  
  if ([payload.traits[@"lastName"] isKindOfClass:[NSString class]]) {
    [Appboy sharedInstance].user.lastName = payload.traits[@"lastName"];
    SEGLog(@"Logged [Appboy sharedInstance].user.lastName");
  }
  
  // Appboy only accepts "m" or "male" for gender male, and "f" or "female" for gender female, with case insensitive.
  if ([payload.traits[@"gender"] isKindOfClass:[NSString class]]) {
    NSString *gender = payload.traits[@"gender"];
    if ([gender.lowercaseString isEqualToString:@"m"] || [gender.lowercaseString isEqualToString:@"male"]) {
      [[Appboy sharedInstance].user setGender:ABKUserGenderMale];
      SEGLog(@"[[Appboy sharedInstance].user setGender:]");
    } else if ([gender.lowercaseString isEqualToString:@"f"] || [gender.lowercaseString isEqualToString:@"female"]) {
      [[Appboy sharedInstance].user setGender:ABKUserGenderFemale];
      SEGLog(@"[[Appboy sharedInstance].user setGender:]");
    }
  }
  
  if ([payload.traits[@"phone"] isKindOfClass:[NSString class]]) {
    [Appboy sharedInstance].user.phone = payload.traits[@"phone"];
    SEGLog(@"Logged [Appboy sharedInstance].user.phone");
  }
  
  if ([payload.traits[@"address"] isKindOfClass:[NSDictionary class]]) {
    NSDictionary *address = payload.traits[@"address"];
    if ([address[@"city"] isKindOfClass:[NSString class]]) {
      [Appboy sharedInstance].user.homeCity = address[@"city"];
      SEGLog(@"Logged [Appboy sharedInstance].user.homeCity");
    }
    
    if ([address[@"country"] isKindOfClass:[NSString class]]) {
      [Appboy sharedInstance].user.country = address[@"country"];
      SEGLog(@"Logged [Appboy sharedInstance].user.country");
    }
  }
  
  NSArray *appboyTraits = @[@"birthday", @"email", @"firstName", @"lastName",  @"gender", @"phone", @"address", @"anonymousID"];
  
  // Other traits. Iterate over all the traits and set them.
  for (NSString *key in payload.traits.allKeys) {
    if (![appboyTraits containsObject:key]) {
      id traitValue = payload.traits[key];
      if ([traitValue isKindOfClass:[NSString class]]) {
      [[Appboy sharedInstance].user setCustomAttributeWithKey:key andStringValue:traitValue];
        SEGLog(@"[[Appboy sharedInstance].user setCustomAttributeWithKey: andStringValue:]");
      } else if ([traitValue isKindOfClass:[NSNumber class]]) {
        if (strcmp([traitValue objCType], [@(YES) objCType]) == 0) {
          [[Appboy sharedInstance].user setCustomAttributeWithKey:key andBOOLValue:[(NSNumber *)traitValue boolValue]];
          SEGLog(@"[[Appboy sharedInstance].user setCustomAttributeWithKey: andBOOLValue:]");
        } else if (strcmp([traitValue objCType], @encode(int)) == 0) {
          [[Appboy sharedInstance].user setCustomAttributeWithKey:key andIntegerValue:[(NSNumber *)traitValue integerValue]];
          SEGLog(@"[[Appboy sharedInstance].user setCustomAttributeWithKey: andIntegerValue:]");
        } else if (strcmp([traitValue objCType], @encode(double)) == 0) {
          [[Appboy sharedInstance].user setCustomAttributeWithKey:key andDoubleValue:[(NSNumber *)traitValue doubleValue]];
          SEGLog(@"[[Appboy sharedInstance].user setCustomAttributeWithKey: andDoubleValue:]");
        } else {
          SEGLog(@"Could not map NSNumber value to Appboy custom attribute:%@]", traitValue);
        }
      }
    }
  }
}

- (void)track:(SEGTrackPayload *)payload
{
  NSDecimalNumber *revenue = [SEGAppboyIntegration extractRevenue:payload.properties withKey:@"revenue"];
  if (revenue) {
    NSString *currency = @"USD";  // Make USD as the default currency.
    if ([payload.properties[@"currency"] isKindOfClass:[NSString class]] &&
        [(NSString *)payload.properties[@"currency"] length] == 3) {  // Currency should be an ISO 4217 currency code.
      currency = payload.properties[@"currency"];
    }
    
    if (payload.properties != nil) {
      NSMutableDictionary *appboyProperties = [NSMutableDictionary dictionaryWithDictionary:payload.properties];
      appboyProperties[@"currency"] = nil;
      appboyProperties[@"revenue"] = nil;
      [[Appboy sharedInstance] logPurchase:payload.event inCurrency:currency atPrice:revenue withQuantity:1 andProperties:appboyProperties];
    } else {
      [[Appboy sharedInstance] logPurchase:payload.event inCurrency:currency atPrice:revenue withQuantity:1];
    }
    SEGLog(@"[[Appboy sharedInstance] logPurchase: inCurrency: atPrice: withQuantity:]");
  } else {
    [[Appboy sharedInstance] logCustomEvent:payload.event withProperties:payload.properties];
    SEGLog(@"[[Appboy sharedInstance] logCustomEvent: withProperties:]");
  }
}

+ (NSDecimalNumber *)extractRevenue:(NSDictionary *)dictionary withKey:(NSString *)revenueKey
{
  id revenueProperty = dictionary[revenueKey];
  if (revenueProperty) {
    if ([revenueProperty isKindOfClass:[NSString class]]) {
      return [NSDecimalNumber decimalNumberWithString:revenueProperty];
    } else if ([revenueProperty isKindOfClass:[NSDecimalNumber class]]) {
      return revenueProperty;
    }
  }
  return nil;
}

- (void)flush
{
  [[Appboy sharedInstance] flushDataAndProcessRequestQueue];
  SEGLog(@"[[Appboy sharedInstance] flushDataAndProcessRequestQueue]");
}

// Invoked when the device is registered with a push token.
// Appboy uses this to send push messages to the device, so forward it to Appboy.
- (void)registeredForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
  [[Appboy sharedInstance] registerPushToken:[NSString stringWithFormat:@"%@", deviceToken]];
  SEGLog(@"[[Appboy sharedInstance] registerPushToken:]");
}
@end
