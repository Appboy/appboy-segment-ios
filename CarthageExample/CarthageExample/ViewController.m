#import <Analytics/Analytics.h>
#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userIdTextField;
@property (weak, nonatomic) IBOutlet UITextField *customEventTextField;
@property (weak, nonatomic) IBOutlet UITextField *propertyKeyTextField;
@property (weak, nonatomic) IBOutlet UITextField *propertyValueTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
}

- (IBAction)identifyButtonPressed:(id)sender {
  [[SEGAnalytics sharedAnalytics] identify:self.userIdTextField.text];
}

- (IBAction)trackButtonPressed:(id)sender {
  [[SEGAnalytics sharedAnalytics] track:self.customEventTextField.text
                             properties:@{self.propertyKeyTextField.text: self.propertyValueTextField.text}];
}

- (IBAction)flushButtonPressed:(id)sender {
  [[SEGAnalytics sharedAnalytics] flush];
}

@end
