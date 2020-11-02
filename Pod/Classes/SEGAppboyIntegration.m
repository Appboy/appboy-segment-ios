#import "SEGAppboyIntegration.h"
#if defined(__has_include) && __has_include(<Appboy_iOS_SDK/AppboyKit.h>)
#import <Appboy_iOS_SDK/AppboyKit.h>
#import <Appboy_iOS_SDK/ABKUser.h>
#import <Appboy_iOS_SDK/ABKAttributionData.h>
#else
#import "Appboy-iOS-SDK/AppboyKit.h"
#import "Appboy-iOS-SDK/ABKUser.h"
#import "Appboy-iOS-SDK/ABKAttributionData.h"
#endif
#if __has_include(<Segment/SEGIntegration.h>)
#import <Segment/SEGAnalyticsUtils.h>
#elif __has_include(<Analytics/SEGIntegration.h>)
#import <Analytics/SEGAnalyticsUtils.h>
#endif
#import "SEGAppboyIntegrationFactory.h"
#import "SEGAppboyIntegrationOptions.h"
#import "SEGAppboyAdditions.h"

static NSString *UserDefaultsDomain = @"com.appboy.segment.userTraits";

@interface Appboy(Segment)

- (void) handleRemotePushNotification:(NSDictionary *)notification
                       withIdentifier:(NSString *)identifier
                    completionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
                     applicationState:(UIApplicationState)applicationState;
@end

@interface SEGAppboyIntegrationFactory(Integration)
- (NSString *)key;
- (NSDictionary *) getPushPayload;
@end

@interface SEGAppboyIntegration()

@property (nonatomic, nullable, strong) SEGAppboyIntegrationOptions *integrationOptions;
@property (nonatomic, nonnull, strong) NSMutableDictionary *userTraits;

@end

@implementation SEGAppboyIntegration

- (id)initWithSettings:(NSDictionary *)settings
{
  return [self initWithSettings:settings appboyOptions:nil integrationOptions:nil];
}

- (id)initWithSettings:(NSDictionary *)settings appboyOptions:(NSDictionary *)appboyOptions integrationOptions:(SEGAppboyIntegrationOptions *)options
{
  if (self = [super init]) {
    self.settings = settings;
    self.integrationOptions = options;
    id appboyAPIKey = self.settings[@"apiKey"];
    if (![appboyAPIKey isKindOfClass:[NSString class]] || [appboyAPIKey length] == 0) {
      return nil;
    }
    
    NSMutableDictionary *mergedAppboyOptions;
    if (appboyOptions) {
     mergedAppboyOptions = [appboyOptions mutableCopy];
     mergedAppboyOptions[ABKSDKFlavorKey] = @(SEGMENT);
    } else {
      mergedAppboyOptions = [@{ABKSDKFlavorKey : @(SEGMENT)} mutableCopy];
    }
    NSString *customEndpoint = self.settings[@"customEndpoint"];
    if (customEndpoint && [customEndpoint length] != 0) {
      mergedAppboyOptions[ABKEndpointKey] = customEndpoint;
    }

    if ([NSThread isMainThread]) {
      [Appboy startWithApiKey:appboyAPIKey
                inApplication:[UIApplication sharedApplication]
            withLaunchOptions:nil
            withAppboyOptions:mergedAppboyOptions];
      SEGLog(@"[Appboy startWithApiKey:inApplication:withLaunchOptions:withAppboyOptions:]");
    } else {
      dispatch_sync(dispatch_get_main_queue(), ^{
        [Appboy startWithApiKey:appboyAPIKey
                  inApplication:[UIApplication sharedApplication]
              withLaunchOptions:nil
              withAppboyOptions:mergedAppboyOptions];
        SEGLog(@"[Appboy startWithApiKey:inApplication:withLaunchOptions:withAppboyOptions:]");
      });
    }

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *userTraits = [NSMutableDictionary dictionaryWithDictionary:[userDefaults dictionaryForKey:UserDefaultsDomain]];
    self.userTraits = userTraits;
  }
  
  if ([Appboy sharedInstance] != nil) {
    return self;
  } else {
    return nil;
  }
  
}

- (void)identify:(SEGIdentifyPayload *)payload
{
  if (![NSThread isMainThread]) {
    dispatch_async(dispatch_get_main_queue(), ^{
      [self identify:payload];
    });
    return;
  }

  NSDictionary *traits = payload.traits;

  if (self.integrationOptions.enableTraitDiffing) {
    traits = [[self.userTraits sega_newOrDifferentEntriesFrom:payload.traits] mutableCopy];
  }

  NSString *userId = payload.userId;
  if (userId != nil && userId != 0) {
    if (self.integrationOptions.userIdMapper != nil) {
      userId = self.integrationOptions.userIdMapper(userId);
    }
    [[Appboy sharedInstance] changeUser:userId];
    SEGLog(@"[[Appboy sharedInstance] changeUser:%@]", userId);
  }
  
  if ([traits[@"birthday"] isKindOfClass:[NSString class]]) {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *enUSPOSIXLocale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
    [dateFormatter setLocale:enUSPOSIXLocale];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZZ"];
    [Appboy sharedInstance].user.dateOfBirth = [dateFormatter dateFromString:traits[@"birthday"]];
    SEGLog(@"Logged [Appboy sharedInstance].user.dateOfBirth");
  }
  
  if ([traits[@"email"] isKindOfClass:[NSString class]]) {
    [Appboy sharedInstance].user.email = traits[@"email"];
    SEGLog(@"Logged [Appboy sharedInstance].user.email");
  }
  
  if ([traits[@"firstName"] isKindOfClass:[NSString class]]) {
    [Appboy sharedInstance].user.firstName = traits[@"firstName"];
    SEGLog(@"Logged [Appboy sharedInstance].user.firstName");
  }
  
  if ([traits[@"lastName"] isKindOfClass:[NSString class]]) {
    [Appboy sharedInstance].user.lastName = traits[@"lastName"];
    SEGLog(@"Logged [Appboy sharedInstance].user.lastName");
  }
  
  // Appboy only accepts "m" or "male" for gender male, and "f" or "female" for gender female, with case insensitive.
  if ([traits[@"gender"] isKindOfClass:[NSString class]]) {
    NSString *gender = traits[@"gender"];
    if ([gender.lowercaseString isEqualToString:@"m"] || [gender.lowercaseString isEqualToString:@"male"]) {
      [[Appboy sharedInstance].user setGender:ABKUserGenderMale];
      SEGLog(@"[[Appboy sharedInstance].user setGender:]");
    } else if ([gender.lowercaseString isEqualToString:@"f"] || [gender.lowercaseString isEqualToString:@"female"]) {
      [[Appboy sharedInstance].user setGender:ABKUserGenderFemale];
      SEGLog(@"[[Appboy sharedInstance].user setGender:]");
    }
  }
  
  if ([traits[@"phone"] isKindOfClass:[NSString class]]) {
    [Appboy sharedInstance].user.phone = traits[@"phone"];
    SEGLog(@"Logged [Appboy sharedInstance].user.phone");
  }
  
  if ([traits[@"address"] isKindOfClass:[NSDictionary class]]) {
    NSDictionary *address = traits[@"address"];
    if ([address[@"city"] isKindOfClass:[NSString class]]) {
      [Appboy sharedInstance].user.homeCity = address[@"city"];
      SEGLog(@"Logged [Appboy sharedInstance].user.homeCity");
    }
    
    if ([address[@"country"] isKindOfClass:[NSString class]]) {
      [Appboy sharedInstance].user.country = address[@"country"];
      SEGLog(@"Logged [Appboy sharedInstance].user.country");
    }
  }

  if ([traits[@"avatar"] isKindOfClass:[NSString class]]) {
    [Appboy sharedInstance].user.avatarImageURL = traits[@"avatar"];
    SEGLog(@"Logged [Appboy sharedInstance].user.avatarImageURL");
  }
  
  NSArray *appboyTraits = @[@"birthday", @"email", @"firstName", @"lastName",  @"gender", @"phone", @"address", @"anonymousID"];
  
  // Other traits. Iterate over all the traits and set them.
  for (NSString *key in traits.allKeys) {
    if (![appboyTraits containsObject:key]) {
      id traitValue = traits[key];
      if ([traitValue isKindOfClass:[NSString class]]) {
        [[Appboy sharedInstance].user setCustomAttributeWithKey:key andStringValue:traitValue];
        SEGLog(@"[[Appboy sharedInstance].user setCustomAttributeWithKey: andStringValue:]");
      } else if ([traitValue isKindOfClass:[NSDate class]]) {
        [[Appboy sharedInstance].user setCustomAttributeWithKey:key andDateValue:traitValue];
        SEGLog(@"[[Appboy sharedInstance].user setCustomAttributeWithKey: andDateValue:]");
      } else if ([traitValue isKindOfClass:[NSNumber class]]) {
        if (strcmp([traitValue objCType], [@(YES) objCType]) == 0) {
          [[Appboy sharedInstance].user setCustomAttributeWithKey:key andBOOLValue:[(NSNumber *)traitValue boolValue]];
          SEGLog(@"[[Appboy sharedInstance].user setCustomAttributeWithKey: andBOOLValue:]");
        } else if (strcmp([traitValue objCType], @encode(short)) == 0 ||
                   strcmp([traitValue objCType], @encode(int)) == 0 ||
                   strcmp([traitValue objCType], @encode(long)) == 0) {
          [[Appboy sharedInstance].user setCustomAttributeWithKey:key andIntegerValue:[(NSNumber *)traitValue integerValue]];
          SEGLog(@"[[Appboy sharedInstance].user setCustomAttributeWithKey: andIntegerValue:]");
        } else if (strcmp([traitValue objCType], @encode(float)) == 0 ||
                   strcmp([traitValue objCType], @encode(double)) == 0) {
          [[Appboy sharedInstance].user setCustomAttributeWithKey:key andDoubleValue:[(NSNumber *)traitValue doubleValue]];
          SEGLog(@"[[Appboy sharedInstance].user setCustomAttributeWithKey: andDoubleValue:]");
        } else {
          SEGLog(@"Could not map NSNumber value to Appboy custom attribute:%@]", traitValue);
        }
      } else if ([traitValue isKindOfClass:[NSArray class]]) {
        [[Appboy sharedInstance].user setCustomAttributeArrayWithKey:key array:traitValue];
        SEGLog(@"[[Appboy sharedInstance].user setCustomAttributeArrayWithKey: array:]");
      }
    }
  }

  [self.userTraits addEntriesFromDictionary:traits];
}

- (void)track:(SEGTrackPayload *)payload
{
  if ([payload.event isEqualToString:@"Install Attributed"]) {
    if ([payload.properties[@"campaign"] isKindOfClass:[NSDictionary class]]) {
      NSDictionary *attributionDataDictionary = (NSDictionary *)payload.properties[@"campaign"];
      ABKAttributionData *attributionData = [[ABKAttributionData alloc]
                                             initWithNetwork:attributionDataDictionary[@"source"]
                                                    campaign:attributionDataDictionary[@"name"]
                                                     adGroup:attributionDataDictionary[@"ad_group"]
                                                    creative:attributionDataDictionary[@"ad_creative"]];
      [[Appboy sharedInstance].user setAttributionData:attributionData];
      return;
    }
  }
  
  NSDecimalNumber *revenue = [SEGAppboyIntegration extractRevenue:payload.properties withKey:@"revenue"];
  if (revenue || [payload.event isEqualToString:@"Order Completed"]) {
    NSString *currency = @"USD";  // Make USD as the default currency.
    if ([payload.properties[@"currency"] isKindOfClass:[NSString class]] &&
        [(NSString *)payload.properties[@"currency"] length] == 3) {  // Currency should be an ISO 4217 currency code.
      currency = payload.properties[@"currency"];
    }
    
    if (payload.properties != nil) {
      NSMutableDictionary *appboyProperties = [NSMutableDictionary dictionaryWithDictionary:payload.properties];
      appboyProperties[@"currency"] = nil;
      appboyProperties[@"revenue"] = nil;
      
      if (appboyProperties[@"products"]) {
        NSArray *products = [appboyProperties[@"products"] copy];
        appboyProperties[@"products"] = nil;

        for (NSDictionary *product in products) {
          NSMutableDictionary *productDictionary = [product mutableCopy];
          NSString *productId = productDictionary[@"productId"];
          NSDecimalNumber *productRevenue = [SEGAppboyIntegration extractRevenue:productDictionary withKey:@"price"];
          NSUInteger productQuantity = [productDictionary[@"quantity"] unsignedIntegerValue];
          productDictionary[@"productId"] = nil;
          productDictionary[@"price"] = nil;
          productDictionary[@"quantity"] = nil;
          NSMutableDictionary *productProperties = [appboyProperties mutableCopy];
          [productProperties addEntriesFromDictionary:productDictionary];
          [[Appboy sharedInstance] logPurchase:productId inCurrency:currency atPrice:productRevenue withQuantity:productQuantity andProperties:productProperties];
        }
      } else {
        [[Appboy sharedInstance] logPurchase:payload.event inCurrency:currency atPrice:revenue withQuantity:1 andProperties:appboyProperties];
      }
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
    } else if ([revenueProperty isKindOfClass:[NSNumber class]]) {
      return [NSDecimalNumber decimalNumberWithDecimal:[revenueProperty decimalValue]];
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
  [[Appboy sharedInstance] registerDeviceToken:deviceToken];
  SEGLog(@"[[Appboy sharedInstance] registerDeviceToken:]");
}

- (void)applicationDidFinishLaunching:(NSNotification *)notification {
  dispatch_async(dispatch_get_main_queue(), ^{
    if (![[UIApplication sharedApplication].delegate respondsToSelector:@selector(application:didReceiveRemoteNotification:fetchCompletionHandler:)]) {
      [self logPushIfComesInBeforeAppboyInitializedWithIdentifier:nil];
    }
    [[SEGAppboyIntegrationFactory instance].appboyHelper applicationDidFinishLaunching];
  });
}

- (void)receivedRemoteNotification:(NSDictionary *)userInfo {
  if (![self logPushIfComesInBeforeAppboyInitializedWithIdentifier:nil]) {
    dispatch_async(dispatch_get_main_queue(), ^{
      [[Appboy sharedInstance] registerApplication:[UIApplication sharedApplication] didReceiveRemoteNotification:userInfo];
    });
  }
  SEGLog(@"[[Appboy sharedInstance] registerApplication: didReceiveRemoteNotification:]");
}

- (void)handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo {
  if (![self logPushIfComesInBeforeAppboyInitializedWithIdentifier:identifier]) {
    dispatch_async(dispatch_get_main_queue(), ^{
      [[Appboy sharedInstance] getActionWithIdentifier:identifier forRemoteNotification:userInfo completionHandler:nil];
    });
  }
  SEGLog(@"[[Appboy sharedInstance] getActionWithIdentifier: forRemoteNotification: completionHandler:]");
}

- (BOOL)logPushIfComesInBeforeAppboyInitializedWithIdentifier:(NSString *)identifier {
  NSDictionary *pushDictionary = [[SEGAppboyIntegrationFactory instance] getPushPayload];
  if (pushDictionary != nil && pushDictionary.count > 0) {
    // The existence of a push payload saved on the factory indicates that the push was received when
    // Appboy was not initialized yet, and thus the push was received in the inactive state.
    if ([[Appboy sharedInstance] respondsToSelector:@selector(handleRemotePushNotification:withIdentifier:completionHandler:applicationState:)]) {
      dispatch_async(dispatch_get_main_queue(), ^{
        [[Appboy sharedInstance] handleRemotePushNotification:pushDictionary
                                               withIdentifier:identifier
                                            completionHandler:nil
                                             applicationState:UIApplicationStateInactive];
      });
    }
    [[SEGAppboyIntegrationFactory instance] saveRemoteNotification:nil];
    return YES;
  }
  return NO;
}

- (void)reset {
  NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
  [userDefaults removeObjectForKey:UserDefaultsDomain];
  [self.userTraits removeAllObjects];
}

- (void)applicationWillResignActive {
  NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
  [userDefaults setObject:[self.userTraits sega_serializableDictionary] forKey:UserDefaultsDomain];
}

@end
