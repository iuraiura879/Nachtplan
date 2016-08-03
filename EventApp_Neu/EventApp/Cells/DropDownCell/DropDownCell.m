//
//  DropDownCell.m
//  EventApp
//
//  Created by iOS7 on 31/07/14.
//  Copyright (c) 2014 michael. All rights reserved.
//

#import "DropDownCell.h"


@implementation DropDownCell

@synthesize lblImageTitle, lblEventTitle, arrow_up, arrow_down, isOpen, lblSeperator;

- (void) setOpen 
{
    [arrow_down setHidden:YES];
    [arrow_up setHidden:NO];
    [self setIsOpen:YES];
}

- (void) setClosed
{
    [arrow_down setHidden:NO];
    [arrow_up setHidden:YES];
    [self setIsOpen:NO];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    UIColor *bgColor = lblSeperator.backgroundColor;
    [super setSelected:selected animated:animated];
    [lblSeperator setBackgroundColor:bgColor];
    
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    UIColor *bgColor = lblSeperator.backgroundColor;
    [super setHighlighted:highlighted animated:animated];
    [lblSeperator setBackgroundColor:bgColor];
}

@end
