//
//  UITabBarController_TabBarController.h
//  EventApp
//
//  Created by Iura Gutu on 02/08/16.
//  Copyright © 2016 michael. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "ViewControllerLocation.h"
#import "SearchViewController.h"
@interface TabBarController : UITabBarController<UITabBarControllerDelegate,SearchViewControllerDelegate>{
    
    
    IBOutlet UIBarButtonItem *dateButton;
    
    ViewController* firstView;
    ViewControllerLocation* locationView;
    SearchViewController* searchView;
}
- (IBAction)onDatePressed:(id)sender;

@end
