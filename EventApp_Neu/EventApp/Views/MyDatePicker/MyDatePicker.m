//
//  MyDatePicker.m
//  EventApp
//
//  Created by iOS7 on 31/07/14.
//  Copyright (c) 2014 michael. All rights reserved.
//

#import "MyDatePicker.h"

@implementation MyDatePicker
@synthesize pickerContainerView, topBarView, btnDone,btnCancel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor colorWithRed:0.412 green:0.412 blue:0.412 alpha:0.7]];
        // Initialization code
        pickerContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 250, self.frame.size.width, 250)];
        [pickerContainerView setBackgroundColor:[UIColor whiteColor]];
        topBarView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, pickerContainerView.bounds.size.width, 50)];
        [topBarView setBackgroundColor:[UIColor colorWithWhite:0.8 alpha:0.3]];
        
        
        
        btnDone = [[UIButton alloc] initWithFrame:CGRectMake(topBarView.bounds.size.width - 80, 5, 60, 40)];
        [btnDone setTitle:@"Done" forState:UIControlStateNormal];
        [btnDone setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [btnDone setTitleColor:[UIColor colorWithRed:0 green:0 blue:1 alpha:0.3] forState:UIControlStateHighlighted];
        [btnDone addTarget:self action:@selector(hideMyDatePicekr:) forControlEvents:UIControlEventTouchUpInside];
        [topBarView addSubview:btnDone];
        
        
        
        
        btnCancel= [[UIButton alloc] initWithFrame:CGRectMake(23, 5, 60, 40)];
        [btnCancel setTitle:@"Cancel" forState:UIControlStateNormal];
        [btnCancel setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [btnCancel setTitleColor:[UIColor colorWithRed:0 green:0 blue:1 alpha:0.3] forState:UIControlStateHighlighted];
        [btnCancel addTarget:self action:@selector(CancelMyDatePicekr:) forControlEvents:UIControlEventTouchUpInside];
        [topBarView addSubview:btnCancel];
        
        
        
        
        
        [pickerContainerView addSubview:topBarView];
        
        
        datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 50, pickerContainerView.frame.size.width, 200)];
        datePicker.datePickerMode = UIDatePickerModeDate;
//        datePicker.minimumDate = [NSDate dateWithTimeIntervalSinceNow:-31536000];
        datePicker.minimumDate = [NSDate dateWithTimeIntervalSince1970:0];
        [datePicker setDate:[NSDate date]];
        [datePicker addTarget:self action:@selector(updateDateField:) forControlEvents:UIControlEventValueChanged];
        [pickerContainerView addSubview:datePicker];
        
        [self addSubview:pickerContainerView];
    }
    return self;
}

- (void)showMyDatePicker
{
    self.hidden = NO;
    [pickerContainerView setFrame:CGRectMake(0, self.bounds.size.height, pickerContainerView.frame.size.width, pickerContainerView.frame.size.height)];
    
    [UIView animateWithDuration:0.3 animations:^{
        [pickerContainerView setFrame:CGRectMake(0, self.frame.size.height - 250, self.frame.size.width, 250)];
        
    }];
}

- (void)hideMyDatePicekr:(id)sender
{
    [self updateDateField:datePicker];
    [self.delegate HideDatePickerView:datePicker];
    [UIView animateWithDuration:0.3 animations:^{
        [pickerContainerView setFrame:CGRectMake(0, self.bounds.size.height, pickerContainerView.frame.size.width, pickerContainerView.frame.size.height)];
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}


- (void)CancelMyDatePicekr:(id)sender
{
    //[self updateDateField:datePicker];
    [self.delegate HideDatePickerView:datePicker];
    [UIView animateWithDuration:0.3 animations:^{
        [pickerContainerView setFrame:CGRectMake(0, self.bounds.size.height, pickerContainerView.frame.size.width, pickerContainerView.frame.size.height)];
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}


- (void)updateDateField:(id)sender
{
    [self.delegate DatePickerValueChanged:sender];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
