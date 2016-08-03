//
//  SearchViewController.h
//  EventApp
//
//  Created by iOS7 on 11/08/14.
//  Copyright (c) 2014 michael. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyDatePicker.h"
//#import "ViewController.h"



@protocol SearchViewControllerDelegate <NSObject>
- (void) doSearch:(NSString*)searchUrl;
@end

@interface SearchViewController : UIViewController<MyDatePickerDelegate, UITextFieldDelegate>
{
    MyDatePicker *myDatePicker;
}
@property (retain, nonatomic) UIViewController *parentVC;
//Outlets
@property (strong, nonatomic) IBOutlet UIBarButtonItem *homeButtonItem;
@property (weak, nonatomic) IBOutlet UITextField *txtDate;
@property (weak, nonatomic) IBOutlet UITextField *txtLocation;
@property (weak, nonatomic) IBOutlet UITextField *txtArtist;
@property (strong, nonatomic) IBOutlet UIButton *btnSearch;
@property (weak, nonatomic) IBOutlet UIView *searchView;

@property (nonatomic, strong) id<SearchViewControllerDelegate> delegate;
//Actions
- (IBAction)onPressHome:(id)sender;
- (IBAction)onPressSearch:(id)sender;
@end
