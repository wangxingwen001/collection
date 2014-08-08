//
//  DisPlayView.m
//  MyCollect
//
//  Created by john on 14-8-7.
//  Copyright (c) 2014年 john. All rights reserved.
//

#import "DisPlayView.h"
#import "NSString+CalWidth.h"
#import "MyLayer.h"
@implementation DisPlayView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor colorWithRed:0.906 green:0.906 blue:0.906 alpha:1];
        NSArray *imageArray = @[@"icon_Link",@"icon_Picture",@"icon_Voice",@"icon_Music",@"icon_Video"];
        NSArray *titleArray = @[@"连接",@"图片",@"语音",@"音乐",@"视频"];
        CGFloat distence = (MainSreenWidth-225)/6;

        for(int i = 0;i < imageArray.count; i ++)
        {
            UIImage *image = [UIImage imageNamed:imageArray[i]];
            NSString *title = titleArray[i];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setImage:image forState:UIControlStateNormal];
            button.frame = CGRectMake(distence+(45+distence)*i, 20, 45, 45);
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = i + 100;
            [self addSubview:button];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(distence+(45+distence)*i, button.frame.origin.y + button.frame.size.height + 10, 45, 15)];
            label.text = title;
            label.font = [UIFont systemFontOfSize:14];
            label.backgroundColor = [UIColor clearColor];
            label.textColor = [UIColor grayColor];
            label.textAlignment = NSTextAlignmentCenter;
            [self addSubview:label];
        }
        UILabel *allTagLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 120, 100, 15)];
        allTagLabel.backgroundColor = [UIColor clearColor];
        allTagLabel.textColor = [UIColor grayColor];
        allTagLabel.text = @"所有标签";
        allTagLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:allTagLabel];
  
        CGFloat tag_X = 15;
        CGFloat tag_Y = 145;
        CGFloat tag_W = 0;
        CGFloat tag_H = 25;
        NSArray *tagS = @[@"Link",@"Picture",@"Voice",@"Music",@"Video",@"Link",@"Picture",@"Voice",@"Music",@"Video",@"Link",@"Picture",@"Voice",@"Music",@"Video",@"Link",@"Picture",@"Voice",@"Music",@"Video",@"Link",@"Picture",@"Voice",@"Music",@"Video",@"Link",@"Picture",@"Voice",@"Music",@"Video",@"Link",@"Picture",@"Voice",@"Music",@"Video",@"Link",@"Picture",@"Voice",@"Music",@"Video",@"Link",@"Picture",@"Voice",@"Music",@"Video",@"Link",@"Picture",@"Voice",@"Music",@"Video",@"Link",@"Picture",@"Voice",@"Music",@"Video",@"Link",@"Picture",@"Voice",@"Music",@"Video",@"Link",@"Picture",@"Voice",@"Music",@"Video",@"Link",@"Picture",@"Voice",@"Music",@"Video",@"Link",@"Picture",@"Voice",@"Music",@"Video",@"Link",@"Picture",@"Voice",@"Music",@"Video",@"Link",@"Picture",@"Voice",@"Music",@"Video",@"Link",@"Picture",@"Voice",@"Music",@"Video"];

        UIButton *lastBtn = nil;
        for(NSString *tag in tagS)
        {
            tag_W = [tag calculateWidthForFont:[UIFont systemFontOfSize:14]]+25;
            if(lastBtn)
            {
                tag_X = lastBtn.frame.origin.x + lastBtn.frame.size.width + 10;
                tag_Y = lastBtn.frame.origin.y;
                if(tag_X + tag_W > MainSreenWidth-15)
                {
                    tag_X = 15;
                    tag_Y += 35;
                }
            }
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.userInteractionEnabled = YES;
            btn.backgroundColor = [UIColor whiteColor];
            [MyLayer RoundedWithBorder:btn cornerRadius:tag_H/2 borderWidth:1.0 borderColor:TAG_COLOR_GRAY masksToBounds:YES];
            [btn addTarget:self action:@selector(tagButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.frame = CGRectMake(tag_X, tag_Y, tag_W, tag_H);
            [btn setTitle:tag forState:UIControlStateNormal];
            [self addSubview:btn];
            lastBtn = btn;
        }
        if(tag_Y + 25 > self.frame.size.height)
        {
            CGRect frame = self.frame;
            frame.size.height = tag_Y + 50;
            self.frame = frame;
        }
    
        NSLog(@"h = %f",self.frame.size.height);
    }
    return self;
}
- (void)buttonClick:(UIButton*)btn
{
    if([self.delegate respondsToSelector:@selector(disPlayButtonClick:)])
    {
        [self.delegate disPlayButtonClick:btn];
    }
}
- (void)tagButtonClick:(UIButton*)btn
{
    if([self.delegate respondsToSelector:@selector(tagBtnClick:)])
    {
        [self.delegate tagBtnClick:btn];
    }
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
