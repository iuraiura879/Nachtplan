//
//  DropDownCell.h
//  EventApp
//
//  Created by iOS7 on 31/07/14.
//  Copyright (c) 2014 michael. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DropDownCell : UITableViewCell {
    
    IBOutlet UILabel *lblEventTitle;
    IBOutlet UILabel *lblImageTitle;
    IBOutlet UIImageView *arrow_up;
    IBOutlet UIImageView *arrow_down;
    IBOutlet UILabel *lblSeperator;
    
    BOOL isOpen;

}

- (void) setOpen;
- (void) setClosed;

@property (nonatomic) BOOL isOpen;
@property (nonatomic, retain) IBOutlet UILabel *lblImageTitle;
@property (nonatomic, retain) IBOutlet UILabel *lblEventTitle;
@property (nonatomic, retain) IBOutlet UIImageView *arrow_up;
@property (nonatomic, retain) IBOutlet UIImageView *arrow_down;
@property (nonatomic, retain) IBOutlet UILabel *lblSeperator;
@end
