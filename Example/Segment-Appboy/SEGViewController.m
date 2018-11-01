#import "SEGViewController.h"
#import "SEGAnalytics.h"
#import "AppboyKit.h"
#import "ABKModalFeedbackViewController.h"
#import "ABKNewsFeedViewController.h"

@interface SEGViewController ()

@end

@implementation SEGViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

- (IBAction)identifyButtonPress:(id)sender {
  NSInteger integerAttribute = 200;
  float floatAttribute = 12.3f;
  int intAttribute = 18;
  short shortAttribute = (short)2;
  NSDate *dateAttribute = [NSDate date];
  
  NSString *userID = @"appboySegmentTestUseriOS";
  if (self.userIDTextField.text.length > 0) {
    userID = self.userIDTextField.text;
  }
  [[SEGAnalytics sharedAnalytics] identify:userID
                                    traits:@{ @"email": @"hello@appboy.com",
                                              @"bool" : @(YES),
                                              @"double" : @(3.14159),
                                              @"intAttribute": @(intAttribute),
                                              @"integerAttribute" : @(integerAttribute),
                                              @"floatAttribute" : @(floatAttribute),
                                              @"shortAttribute" : @(shortAttribute),
                                              @"dateAttribute" : dateAttribute,
                                              @"arrayAttribute" : @[@"one", @"two", @"three"],
                                              @"gender" : @"female",
                                              @"birthday" : [NSDate dateWithTimeIntervalSince1970:564559200],
                                              @"firstName" : @"Appboy",
                                              @"lastName" : @"Appboy",
                                              @"phone" : @"1234567890",
                                              @"address" : @{@"city" : @"New York",
                                                             @"country" : @"US"}}];
}

- (IBAction)flushButtonPress:(id)sender {
  [[SEGAnalytics sharedAnalytics] flush];
}

- (IBAction)trackButtonPress:(id)sender {
  NSString *customEvent = @"appboySegmentTrackEvent";
  if (self.customEventTextField.text.length > 0) {
    customEvent = self.customEventTextField.text;
  }
  NSString *propertyKey = @"eventPropertyKey";
  if (self.propertyKeyTextField.text.length > 0) {
    propertyKey = self.propertyKeyTextField.text;
  }
  NSString *propertyValue = @"eventPropertyValue";
  if (self.propertyValueTextField.text.length > 0) {
    propertyValue = self.propertyValueTextField.text;
  }
  
  [[SEGAnalytics sharedAnalytics] track:customEvent
                             properties:@{ propertyKey: propertyValue}];
  NSNumber *numberRevenue = @(45);
  NSString *stringRevenue = @"60";
  [[SEGAnalytics sharedAnalytics] track:@"Candy"
                             properties:@{ @"currency": @"CNY", @"revenue" : numberRevenue, @"property" : @"milky white rabbit"}];
  [[SEGAnalytics sharedAnalytics] track:@"Purchase"
                             properties:@{ @"currency": @"CNY", @"revenue" : stringRevenue, @"property" : @"myProperty"}];
  [[SEGAnalytics sharedAnalytics] track:@"Install Attributed"
                             properties: @{@"provider" : @"Tune/Kochava/Branch",
                                           @"campaign" : @{@"source" : @"Network/FB/AdWords/MoPub/Source",
                                                             @"name" : @"Campaign Name",
                                                          @"content" : @"Organic Content Title",
                                                      @"ad_creative" : @"Red Hello World Ad",
                                                         @"ad_group" : @"Red Ones"}}];
}

- (IBAction)feedbackButtonPress:(id)sender {
  // gate Appboy functionality based on [Appboy sharedInstance].
  if ([Appboy sharedInstance] != nil) {
    ABKModalFeedbackViewController *feedbackViewController = [[ABKModalFeedbackViewController alloc] init];
    [self presentViewController:feedbackViewController animated:YES completion:nil];
  }
}

- (IBAction)feedButtonPress:(id)sender {
  if ([Appboy sharedInstance] != nil) {
    // gate Appboy functionality based on [Appboy sharedInstance].
    ABKNewsFeedViewController *newsFeed = [[ABKNewsFeedViewController alloc] init];
    [self.navigationController presentViewController:newsFeed animated:YES completion:nil];
  }
}
@end
