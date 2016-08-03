//
//  ImpressumViewController.h
//  EventApp
//
//  Created by iOS7 on 02/08/14.
//  Copyright (c) 2014 michael. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImpressumViewController : UIViewController

//Outlets
@property (strong, nonatomic) IBOutlet UIBarButtonItem *homeButtonItem;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *backButtonItem;

//Actions
- (IBAction)onPressHomeButtonItem:(id)sender;
- (IBAction)onPressBackButtonItem:(id)sender;
@end
