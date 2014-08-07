//
//  DisPlayView.m
//  MyCollect
//
//  Created by john on 14-8-7.
//  Copyright (c) 2014年 john. All rights reserved.
//

#import "DisPlayView.h"

@implementation DisPlayView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSArray *imageArray = @[@"icon_Link",@"icon_Music",@"icon_Voice",@"icon_Video",@"icon_Picture"];
        NSArray *titleArray = @[@"连接",@"图片",@"语音",@"音乐",@"视频"];
        
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
