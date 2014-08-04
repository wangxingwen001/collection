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
        self.contentTextLabel = [[XFTCustomLabel alloc] initWithFrame:CGRectMake(55, 35, 255, 40) TextFont:14 textColor:[UIColor blackColor] textAliment:NSTextAlignmentLeft text:nil backGroundColor:[UIColor clearColor]];
        self.contentTextLabel.numberOfLines = 2;
        [self.myContentView addSubview:self.contentTextLabel];
    }
    return self;
}
- (void)updateCurrecntCellWithModel:(XFTCollectModel *)collectModel
{
    CGRect rect = self.contentTextLabel.frame;
    CGFloat height = [collectModel.content calulateHeightForOneLyricStr_SDK:collectModel.content FontType:[UIFont systemFontOfSize:14] RowWidth:255];
    if(height < 40)
    {
        rect.size.height = height;
        self.contentTextLabel.frame = rect;
    }
    
    self.contentTextLabel.text = collectModel.content;
    [self.headeImageView setImage:[UIImage imageNamed:collectModel.headImageUrl]];
    self.nickNameLabel.text = collectModel.nickName;
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
