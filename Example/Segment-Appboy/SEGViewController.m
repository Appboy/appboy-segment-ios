#import "SEGViewController.h"
#import "SEGAnalytics.h"
#import "AppboyKit.h"

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
  [[SEGAnalytics sharedAnalytics] identify:@"appboySegementTestUseriOS"
                                    traits:@{ @"email": @"hello@appboy.com",
                                              @"bool" : @(YES),
                                              @"double" : @(3.14159),
                                              @"intAttribute": @(intAttribute),
                                              @"integerAttribute" : @(integerAttribute),
                                              @"floatAttribute" : @(floatAttribute),
                                              @"shortAttribute" : @(shortAttribute),
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
  [[SEGAnalytics sharedAnalytics] track:@"appboySegmentTrackEvent"
                             properties:@{ @"eventproperty": @"eventPropertyValue"}];
  [[SEGAnalytics sharedAnalytics] track:@"Candy"
                             properties:@{ @"currency": @"CNY", @"revenue" : @"60", @"property" : @"milky white rabbit"}];
}

- (IBAction)feedbackButtonPress:(id)sender {
  // gate Appboy functionality based on [Appboy sharedInstance].
  if ([Appboy sharedInstance] != nil) {
    ABKFeedbackViewControllerModalContext *feedbackViewController = [[ABKFeedbackViewControllerModalContext alloc] init];
    [self presentViewController:feedbackViewController animated:YES completion:nil];
  }
}

- (IBAction)feedButtonPress:(id)sender {
  if ([Appboy sharedInstance] != nil) {
    // gate Appboy functionality based on [Appboy sharedInstance].
    ABKFeedViewControllerModalContext *feedModal = [[ABKFeedViewControllerModalContext alloc] init];
    feedModal.navigationItem.title = @"Modal Context";
    [self presentViewController:feedModal animated:YES completion:nil];
  }
}
@end
