//
//  SearchViewController.m
//  EventApp
//
//  Created by iOS7 on 11/08/14.
//  Copyright (c) 2014 michael. All rights reserved.
//

#import "SearchViewController.h"
#import "MyPickerView.h"

@interface SearchViewController ()

@end

@implementation SearchViewController
@synthesize txtLocation, txtDate, txtArtist, searchView;

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
    self.navigationController.navigationItem.title = @"Search";
    
    txtDate.delegate = self;
    txtLocation.delegate = self;
    txtArtist.delegate = self;
    
    // Observe keyboard hide and show notifications to resize the text view appropriately.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
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
#pragma mark functions

- (NSString *)formatDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *formattedDate = [dateFormatter stringFromDate:date];
    return formattedDate;
}

#pragma mark-
#pragma mark Actions

- (IBAction)onPressSearch:(id)sender {
    [txtArtist resignFirstResponder];
    NSMutableString *strParameters = [[NSMutableString alloc] init];
    if(![txtArtist.text isEqualToString:@""])
        [strParameters appendFormat:@"&search_text=%@", txtArtist.text];
    if(![txtDate.text isEqualToString:@""])
       [strParameters appendFormat:@"&date_from=%@&date_to=%@", txtDate.text,txtDate.text];
    else
    {
        NSDate *currDate = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"YYYY-MM-dd"];
        NSString *datefrom = [dateFormatter stringFromDate:currDate];
        
        NSDate *newDate = [currDate dateByAddingTimeInterval:60*60*24*31*6]; //for half a year
        dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"YYYY-MM-dd"];
        NSString *dateto = [dateFormatter stringFromDate:newDate];
 
        
        [strParameters appendFormat:@"&date_from=%@&date_to=%@", datefrom,dateto];
    }
    if(![txtLocation.text isEqualToString:@""])
        //        [strParameters appendFormat:@"&search_location=%@", txtLocation.text];
        [strParameters appendString:[NSString stringWithFormat:@"&search_location=%@",[txtLocation text]]];//77"];
    
    //[self.parentVC setSearchParams:strParameters];
    [self.navigationController popToRootViewControllerAnimated:YES];
    [self.delegate doSearch:strParameters];
    }

- (IBAction)onPressHome:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark Keyboard Animation

- (void) showAnimation:(CGFloat)topValue
{
    CGRect newFrame = searchView.frame;
    int diff = txtDate.frame.origin.y + txtDate.frame.size.height - topValue;
    newFrame.size.height += diff;
    if(diff > 0)
    {
        newFrame.origin.y -= diff;
    }
    
    [self startAnimation:newFrame Duration:0.3];
}

- (void) hideAnimation
{
    CGRect newFrame = self.view.bounds;
//    newFrame.size.height -= bottomTabBar.bounds.size.height;
    [self startAnimation:newFrame Duration:0.3];
}

- (void)startAnimation:(CGRect)newFrame Duration:(NSTimeInterval)duration
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:duration];
    
    searchView.frame = newFrame;
    [UIView commitAnimations];
    
}

#pragma mark-
#pragma mark MyDatePickerDelegate

- (void)DatePickerValueChanged:(UIDatePicker *)datePicker
{
    txtDate.text = [self formatDate:datePicker.date];
}

- (void)HideDatePickerView:(UIDatePicker *)datePicker
{
    [self hideAnimation];
}


#pragma mark-
#pragma mark TextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    /*
    if(textField == txtLocation)
    {
        [txtLocation resignFirstResponder];
     
        NSArray *stringsArray = @[@"Location1", @"Location2", @"Location3", @"Location4", @"Location5", @"Location6", @"Location7", @"Location8", @"Location9", @"Location10"];
        NSString *selectedString = [stringsArray objectAtIndex:3];
        if(![txtLocation.text isEqualToString:@""])
            selectedString = txtLocation.text;
        
        [MyPickerView showPickerViewInView:self.view
                               withStrings:stringsArray
                               withOptions:@{MMbackgroundColor: [UIColor whiteColor],
                                             MMtextColor: [UIColor blackColor],
                                             MMtoolbarColor: [UIColor whiteColor],
                                             MMbuttonColor: [UIColor blueColor],
                                             MMfont: [UIFont systemFontOfSize:18],
                                             MMvalueY: @3,
                                             MMselectedObject:selectedString,
                                             MMtextAlignment:@1}
                                completion:^(NSString *selectedString) {
                                    txtLocation.text = selectedString;
                                }];
        
    }
     */
    
    if(textField == txtDate)
    {
        // Create a date picker for the date field.
        if(myDatePicker == nil)
        {
            myDatePicker = [[MyDatePicker alloc] initWithFrame:self.view.bounds];
            myDatePicker.delegate = self;
            [self.view addSubview:myDatePicker];
        }
        [txtDate resignFirstResponder];
        //        [myDatePicker setHidden:NO];
        [myDatePicker showMyDatePicker];
        [self showAnimation:myDatePicker.pickerContainerView.frame.origin.y];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return true;
}

#pragma mark -
#pragma mark Responding to keyboard events

- (void)keyboardWillShow:(NSNotification *)notification {
    
    /*
     Reduce the size of the text view so that it's not obscured by the keyboard.
     Animate the resize so that it's in sync with the appearance of the keyboard.
     */
    NSDictionary *userInfo = [notification userInfo];
    // Get the origin of the keyboard when it's displayed.
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    // Get the top of the keyboard as the y coordinate of its origin in self's view's coordinate system. The bottom of the text view's frame should align with the top of the keyboard's final position.
    CGRect keyboardRect = [aValue CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    
    CGFloat keyboardTop = keyboardRect.origin.y;
    CGRect newFrame = searchView.frame;
    int diff = txtArtist.frame.origin.y + txtArtist.frame.size.height - keyboardTop;
    if(diff > 0)
    {
        newFrame.origin.y -= diff;
    }
    // Get the duration of the animation.
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    [self startAnimation:newFrame Duration:animationDuration];
}


- (void)keyboardWillHide:(NSNotification *)notification {
    
    NSDictionary* userInfo = [notification userInfo];
    /*
     Restore the size of the text view (fill self's view).
     Animate the resize so that it's in sync with the disappearance of the keyboard.
     */
    CGRect newFrame = self.view.bounds;
//    newFrame.size.height -= bottomTabBar.bounds.size.height;
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    [self startAnimation:newFrame Duration:animationDuration];
}
@end
