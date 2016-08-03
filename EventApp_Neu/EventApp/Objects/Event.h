//
//  Event.h
//  EventApp
//
//  Created by iOS7 on 06/08/14.
//  Copyright (c) 2014 michael. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface Event : NSObject

@property (nonatomic, retain) NSString * event_id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * pic_1;
@property (nonatomic, retain) NSString * venue_name;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * artist;
@property (nonatomic, retain) NSString * date;
@property (nonatomic, retain) NSString * type; //1 event 2 location
@property (nonatomic, retain) NSString * locationUrl;
@end
