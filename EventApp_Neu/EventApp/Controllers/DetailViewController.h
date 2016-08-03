//
//  DetailViewController.h
//  EventApp
//
//  Created by iOS7 on 31/07/14.
//  Copyright (c) 2014 michael. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController<UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *detailWebView;
@property (nonatomic, retain) NSString *eventID;
@property (nonatomic, retain) NSString *eventDate;
@property (nonatomic, retain) NSString *locationURL;
@end
