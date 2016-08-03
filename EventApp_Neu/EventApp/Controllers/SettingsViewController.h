//
//  SettingsViewController.h
//  EventApp
//
//  Created by iOS7 on 02/08/14.
//  Copyright (c) 2014 michael. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController
//Outlets
@property (strong, nonatomic) IBOutlet UISwitch *spinOrt;
@property (strong, nonatomic) IBOutlet UISwitch *spinPush;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *homeButtonItem;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *backButtonItem;

@property (strong, nonatomic) IBOutlet UISlider * distanceSlider;
@property (strong, nonatomic) IBOutlet UILabel * distanceLable;



//Actions
- (IBAction)onPressHome:(id)sender;
- (IBAction)onOrtValueChanged:(id)sender;
- (IBAction)onPushValueChanged:(id)sender;
- (IBAction)onPressBack:(id)sender;

- (IBAction)slide;


@end
