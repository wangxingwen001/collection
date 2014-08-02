//
//  MyCollectCell.m
//  MyCollect
//
//  Created by john on 14-7-31.
//  Copyright (c) 2014年 john. All rights reserved.
//

#import "XFTMyCollectCell.h"
@implementation XFTMyCollectCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        //分割线
        UIView *separatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.5)];
        separatorView.backgroundColor = [UIColor colorWithRed:0.871 green:0.886 blue:0.898 alpha:1];
        [self.myContentView addSubview:separatorView];
        //头像
        self.headeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 35, 35)];
        self.headeImageView.image = [UIImage imageNamed:@"headImage.jpg"];
        [self.myContentView addSubview:self.headeImageView];
        //昵称
        self.nickNameLabel = [[XFTCustomLabel alloc] initWithFrame:CGRectMake(55, 7, 200, 20) TextFont:15 textColor:[UIColor blackColor] textAliment:NSTextAlignmentLeft text:@"幸福在线" backGroundColor:[UIColor clearColor]];
        [self.myContentView addSubview:self.nickNameLabel];
        //收藏时间
        self.collectedTimeLabel = [[XFTCustomLabel alloc] initWithFrame:CGRectMake(240, 7, 70, 20) TextFont:15 textColor:GRAY_COLOR textAliment:NSTextAlignmentRight text:@"14-7-31" backGroundColor:[UIColor clearColor]];
        [self.myContentView addSubview:self.collectedTimeLabel];
        
    }
    return self;
}


- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
