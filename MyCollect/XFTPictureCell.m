//
//  XFTPictureCell.m
//  MyCollect
//
//  Created by john on 14-8-1.
//  Copyright (c) 2014年 john. All rights reserved.
//

#import "XFTPictureCell.h"

@implementation XFTPictureCell

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
        self.photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(55, 35, 100, 60)];
        self.photoImageView.image = [UIImage imageNamed:@"picture"];
        [self.myContentView addSubview:self.photoImageView];
        self.photoTextLabel = [[XFTCustomLabel alloc] initWithFrame:CGRectMake(55, 100,255, 20) TextFont:14 textColor:[UIColor colorWithRed:125.0/255.0 green:125.0/255.0 blue:125.0/255.0 alpha:1.0] textAliment:NSTextAlignmentLeft text:@"图片包含:团结湖 下午 上班" backGroundColor:[UIColor clearColor]];
        [self.myContentView addSubview:self.photoTextLabel];
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
