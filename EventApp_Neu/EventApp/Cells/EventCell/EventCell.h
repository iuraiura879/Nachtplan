//
//  EventCell.h
//  EventApp
//
//  Created by iOS7 on 31/07/14.
//  Copyright (c) 2014 michael. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imgThumbnail;
@property (strong, nonatomic) IBOutlet UILabel *lblEventContent;
@property (strong, nonatomic) IBOutlet UILabel *lblEventCity;
@property (strong, nonatomic) IBOutlet UILabel *lblEventArtist;
@property (strong, nonatomic) IBOutlet UILabel *lblSeperator;
@end
