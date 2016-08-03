//
//  SettingsViewController.m
//  EventApp
//
//  Created by iOS7 on 02/08/14.
//  Copyright (c) 2014 michael. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
{

}

@end

@implementation SettingsViewController
@synthesize homeButtonItem, spinOrt, spinPush, distanceSlider, distanceLable  ;

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
    
    
    NSUserDefaults* preferences = [NSUserDefaults standardUserDefaults];
    
    
    NSString* currentLevelKey = @"LocationAlowed";
    if([preferences objectForKey:currentLevelKey] != nil)
        [spinOrt setOn:[preferences boolForKey:currentLevelKey]];
    
    
    currentLevelKey = @"LocationRadius";
    if([preferences objectForKey:currentLevelKey] != nil){
        
        distanceSlider.value=[preferences integerForKey:currentLevelKey];
        self.distanceLable.text = [NSString stringWithFormat:@"%i km" , [preferences integerForKey:currentLevelKey] ];

    }
    
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

- (IBAction)onPressHome:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)onOrtValueChanged:(id)sender {
    
    
    [[NSUserDefaults standardUserDefaults] setBool:[spinOrt isOn] forKey:@"LocationAlowed"];
}

- (IBAction)onPushValueChanged:(id)sender {
    
}

- (IBAction)onPressBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];

}

- (IBAction)slide {

    //float dist = self.distanceSlider.value;
    
    float roundedValue = ((self.distanceSlider.value ));
    int rounded = 5 * ceil((float) roundedValue / 5.0);
    
    self.distanceLable.text = [NSString stringWithFormat:@"%i km" , rounded ];
    [[NSUserDefaults standardUserDefaults] setInteger:rounded forKey:@"LocationRadius"];
}

@end
