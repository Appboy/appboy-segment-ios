#import "SEGViewController.h"
#import "SEGAnalytics.h"
#import "AppboyKit.h"
#import "ABKNewsFeedViewController.h"
#import "ABKContentCardsViewController.h"

@interface SEGViewController ()

@end

@implementation SEGViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self contentCardsUpdated:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(contentCardsUpdated:)
                                               name:ABKContentCardsProcessedNotification
                                             object:nil];
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
                                              //@"dateAttribute" : dateAttribute,
                                              @"arrayAttribute" : @[@"one", @"two", @"three"],
                                              @"gender" : @"female",
                                              //@"birthday" : [NSDate dateWithTimeIntervalSince1970:564559200],
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
  [[SEGAnalytics sharedAnalytics] track:@"Order Completed"
                             properties:@{@"currency": @"CNY",
                                          @"revenue" : numberRevenue,
                                          @"products" : @[@{@"productId" : @"cookies",
                                                            @"price" : @"72.3",
                                                            @"quantity" : @(29),
                                                            @"cookieType" : @"chocolateChip"
                                                        },
                                                        @{@"productId" : @"muffins",
                                                          @"price" : @"24.2",
                                                          @"quantity" : @(17),
                                                          @"muffinType" : @"blueberry"
                                                        }],
                                          @"purchaseType" : @"productsArray"
                             }];
  [[SEGAnalytics sharedAnalytics] track:@"Order Completed"
                             properties:@{@"currency" : @"USD",
                                          @"products" : @[@{@"productId" : @"phone",
                                                            @"price" : @"199.99",
                                                            @"quantity" : @(2),
                                                            @"phoneType" : @"iPhoneX"},
                                                          @{@"productId" : @"tablet",
                                                            @"price" : @"149.99",
                                                            @"quantity" : @(3),
                                                            @"tabletType" : @"iPad"}],
                                          @"store" : @"appleStore"}];
  [[SEGAnalytics sharedAnalytics] track:@"Install Attributed"
                             properties: @{@"provider" : @"Tune/Kochava/Branch",
                                           @"campaign" : @{@"source" : @"Network/FB/AdWords/MoPub/Source",
                                                             @"name" : @"Campaign Name",
                                                          @"content" : @"Organic Content Title",
                                                      @"ad_creative" : @"Red Hello World Ad",
                                                         @"ad_group" : @"Red Ones"}}];
}

- (IBAction)feedButtonPress:(id)sender {
  if ([Appboy sharedInstance] != nil) {
    // gate Appboy functionality based on [Appboy sharedInstance].
    ABKNewsFeedViewController *newsFeed = [[ABKNewsFeedViewController alloc] init];
    [self presentViewController:newsFeed animated:YES completion:nil];
  }
}

- (IBAction)contentCardsButtonPress:(id)sender {
  if ([Appboy sharedInstance] != nil) {
    if (self.modalOrNavigationControl.selectedSegmentIndex == 0) {
      ABKContentCardsViewController *contentCardsVC = [ABKContentCardsViewController new];
      contentCardsVC.contentCardsViewController.navigationItem.title = @"Modal Cards";
      [self.navigationController presentViewController:contentCardsVC animated:YES completion:nil];
    } else {
      ABKContentCardsTableViewController *contentCards = [ABKContentCardsTableViewController getNavigationContentCardsViewController];
      contentCards.navigationItem.title = @"Navigation Cards";
      [self.navigationController pushViewController:contentCards animated:YES];
    }
  }
}

- (void)contentCardsUpdated:(NSNotification *)notification {
  if ([Appboy sharedInstance] != nil) {
    self.unreadContentCardsLabel.text = [NSString stringWithFormat:@"Unread Content Cards: %ld / %ld",
                                          (long)[Appboy sharedInstance].contentCardsController.unviewedContentCardCount,
                                          (long)[Appboy sharedInstance].contentCardsController.contentCardCount];
    [self.view setNeedsDisplay];
  } else {
    self.unreadContentCardsLabel.text = [NSString stringWithFormat:@"Unread Content Cards: 0 / 0"];
  }
}

@end
