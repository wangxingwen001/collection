//
//  XFTMapCell.m
//  MyCollect
//
//  Created by john on 14-8-1.
//  Copyright (c) 2014年 john. All rights reserved.
//

#import "XFTLocationCell.h"

@implementation XFTLocationCell

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
        self.mapImageView = [[UIImageView alloc] initWithFrame:CGRectMake(55, 35, 60, 60)];
        self.mapImageView.image = [UIImage imageNamed:@"mapImage"];
        [self.myContentView addSubview:self.mapImageView];
        
        self.mapDetailLabel = [[XFTCustomLabel alloc] initWithFrame:CGRectMake(125, 30, 320-135, 40) TextFont:14 textColor:[UIColor blackColor] textAliment:NSTextAlignmentLeft text:@"朝阳区团结湖东三环北路17号新时代证券大厦803室" backGroundColor:[UIColor clearColor]];
        self.mapDetailLabel.numberOfLines = 2;
        [self.myContentView addSubview:self.mapDetailLabel];
        
        self.mapLabel = [[XFTCustomLabel alloc] initWithFrame:CGRectMake(125, 65, 40, 20) TextFont:14 textColor:GRAY_COLOR textAliment:NSTextAlignmentLeft text:@"位置" backGroundColor:[UIColor clearColor]];
        [self.myContentView addSubview:self.mapLabel];
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
