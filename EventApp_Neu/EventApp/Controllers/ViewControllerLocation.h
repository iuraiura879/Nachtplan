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
#import "LGRefreshView.h"

@interface ViewControllerLocation : UIViewController<UITabBarDelegate, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, CLLocationManagerDelegate,SearchViewControllerDelegate,MyDatePickerDelegate,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate,LGRefreshViewDelegate>
{
    MyDatePicker *myDatePicker;
    CLLocationManager *locationManager;
    
    UIView* oldFooterView;
    
    LGRefreshView *refreshView;
    
}


@property (weak, nonatomic) IBOutlet UITableView *tblEvents;

@property (strong, nonatomic) NSString *searchParams;

@property ( nonatomic) int curEventType;



//Public
- (void) SearchByMultiParams;
@end
