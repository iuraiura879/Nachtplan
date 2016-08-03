//
//  DetailViewController.h
//  EventApp
//
//  Created by iOS7 on 31/07/14.
//  Copyright (c) 2014 michael. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdViewController : UIViewController<UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *adImageView;
@property (strong, nonatomic) IBOutlet UIButton *exitButton;

- (IBAction)exitPressed:(id)sender;

@end
