//
//  EventCell.m
//  EventApp
//
//  Created by iOS7 on 31/07/14.
//  Copyright (c) 2014 michael. All rights reserved.
//

#import "EventCell.h"

@implementation EventCell
@synthesize lblSeperator, imgThumbnail, lblEventContent, lblEventCity, lblEventArtist;
- (void)awakeFromNib
{
    // Initialization code
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        UIView *bgColorView = [[UIView alloc] init];
        bgColorView.backgroundColor = [UIColor blueColor];
        [self setSelectedBackgroundView:bgColorView];
    }
    return  self;
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
    UIColor *lblBgColor = lblSeperator.backgroundColor;
    UIColor *imgBgColor = imgThumbnail.backgroundColor;
    [super setSelected:selected animated:animated];
    [lblSeperator setBackgroundColor:lblBgColor];
    [imgThumbnail setBackgroundColor:imgBgColor];

}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    UIColor *lblBgColor = lblSeperator.backgroundColor;
    UIColor *imgBgColor = imgThumbnail.backgroundColor;
    [super setHighlighted:highlighted animated:animated];
    [lblSeperator setBackgroundColor:lblBgColor];
    [imgThumbnail setBackgroundColor:imgBgColor];
}
@end
