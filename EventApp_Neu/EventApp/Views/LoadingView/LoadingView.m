//
//  LoadingView.m
//  EventApp
//
//  Created by iOS7 on 02/08/14.
//  Copyright (c) 2014 michael. All rights reserved.
//

#import "LoadingView.h"

static const CGFloat LABEL_WIDTH = 200;
static const CGFloat LABEL_HEIGHT = 50;
static const CGFloat LABEL_VERTICAL_OFFSET = 30;

static const CGFloat TRANSPARENCY = 0.5f;

static NSString *LABEL_TEXT = @"Please wait...";

@interface LoadingView()
{
    UIActivityIndicatorView *aiv;
    UILabel * label;
}

-(void)configureLabel;
-(void)configureSpinner;
-(void)removeOverlay;

@end

@implementation LoadingView

static LoadingView *loadingView;

+ (LoadingView*) sharedView
{
    if(loadingView == nil)
    {
        loadingView = [[LoadingView alloc] init];
    }
    return loadingView;
}

- (void)show:(UIView*)parentView MessageText:(NSString*)strMsg
{
    UIWindow *window = parentView.window;
    
    [self setFrame:window.bounds];
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:TRANSPARENCY];
    self.userInteractionEnabled = YES;

    LABEL_TEXT = strMsg;
    [loadingView configureSpinner];
    [loadingView configureLabel];
    
    [window addSubview:self];
}

//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [self removeOverlay];
//}

-(void)hide
{
    [self removeOverlay];
}

-(void)removeOverlay
{
    [self removeFromSuperview];
}


-(CGRect)centerFrame:(CGRect)frame inParent:(CGRect)parentFrame
{
    frame.origin.x = parentFrame.size.width / 2 - frame.size.width / 2;
    frame.origin.y = parentFrame.size.height / 2 - frame.size.height / 2;
    return frame;
}

-(void)configureLabel
{
    if(label == nil)
    {
        CGRect labelFrame = CGRectMake(0, 0, LABEL_WIDTH, LABEL_HEIGHT);
        label = [[UILabel alloc] initWithFrame:labelFrame];
        [self addSubview:label];
    }
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.text = LABEL_TEXT;
    
    label.frame = [self centerFrame:label.frame inParent:self.frame];
    
    CGRect frame = label.frame;
    frame.origin.y += LABEL_VERTICAL_OFFSET;
    label.frame = frame;
}

-(void)configureSpinner
{
    if(aiv == nil)
    {
        aiv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        
        [aiv startAnimating];
        [self addSubview:aiv];
    }
    aiv.frame = [self centerFrame:aiv.frame inParent:self.frame];
}

@end
