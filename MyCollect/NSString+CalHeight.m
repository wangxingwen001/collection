//
//  NSString+CalHeight.m
//  MyCollect
//
//  Created by john on 14-8-1.
//  Copyright (c) 2014年 john. All rights reserved.
//

#import "NSString+CalHeight.h"

@implementation NSString (CalHeight)
-(CGFloat) calulateHeightForOneLyricStr_SDK:(NSString *) lrcStr  FontType:(UIFont *) fontType RowWidth:(CGFloat) rowWidth
{
    if (lrcStr==nil)
    {
        return 0;
    }
    CGSize maxSize=CGSizeMake(rowWidth, MAXFLOAT);
    CGSize  strSize=[lrcStr sizeWithFont:fontType constrainedToSize:maxSize lineBreakMode:NSLineBreakByWordWrapping];
    //  [lrcStr sizeWithFont:[UIFont systemFontOfSize:self.fontSize] forWidth:rowWidth lineBreakMode:UILineBreakModeWordWrap];
    
    return strSize.height;
}


@end
