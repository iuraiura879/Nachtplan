//
//  TabBarController.m
//  EventApp
//
//  Created by Iura Gutu on 02/08/16.
//  Copyright © 2016 michael. All rights reserved.
//
#import "TabBarController.h"
#import <Foundation/Foundation.h>


@interface TabBarController ()

@end

@implementation TabBarController

-(void) viewDidLoad{
    [super viewDidLoad];
    
    self.delegate = self;
    
    firstView = [[self viewControllers] objectAtIndex:0];
    locationView = [[self viewControllers] objectAtIndex:1];
    searchView = [[self viewControllers] objectAtIndex:2];
    searchView.delegate = self;
}

-(void) tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    NSUInteger indexOfTab = [tabBarController.viewControllers indexOfObject:viewController];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if( indexOfTab != 0 ){
            
            self.navigationItem.rightBarButtonItem = nil;
            
        }
        else{
            
            self.navigationItem.rightBarButtonItem = dateButton;
        }
        
    });
   
  
}


    

- (IBAction)onDatePressed:(id)sender {
    [firstView onPressDateButtonItem:sender];
}

- (void) doSearch:(NSString*)searchUrl{
    
    [self setSelectedIndex:1];
    [locationView doSearch:searchUrl];
}
@end