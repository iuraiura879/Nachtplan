//
//  DetailViewController.m
//  EventApp
//
//  Created by iOS7 on 31/07/14.
//  Copyright (c) 2014 michael. All rights reserved.
//

#import "DetailViewController.h"
#import "HttpApi.h"
#import "LoadingView.h"

@interface DetailViewController ()

@end

@implementation DetailViewController
@synthesize detailWebView, eventID,locationURL,eventDate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    detailWebView.dataDetectorTypes = UIDataDetectorTypeNone;
    [super viewWillAppear:animated];
    if(locationURL!=nil){
        NSLog( @" %@ ", locationURL);
        NSURL *url = [NSURL URLWithString:locationURL];
        [detailWebView loadRequest:[NSURLRequest requestWithURL:url]];
        
    }
    else{
        
        [[LoadingView sharedView] show:self.navigationController.view MessageText:@"Loading..."];
        NSString *detailAddress = [NSString stringWithFormat:@"%@%@%@%@%@", EventDetail_Address, eventID, @"&use_date=",eventDate, LogInData];
        NSURL *url = [NSURL URLWithString:detailAddress];
        [detailWebView loadRequest:[NSURLRequest requestWithURL:url]];
        
        
        
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    detailWebView.delegate = self;
}

#pragma mark-
#pragma mark WebViewDelegate

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
//    if(navigationType == UIWebViewNavigationTypeLinkClicked)
//    {
//        [webView loadRequest:request];
//        return true;
//    }
    return true;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [[LoadingView sharedView] hide];
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

@end
