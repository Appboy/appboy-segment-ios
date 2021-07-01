#import "ViewController.h"
#import "SEGAnalytics.h"
#import <AppboyTVOSKit/AppboyKit.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *customEvent = @"appboySegmentTrackEvent";

    NSString *propertyKey = @"eventPropertyKey";

    NSString *propertyValue = @"eventPropertyValue";

    [[SEGAnalytics sharedAnalytics] track:customEvent
                                 properties:@{ propertyKey: propertyValue}];
}

@end
