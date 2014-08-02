//
//  GZKJCustomLabel.m
//  Eggplant
//
//  Created by apple on 14-2-21.
//  Copyright (c) 2014年 guangzhankeji. All rights reserved.
//

#import "XFTCustomLabel.h"

@implementation XFTCustomLabel

- (id)initWithFrame:(CGRect)frame TextFont:(CGFloat)font textColor:(UIColor*)color textAliment:(NSTextAlignment)aliment text:(NSString*)text backGroundColor:(UIColor*)bgColor
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.font = [UIFont systemFontOfSize:font];
        self.textColor = color;
        self.textAlignment = aliment;
        self.text = text;
        self.backgroundColor = bgColor;
        self.numberOfLines = 0;
        
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
