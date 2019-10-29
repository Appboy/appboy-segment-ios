@import UIKit;

@interface SEGViewController : UIViewController

@property IBOutlet UITextField *userIDTextField;
@property IBOutlet UITextField *customEventTextField;
@property IBOutlet UITextField *propertyKeyTextField;
@property IBOutlet UITextField *propertyValueTextField;

- (IBAction)identifyButtonPress:(id)sender;
- (IBAction)flushButtonPress:(id)sender;
- (IBAction)trackButtonPress:(id)sender;
- (IBAction)feedButtonPress:(id)sender;

@end
