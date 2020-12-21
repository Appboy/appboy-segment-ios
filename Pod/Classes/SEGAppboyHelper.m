#import "SEGAppboyHelper.h"
#import "SEGAppboyIntegration.h"
#if defined(__has_include) && __has_include(<Appboy_iOS_SDK/AppboyKit.h>)
#import <Appboy_iOS_SDK/AppboyKit.h>
#elif SWIFT_PACKAGE
#import "AppboyKit.h"
#else
#import "Appboy-iOS-SDK/AppboyKit.h"
#endif

@interface SEGAppboyHelper ()

@property UNUserNotificationCenter *center NS_AVAILABLE_IOS(10_0);
@property UNNotificationResponse *response NS_AVAILABLE_IOS(10_0);

@end

@implementation SEGAppboyHelper

- (void)applicationDidFinishLaunching NS_AVAILABLE_IOS(10_0) {
  [self logUNPushIfComesInBeforeAppboyInitialized];
}

- (void)saveUserNotificationCenter:(UNUserNotificationCenter *)center
              notificationResponse:(UNNotificationResponse *)response {
  self.center = center;
  self.response = response;
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center
  receivedNotificationResponse:(UNNotificationResponse *)response {
  if (![self logUNPushIfComesInBeforeAppboyInitialized]) {
    dispatch_async(dispatch_get_main_queue(), ^{
      [[Appboy sharedInstance] userNotificationCenter:center
                       didReceiveNotificationResponse:response
                                withCompletionHandler:nil];
    });
  }
}

- (BOOL)logUNPushIfComesInBeforeAppboyInitialized NS_AVAILABLE_IOS(10_0) {
  if (self.center != nil && self.response != nil) {
    // The existence of a saved notification response indicates that the push was received when
    // Appboy was not initialized yet, and thus the push was received in the inactive state.
    if ([[Appboy sharedInstance] respondsToSelector:@selector(userNotificationCenter:didReceiveNotificationResponse:withCompletionHandler:)]) {
      [[Appboy sharedInstance] userNotificationCenter:self.center
                       didReceiveNotificationResponse:self.response
                                withCompletionHandler:nil];
      [self saveUserNotificationCenter:nil notificationResponse:nil];
      return YES;
    }
  }
  return NO;
}

@end
