//
//  DetailViewController.m
//  EventApp
//
//  Created by iOS7 on 31/07/14.
//  Copyright (c) 2014 michael. All rights reserved.
//

#import "AdViewController.h"


@interface AdViewController ()

@end

@implementation AdViewController


- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];

    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
   // NSString *jsonString = @"{\"ID\":{\"Content\":268,\"type\":\"text\"},\"ContractTemplateID\":{\"Content\":65,\"type\":\"text\"}}";
    //NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    //id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    

    NSURL *url = [NSURL URLWithString:@"http://echo.jsontest.com/id/64/src/http%3A%2F%2Fnachtplan.pixelutions.de%2Fuploads%2Fevent_default_50p.jpg/url/www.nachtplan.de"];
    
    NSData *jsonData = [NSData dataWithContentsOfURL:url];
    
    id result=0;
    
    
    if(jsonData != nil)
    {
        NSError *error = nil;
        result = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
        if (error == nil)
            NSLog(@"%@", result);
    }
    
    
    
    /////////////////
   // NSString* serverResponse= @"44;http://nachtplan.pixelutions.de/uploads/event_default_50p.jpg;http://www.nachtplan.de;";
  //  NSArray *array = [serverResponse componentsSeparatedByString:@";"];
    
    
    NSString *test=[result objectForKey:@"src"];
    
    test=[test stringByReplacingOccurrencesOfString:@"%3A"
                                   withString:@":"];
    
    test=[test stringByReplacingOccurrencesOfString:@"%2F"
                                    withString:@"/"];
    
    
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:test]];
    _adImageView.image = [UIImage imageWithData:imageData];
    /////////////////
    
    // Do any additional setup after loading the view.aaaaaa
    
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

- (IBAction)exitPressed:(id)sender {
    
    [self dismissViewControllerAnimated:NO completion:nil];
    
}
@end
