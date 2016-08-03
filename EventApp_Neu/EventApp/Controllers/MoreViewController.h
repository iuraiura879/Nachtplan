//
//  MoreViewController.h
//  EventApp
//
//  Created by iOS7 on 31/07/14.
//  Copyright (c) 2014 michael. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
@interface MoreViewController : UIViewController<MFMailComposeViewControllerDelegate>
//Outlets
@property (strong, nonatomic) IBOutlet UIButton *btnFeedback;
@property (strong, nonatomic) IBOutlet UIButton *btnFacebook;
@property (strong, nonatomic) IBOutlet UIButton *btnTwitter;
@property (strong, nonatomic) IBOutlet UIButton *btnImpressum;
@property (strong, nonatomic) IBOutlet UIButton *btnInstellungen;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *backButtonItem;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *homeButtonItem;


//Actions
- (IBAction)onPressFeedback:(id)sender;
- (IBAction)onPressFacebook:(id)sender;
- (IBAction)onPressTwitter:(id)sender;

- (IBAction)onPressBack:(id)sender;
- (IBAction)onPressHome:(id)sender;

@end
