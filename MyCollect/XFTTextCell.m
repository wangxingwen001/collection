//
//  XFTTextCell.m
//  MyCollect
//
//  Created by john on 14-8-1.
//  Copyright (c) 2014年 john. All rights reserved.
//

#import "XFTTextCell.h"

@implementation XFTTextCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.contentTextLabel = [[XFTCustomLabel alloc] initWithFrame:CGRectMake(55, 30, 255, 45) TextFont:14 textColor:[UIColor blackColor] textAliment:NSTextAlignmentLeft text:@"情人节即将到来，祝有情人情人节快乐，没情人的破坏别人的快乐，哈哈哈！！！！" backGroundColor:[UIColor clearColor]];
        self.contentTextLabel.numberOfLines = 2;
        [self.myContentView addSubview:self.contentTextLabel];
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
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
