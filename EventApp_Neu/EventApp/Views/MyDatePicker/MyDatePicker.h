//
//  MyDatePicker.h
//  EventApp
//
//  Created by iOS7 on 31/07/14.
//  Copyright (c) 2014 michael. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyDatePickerDelegate <NSObject>
- (void)DatePickerValueChanged:(UIDatePicker *)datePicker;
- (void)HideDatePickerView:(UIDatePicker *)datePicker;
@end

@interface MyDatePicker : UIView
{
    UIDatePicker *datePicker;
}
@property (nonatomic, strong) id<MyDatePickerDelegate> delegate;
@property (nonatomic, strong) UIView *pickerContainerView;
@property (nonatomic, strong) UIView *topBarView;
@property (nonatomic, strong) UIButton *btnDone;

@property (nonatomic, strong) UIButton *btnCancel;


- (void)showMyDatePicker;
@end
