//
//  NSString+CalWidth.m
//  MyCollect
//
//  Created by john on 14-8-5.
//  Copyright (c) 2014年 john. All rights reserved.
//

#import "NSString+CalWidth.h"

@implementation NSString (CalWidth)
- (CGFloat)calculateWidthForFont:(UIFont *)font
{
    CGSize size = [self sizeWithFont:font];
    return size.width;
}
@end
