//
//  MoreViewController.m
//  EventApp
//
//  Created by iOS7 on 31/07/14.
//  Copyright (c) 2014 michael. All rights reserved.
//

#import "MoreViewController.h"
#import "HttpApi.h"

@interface MoreViewController ()

@end

@implementation MoreViewController
@synthesize backButtonItem, homeButtonItem;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tabBarController.navigationController.navigationItem.title = @"Settings";
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark-
#pragma mark Actions

- (IBAction)onPressFeedback:(id)sender {
    
    if (![MFMailComposeViewController canSendMail])
        return;
    // Email Subject
    NSString *emailTitle = @"Test Email";
    // Email Content
    NSString *messageBody = @"NachtPlan!";
    // To address
//    NSArray *toRecipents = [NSArray arrayWithObject:@"michael.antos1223@outlook.com"];
    NSArray *toRecipents = [NSArray arrayWithObject:FeedBack_Address];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipents];
    
//    UIImage *image = [UIImage imageNamed:@"events_selected.png"];
//    NSData *myData = UIImageJPEGRepresentation(image, 1.0);
//    [mc addAttachmentData:myData mimeType:@"image/png"  fileName:@"attach"];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)onPressFacebook:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:FaceBook_Address]];
}

- (IBAction)onPressTwitter:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:Twitter_Address]];
}

- (IBAction)onPressBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onPressHome:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
