//
//  LoadingView.h
//  EventApp
//
//  Created by iOS7 on 02/08/14.
//  Copyright (c) 2014 michael. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingView : UIView

+ (LoadingView*)sharedView;
- (void)hide;
- (void)show:(UIView*)parentView MessageText:(NSString*)strMsg;

@end
