//
//  ViewController.h
//  EventApp
//
//  Created by iOS7 on 29/07/14.
//  Copyright (c) 2014 michael. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyDatePicker.h"
#import "SearchViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "UIScrollView+EmptyDataSet.h"

@interface ViewController : UIViewController<UITabBarDelegate, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, CLLocationManagerDelegate,SearchViewControllerDelegate,MyDatePickerDelegate,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
{
    MyDatePicker *myDatePicker;
    CLLocationManager *locationManager;
    
    UIView* oldFooterView;
}
//Outlets
@property (weak, nonatomic) IBOutlet UITabBarItem *eventsNavItem;
@property (weak, nonatomic) IBOutlet UITabBarItem *locationNavItem;
@property (weak, nonatomic) IBOutlet UITabBarItem *searchNavItem;
@property (weak, nonatomic) IBOutlet UITabBarItem *moreNavItem;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnDateItem;

@property (strong, nonatomic) IBOutlet UISegmentedControl *topSegmentedControl;

@property (weak, nonatomic) IBOutlet UITabBar *bottomTabBar;

@property (weak, nonatomic) IBOutlet UITableView *tblEvents;

@property (strong, nonatomic) NSString *searchParams;

@property ( nonatomic) int curEventType;


//Actions
- (IBAction)onPressDateButtonItem:(id)sender;
- (IBAction)onTopBarValueChanged:(id)sender;

//Public
- (void) SearchByMultiParams;
@end
