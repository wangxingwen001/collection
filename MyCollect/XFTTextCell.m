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
        self.contentTextLabel = [[XFTCustomLabel alloc] initWithFrame:CGRectMake(55, 30, 255, 45) TextFont:14 textColor:[UIColor blackColor] textAliment:NSTextAlignmentLeft text:@"我喜欢乡村的天是那么蓝，水是那么清，树是那么绿，山是连绵不断的青；还喜欢那里夜晚的寂静；晚上除了几声狗叫，很少听到其他的噪杂声；那里的夜晚月亮是那么亮，星星也比城市的多、亮。" backGroundColor:[UIColor clearColor]];
        self.contentTextLabel.numberOfLines = 2;
        [self.myContentView addSubview:self.contentTextLabel];
    }
    return self;
}
- (XFTTextCell*)loadCellWithCell:(XFTTextCell *)cell collectItem:(XFTCollectItem *)collectItem
{
    cell.contentTextLabel.text = collectItem.content;
    [cell.headeImageView setImage:[UIImage imageNamed:collectItem.headImageUrl]];
    cell.nickNameLabel.text = collectItem.nickName;
    return cell;
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
