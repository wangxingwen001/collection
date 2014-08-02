//
//  XFTVoiceCell.m
//  MyCollect
//
//  Created by john on 14-8-1.
//  Copyright (c) 2014年 john. All rights reserved.
//

#import "XFTVoiceCell.h"

@implementation XFTVoiceCell

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
        self.voiceImageView = [[UIImageView alloc] initWithFrame:CGRectMake(55, 30, 75, 32)];
        UIImage * image = [[UIImage imageNamed:@"chat_message_other"] resizableImageWithCapInsets:UIEdgeInsetsMake(15, 15, 15, 15)];
        [self.voiceImageView setImage:image];
        [self.myContentView addSubview:self.voiceImageView];
        self.voiceTimeLabel = [[XFTCustomLabel alloc] initWithFrame:CGRectMake(self.voiceImageView.frame.origin.x + 10 + 75, self.voiceImageView.center.y-10, 40, 20) TextFont:14 textColor:GRAY_COLOR textAliment:NSTextAlignmentLeft text:@"3\"" backGroundColor:[UIColor clearColor]];
        
        self.voiceImageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(45, 6, 20, 20)];
        self.voiceImageView1.image = [UIImage imageNamed:@"bottleReceiverVoiceNodePlaying"];
        [self.voiceImageView addSubview:self.voiceImageView1];
        [self.myContentView addSubview:self.voiceTimeLabel];
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
