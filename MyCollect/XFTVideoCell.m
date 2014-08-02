//
//  XFTVideoCell.m
//  MyCollect
//
//  Created by john on 14-8-1.
//  Copyright (c) 2014年 john. All rights reserved.
//

#import "XFTVideoCell.h"

@implementation XFTVideoCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        CGRect rect = CGRectMake(55, 35, 60, 60);
        self.videoImageView1 = [[UIImageView alloc] initWithFrame:rect];
        self.videoImageView1.image = [UIImage imageNamed:@"photo"];
        [self.myContentView addSubview:self.videoImageView1];
        rect = CGRectMake(27/2, 27/2, 33, 33);
        self.videoImageView2 = [[UIImageView alloc] initWithFrame:rect];
        self.videoImageView2.image = [UIImage imageNamed:@"playImage"];
        [self.videoImageView1 addSubview:self.videoImageView2];
        
        self.videoTitle = [[XFTCustomLabel alloc] initWithFrame:CGRectMake(125, 30, 80, 20) TextFont:14 textColor:[UIColor blackColor] textAliment:NSTextAlignmentLeft text:@"视频" backGroundColor:[UIColor clearColor]];
        [self.myContentView addSubview:self.videoTitle];
        self.videoTimeLabel = [[XFTCustomLabel alloc] initWithFrame:CGRectMake(125, 55, 80, 20) TextFont:14 textColor:GRAY_COLOR textAliment:NSTextAlignmentLeft text:@"40秒" backGroundColor:[UIColor clearColor]];
        [self.myContentView addSubview:self.videoTimeLabel];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
