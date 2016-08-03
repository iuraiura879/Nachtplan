//
//  ViewController.m
//  EventApp
//
//  Created by iOS7 on 29/07/14.
//  Copyright (c) 2014 michael. All rights reserved.
//


#import "ViewControllerLocation.h"
#import "HttpApi.h"
//#import "MyPickerView.h"
#import "DropDownCell.h"
#import "EventCell.h"
#import "Event.h"
#import "LoadingView.h"
#import "DetailViewController.h"
#import "SearchViewController.h"
#import "AdViewController.h"


@interface ViewControllerLocation ()
{
    BOOL bSearchByMutiParams;
    NSMutableArray *eventDateArray;
    NSMutableArray *displayStateArray;
    NSMutableDictionary *eventsDic;
    UITabBarItem *originalItem;
    bool notShownFirstTime;
}
@end

@implementation ViewControllerLocation
@synthesize tblEvents;
@synthesize searchParams;
@synthesize curEventType;


- (void)viewDidLoad
{
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.navigationController.navigationItem.title = @"Location";
    
    ///
    tblEvents.emptyDataSetSource = self;
    tblEvents.emptyDataSetDelegate = self;
    
    oldFooterView = tblEvents.tableFooterView;
    // A little trick for removing the cell separators
    //tblEvents.tableFooterView = [UIView new];
    ///
    
  
    //
    
    
    __weak typeof(self) wself = self;
    
    refreshView = [LGRefreshView refreshViewWithScrollView:tblEvents
                                             refreshHandler:^(LGRefreshView *rfshView)
                    {
                        if (wself)
                        {
                            __strong typeof(wself) self = wself;
                            

                            [self getAllEventsSync];
                            
                            dispatch_async( dispatch_get_main_queue(), ^(void)
                                           {
                                               //[tblEvents reloadData];
                                               [self checkToRemoveSeparators];
                                               [rfshView endRefreshing];
                                               
                                           });
                        }
                    }];
    
    UIColor *blueColor = [UIColor whiteColor];
    UIColor *grayColor = [UIColor blackColor];
    
    refreshView.tintColor = blueColor;
    refreshView.backgroundColor = grayColor;
    
    //
    

    tblEvents.delegate = self;
    tblEvents.dataSource = self;
    notShownFirstTime=YES;
    /////////////////////////////////
    //ACTIVATE LOCATION MANAGER
    
    NSUserDefaults* preferences = [NSUserDefaults standardUserDefaults];
    
    NSString* currentLevelKey = @"LocationAlowed";
    
    if([preferences objectForKey:currentLevelKey] == nil)
    {
        
        [self StartLocationManager];
        
    }
    else
    {
        
        const NSInteger currentLevel = [preferences integerForKey:currentLevelKey];
        if(currentLevel==1)
        {
            
            [self StartLocationManager];
            
        }
        
    }
    
    
    
    ////////////////////////////////
    [self.navigationController.navigationBar setBackgroundColor:[UIColor blackColor]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];

    
    eventDateArray = [[NSMutableArray alloc] init];
    displayStateArray = [[NSMutableArray alloc] init];
    eventsDic = [[NSMutableDictionary alloc] init];
    
    bSearchByMutiParams = false;
    searchParams = @"";
}



- (void) StartLocationManager{
    
    NSLog( @" Location manager gestertet " );
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [locationManager requestAlwaysAuthorization];
        [locationManager requestWhenInUseAuthorization];
    }
    
    [locationManager startUpdatingLocation];
    
    
    
}



- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)location{
    
    CLLocation *currentLocation = [location lastObject];
    //currentLocation.coordinate;
    
    
    
    if(currentLocation!=nil){
        
        
        [[NSUserDefaults standardUserDefaults] setFloat:currentLocation.coordinate.latitude forKey:@"LocationLatitude"];
        [[NSUserDefaults standardUserDefaults] setFloat:currentLocation.coordinate.longitude forKey:@"LocationLongitude"];
        
        [locationManager stopUpdatingLocation];
        locationManager=nil;
        
    }
   
    
    
 
    
    
    
    
   
    
    
   
    
    
}
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(bSearchByMutiParams)
        [self SearchByMultiParams];
    bSearchByMutiParams = false;
    
    
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if(notShownFirstTime)
    {
       [self getAllEvents];
        notShownFirstTime=NO;
        
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-
#pragma mark Actions

- (IBAction)onPressDateButtonItem:(id)sender
{
    if(myDatePicker == nil)
    {
        myDatePicker = [[MyDatePicker alloc] initWithFrame:self.view.bounds];
        myDatePicker.delegate = self;
        [self.view addSubview:myDatePicker];
    }
    [myDatePicker showMyDatePicker];

}



#pragma mark-
#pragma mark Functions

- (void) SearchByMultiParams
{
    NSLog( @" \n ------ \n In finction  :  SearchByMultiParams " );
    if(![searchParams isEqualToString:@""])
        [self sendGetEventsRequest:[NSString stringWithFormat:@"%@%@", AllEvents_Address, searchParams]];
}

- (void) getAllEvents
{
    
    
    NSUserDefaults* preferences = [NSUserDefaults standardUserDefaults];
    
    if([preferences objectForKey:@"LocationAlowed"] != nil)
        if(![preferences boolForKey:@"LocationAlowed"])
        {
            [eventDateArray removeAllObjects];
            [tblEvents reloadData];
            [self checkToRemoveSeparators];
            return;
            
        }
    
    
    NSDate *currDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *datefrom = [dateFormatter stringFromDate:currDate];
    
    NSDate *newDate = [currDate dateByAddingTimeInterval:60*60*24*31];
    dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateto = [dateFormatter stringFromDate:newDate];

    [tblEvents scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
    
    NSString *strAddress;
   

    strAddress = [NSString stringWithFormat:@"%@&search_date=new", AllEvents_Address ]; // AllEvents_Address;
    
    
    
    NSString*loc=@"";
    loc=[self AppendLocationData];

    
    
    strAddress = [strAddress stringByAppendingFormat:@"%@", loc];
    
    
    [self sendGetEventsRequest:strAddress];
    
}


- (void) getAllEventsSync
{
    NSUserDefaults* preferences = [NSUserDefaults standardUserDefaults];
    
    if([preferences objectForKey:@"LocationAlowed"] != nil)
        if(![preferences boolForKey:@"LocationAlowed"])
        {
            [eventDateArray removeAllObjects];
            [tblEvents reloadData];
            [self checkToRemoveSeparators];
            return;
            
        }
    
    
    NSDate *currDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *datefrom = [dateFormatter stringFromDate:currDate];
    
    NSDate *newDate = [currDate dateByAddingTimeInterval:60*60*24*31];
    dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateto = [dateFormatter stringFromDate:newDate];
    
    [tblEvents scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
    
    NSString *strAddress;
    
    
    strAddress = [NSString stringWithFormat:@"%@&search_date=new", AllEvents_Address ]; // AllEvents_Address;
    
    
    
    NSString*loc=@"";
    loc=[self AppendLocationData];
    
    
    
    strAddress = [strAddress stringByAppendingFormat:@"%@", loc];
    
    
    [self sendGetEventsRequestSync:strAddress];
    
}


-(NSString*) AppendLocationData{
    
    
    NSUserDefaults* preferences = [NSUserDefaults standardUserDefaults];
    
    if([preferences objectForKey:@"LocationAlowed"] != nil)
        if([preferences objectForKey:@"LocationLatitude"] != nil)
            if([preferences objectForKey:@"LocationLongitude"] != nil)
                if([preferences objectForKey:@"LocationRadius"] != nil)
                    if([preferences boolForKey:@"LocationAlowed"])
                    {
                        // [preferences integerForKey:currentLevelKey];
                        
                        NSString * loc=[NSString stringWithFormat:@"&latitude=%.4f&longitude=%.4f&radius=%ld",[preferences floatForKey:@"LocationLatitude"],[preferences floatForKey:@"LocationLongitude"],(long)[preferences integerForKey:@"LocationRadius"]];
                        
                        
                        return loc;
                        //strAddress = [strAddress stringByAppendingFormat:@"%@", @"&latitude=51.2167&longitude=6.8104&radius=25"];
                        
                        
                        
                    }
    
    
    return @"";
    
    
    
    
}



-(NSString*) AppendLocationData:(int)radius{
    
    
    NSUserDefaults* preferences = [NSUserDefaults standardUserDefaults];
    
    if([preferences objectForKey:@"LocationAlowed"] != nil)
        if([preferences objectForKey:@"LocationLatitude"] != nil)
            if([preferences objectForKey:@"LocationLongitude"] != nil)
                //if([preferences objectForKey:@"LocationRadius"] != nil)
                    if([preferences boolForKey:@"LocationAlowed"])
                    {
                        // [preferences integerForKey:currentLevelKey];
                        
                        NSString * loc=[NSString stringWithFormat:@"&latitude=%.4f&longitude=%.4f&radius=%d",[preferences floatForKey:@"LocationLatitude"],[preferences floatForKey:@"LocationLongitude"],radius];
                        
                        
                        return loc;
                        //strAddress = [strAddress stringByAppendingFormat:@"%@", @"&latitude=51.2167&longitude=6.8104&radius=25"];
                        
                        
                        
                    }
    
    
    return @"";
    
    
    
    
}





- (void) getAllEventsByLocationDateArtist:(NSString*)strRequest
{
    
    NSLog( @ "\n --------- \n  In function :  getAllEventsByLocationDateArtist   ");
    NSString *fullRequest=AllEvents_Address;
    fullRequest =[fullRequest stringByAppendingString:strRequest];
    [self sendGetEventsRequest:fullRequest];
    
}







- (void) sendGetEventsRequest:(NSString*)strAddress
{
    [[LoadingView sharedView] show:self.navigationController.view MessageText:@"Loading..."];
    [self performSelectorInBackground:@selector(RunInBackgroundSendRequest:) withObject:strAddress];
}


- (void) sendGetEventsRequestSync:(NSString*)strAddress
{
    //[[LoadingView sharedView] show:self.navigationController.view MessageText:@"Loading..."];
    //[self performSelectorInBackground:@selector(RunInBackgroundSendRequest:) withObject:strAddress];
    [self RunInBackgroundSendRequest:strAddress];
}


- (void) sendGetLocationRequest:(NSString*)strAddress
{
    [[LoadingView sharedView] show:self.navigationController.view MessageText:@"Loading..."];
    [self performSelectorInBackground:@selector(RunInBackgroundSendRequestLocation:) withObject:strAddress];
}

- (void) RunInBackgroundSendRequest:(NSString*)strAddress
{
    NSData *responseData = [[HttpApi GetAPIs] sendRequest:strAddress With:nil];
    [self convertToEventArray:responseData];

}

- (void) RunInBackgroundSendRequestLocation:(NSString*)strAddress
{
    NSData *responseData = [[HttpApi GetAPIs] sendRequest:strAddress With:nil];
    [self convertToLocationArray:responseData];
    
}

- (void) convertToEventArray:(NSData*)responseData
{
    NSMutableArray *eventArray = [[NSMutableArray alloc] init];
    NSString *strResponse = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSArray *rows = [strResponse componentsSeparatedByString:@"\n"];
    NSArray *fieldArray;
    Event *eventObj;
    NSString *strRow;
    for (NSInteger nIndex = 1; nIndex < [rows count]; nIndex++)
    {
        strRow = [rows objectAtIndex:nIndex];
        if([strRow isEqualToString:@""])
            continue;
        fieldArray = [strRow componentsSeparatedByString:@";"];
        if([fieldArray count] != 7 )
            continue;

        //NSLog(@"strRow = %@", strRow);
        eventObj = [[Event alloc] init];
        [eventObj setDate:[fieldArray objectAtIndex:0]];
        [eventObj setEvent_id:[fieldArray objectAtIndex:1]];
        [eventObj setName:[fieldArray objectAtIndex:2]];
        [eventObj setPic_1:[fieldArray objectAtIndex:3]];
        [eventObj setVenue_name:[fieldArray objectAtIndex:4]];
        [eventObj setCity:[fieldArray objectAtIndex:5]];
        [eventObj setArtist:[fieldArray objectAtIndex:6]];
        [eventObj setType:@"1"];
        
        if ([eventObj.name isEqualToString: @"-1"])
        {
            continue;
        }
        
        [eventArray addObject:eventObj];
    }
    
    /*if([eventArray count]==0){
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Search" message:@"Sorry, no events found" delegate:self cancelButtonTitle:@"OK	" otherButtonTitles:nil, nil];
            [alert show];
        });
       
        
        
    }*/
    dispatch_async(dispatch_get_main_queue(), ^{
        [self getEventsByDate:eventArray];
        [tblEvents reloadData];
        [self checkToRemoveSeparators];
        [[LoadingView sharedView] hide];
    });
    
}


- (void) convertToLocationArray:(NSData*)responseData
{
    NSMutableArray *locationArray = [[NSMutableArray alloc] init];
    NSString *strResponse = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSArray *rows = [strResponse componentsSeparatedByString:@"\n"];
    NSArray *fieldArray;
    Event *locationObj;
    NSString *strRow;
    for (NSInteger nIndex = 1; nIndex < [rows count]; nIndex++)
    {
        strRow = [rows objectAtIndex:nIndex];
        if([strRow isEqualToString:@""])
            continue;
        fieldArray = [strRow componentsSeparatedByString:@";"];
        if([fieldArray count] != 15 )
            continue;
        
        //NSLog(@"strRow = %@", strRow);
        locationObj = [[Event alloc] init];
        [locationObj setDate:[fieldArray objectAtIndex:13]];
        [locationObj setEvent_id:[fieldArray objectAtIndex:0]];
        [locationObj setName:[fieldArray objectAtIndex:2]];
        [locationObj setPic_1:[fieldArray objectAtIndex:11]];
        [locationObj setVenue_name:[fieldArray objectAtIndex:4]];
        [locationObj setCity:[fieldArray objectAtIndex:5]];
        [locationObj setArtist:[fieldArray objectAtIndex:6]];
        [locationObj setLocationUrl:[fieldArray objectAtIndex:8]];
        [locationObj setType:@"2"];
        
        if ([locationObj.name isEqualToString: @"-1"])
        {
            continue;
        }
        
        [locationArray addObject:locationObj];
    }
    
    if([locationArray count]==0){
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Search" message:@"Sorry, no locations found" delegate:self cancelButtonTitle:@"OK	" otherButtonTitles:nil, nil];
            [alert show];
        });
        
        
        
    }
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self getEventsByDate:locationArray];
        [tblEvents reloadData];
        [self checkToRemoveSeparators];
        [[LoadingView sharedView] hide];
    });
    
}

- (NSDictionary*)getEventsByDate:(NSArray*)events
{
    [self getDateArray:events];
    [eventsDic removeAllObjects];
    for(int nIndex = 0; nIndex < [eventDateArray count]; nIndex++)
    {
        NSMutableArray *eventArray = [[NSMutableArray alloc] init];
        for(Event *eventObj in events)
        {
            if([eventObj.date isEqualToString:[eventDateArray objectAtIndex:nIndex]])
            {
                [eventArray addObject:eventObj];
            }
        }
        [eventsDic setObject:eventArray forKey:[eventDateArray objectAtIndex:nIndex]];
    }
    return eventsDic;
}

- (NSArray*)getDateArray:(NSArray*)events
{
    BOOL bExist;
    NSString * compy = @"-1";
    [eventDateArray removeAllObjects];
    [displayStateArray removeAllObjects];
    for(Event *eventObj in events)
    {
        bExist = false;
        for(int nIndex = 0; nIndex < [eventDateArray count]; nIndex++)
        {
            if([[eventDateArray objectAtIndex:nIndex] isEqualToString:eventObj.date])
                bExist = true;
        }

        if( !bExist && eventObj.name != compy  )
        {
            [eventDateArray addObject:eventObj.date];
            [displayStateArray addObject:[NSMutableString stringWithString:@"1"]];
        }
    }
    //
    //NSLog(@"satate = %@", displayStateArray);
    
    return eventDateArray;
}

- (NSString *)formatDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *formattedDate = [dateFormatter stringFromDate:date];
    return formattedDate;
}


#pragma mark-
#pragma mark TableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [eventDateArray count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [eventDateArray objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([[displayStateArray objectAtIndex:section] integerValue])
        return [[eventsDic objectForKey:[eventDateArray objectAtIndex:section]] count] ;
    else
        return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"EventsCellId";
    
        switch ([indexPath row]) {
            /*
            case 0: {
               
                DropDownCell *cell = (DropDownCell*) [tableView dequeueReusableCellWithIdentifier:DropDownCellIdentifier];
                if (cell == nil){
                    NSLog(@"New Cell Made");
                    
                    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"DropDownCell" owner:nil options:nil];
                    
                    for(id currentObject in topLevelObjects)
                    {
                        if([currentObject isKindOfClass:[DropDownCell class]])
                        {
                            cell = (DropDownCell *)currentObject;
                            break;
                        }
                    }
                    if([[displayStateArray objectAtIndex:indexPath.section] integerValue])
                        [cell setOpen];
                    else
                        [cell setClosed];
                }
                // Configure the cell.
                return cell;
            
                break;
            }
             */
            
             
             
            default:
            {
                EventCell *cell = (EventCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                if (cell == nil){
                    
                    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"EventCell" owner:nil options:nil];
                    
                    for(id currentObject in topLevelObjects)
                    {
                        if([currentObject isKindOfClass:[EventCell class]])
                        {
                            cell = (EventCell *)currentObject;
                            break;
                        }
                    }
                }
                //NSLog( @" %i - %i " , indexPath.section , indexPath.row );
                //Event *currentEvent = [[eventsDic objectForKey:[eventDateArray objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row - 1];
                Event *currentEvent = [[eventsDic objectForKey:[eventDateArray objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row ];

                
                // hier noch das richtige bild einsetzen
                //NSString * tmpURL = @"http://nachtplan.pixelutions.de/uploads/";
                NSString * tmpURL = @"";
                tmpURL = [tmpURL stringByAppendingString:[NSString stringWithFormat:@"%@", currentEvent.pic_1 ]];
                //NSLog(@" --- %@ --- ", tmpURL);
                
                NSURL* url =[NSURL URLWithString:tmpURL];
                NSData* imageData = [NSData dataWithContentsOfURL:url];
                UIImage * image = [UIImage imageWithData:imageData];
                
                
                [cell.imgThumbnail setImage:image];
                
                
                //[cell.imgThumbnail setImage:[UIImage imageNamed:@"np_icon.png"]];
                
                if(currentEvent != nil)
                {
                    [cell.lblEventContent setText:currentEvent.name];
                    [cell.lblEventCity setText:currentEvent.city];
                    [cell.lblEventArtist setText:currentEvent.artist];
                }
                
                // Configure the cell.
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
                break;
            }
        }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch ([indexPath row]) {
          /*
        case 0:
        {
            DropDownCell *cell = (DropDownCell*) [tableView cellForRowAtIndexPath:indexPath];
            
            NSMutableArray *indexPathArray = [[NSMutableArray alloc] init];
            
            NSIndexPath *path;
            NSInteger nCount = [[eventsDic objectForKey:[eventDateArray objectAtIndex:indexPath.section]] count];
            NSLog(@"count = %d", nCount);
            for( int rowIndex = 1; rowIndex <= [[eventsDic objectForKey:[eventDateArray objectAtIndex:indexPath.section]] count]; rowIndex++)
            {
                path = [NSIndexPath indexPathForRow:rowIndex inSection:[indexPath section]];
                [indexPathArray addObject:path];
            }
            
            if ([[displayStateArray objectAtIndex:indexPath.section] integerValue])
            {
                [cell setClosed];
                NSMutableString *strState = [displayStateArray objectAtIndex:indexPath.section];
                [strState setString:@"0"];
                [tableView deleteRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationTop];
            }
            else
            {
                [cell setOpen];
                NSMutableString *strState = [displayStateArray objectAtIndex:indexPath.section];
                [strState setString:@"1"];
                [tableView insertRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationTop];
            }
            
            NSLog(@"statearray = %@", displayStateArray);
             
            break;
        }
           */
             
        default:
        {
            UITableViewCell *cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
            cell.contentView.backgroundColor = [UIColor colorWithRed:0.15 green:0.15 blue:0.15 alpha:1];
            //Event *currentObj = (Event*)[[eventsDic objectForKey:[eventDateArray objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row - 1];
            Event *currentObj = (Event*)[[eventsDic objectForKey:[eventDateArray objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row ];
            [self performSegueWithIdentifier:@"detailSegue" sender:currentObj];
            break;
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

#pragma mark-
#pragma mark TabBar Delegate

- (void) tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
 
 

        
        //Get list with location adresses
        
        
        
        NSString*adress=Location_Address;
        NSString*loc=[self AppendLocationData];
        
        if([loc isEqualToString:@""])
            loc=@"&latitude=0&longitude=0&radius=0";
            
            
            
        
        
        adress = [adress stringByAppendingFormat:@"%@", loc];
    
        
        [self sendGetLocationRequest:adress];
        
    
   
}

#pragma mark-
#pragma mark prepareForSegue

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(Event*)sender
{
    if([segue.identifier isEqualToString:@"detailSegue"])
    {
        // Get reference to the destination view controller
         DetailViewController *detailVC = [segue destinationViewController];
        
        [detailVC setEventID:sender.event_id];
        [detailVC setEventDate:sender.date];
        
        if([sender.type isEqualToString:@"2"])
            [detailVC setLocationURL:sender.locationUrl];
        
    }
    else if([segue.identifier isEqualToString:@"searchSegue"])
    {
        SearchViewController *searchVC = [segue destinationViewController];
        searchVC.delegate=self;
        [searchVC setParentVC:self];
    }
}

#pragma mark-
#pragma mark MyDatePickerDelegate

- (void)DatePickerValueChanged:(UIDatePicker *)datePicker
{
    //when user presses date button in app events, code goes here
    
    

    
}



#pragma mark-
#pragma mark SearchViewControllerDelegate
-(void) doSearch:(NSString*)searchUrl{
    
    
    
   	
   
    NSLog(@"here");
    
    [self getAllEventsByLocationDateArtist:searchUrl];
   // [self getAllEventsBy:ALL_EVENT];
    
}


-(void) checkToRemoveSeparators{
    
    if( [eventDateArray count] == 0 )
        tblEvents.tableFooterView = [UIView new];
    else
        tblEvents.tableFooterView = oldFooterView;
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSUserDefaults* preferences = [NSUserDefaults standardUserDefaults];
    
    NSString *text = @"No results found";
    
    if([preferences objectForKey:@"LocationAlowed"] != nil)
        if(![preferences boolForKey:@"LocationAlowed"])
            text = @"Location is disabled";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:22.0f],
                                 NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    NSUserDefaults* preferences = [NSUserDefaults standardUserDefaults];
    
      UIImage* image = [UIImage imageNamed:@"search_selected.png"];
    
    
    if([preferences objectForKey:@"LocationAlowed"] != nil)
        if(![preferences boolForKey:@"LocationAlowed"])
            image = [UIImage imageNamed:@"location_selected.png"];
    
     
    
    UIImage *newImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    
    
    UIGraphicsBeginImageContextWithOptions(image.size, NO, newImage.scale);
    [[UIColor whiteColor] set];
    [newImage drawInRect:CGRectMake(0, 0, image.size.width, newImage.size.height)];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
    
}


- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIColor blackColor];
}


@end
