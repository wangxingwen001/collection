//
//  XFTButton.m
//  MyCollect
//
//  Created by wen on 14-8-6.
//  Copyright (c) 2014年 wen. All rights reserved.
//

#import "XFTButton.h"

@implementation XFTButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (BOOL)canBecomeFirstResponder
{
    return YES;
}
- (BOOL)canResignFirstResponder
{
    return YES;
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
