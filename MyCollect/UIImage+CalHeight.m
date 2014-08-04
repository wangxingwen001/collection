//
//  UIImage+CalHeight.m
//  MyCollect
//
//  Created by john on 14-8-4.
//  Copyright (c) 2014年 john. All rights reserved.
//

#import "UIImage+CalHeight.h"

@implementation UIImage (CalHeight)
- (CGFloat)calculateHeightWithWidth:(CGFloat)width
{
    
    if(self.size.height < width /(self.size.width/self.size.height))
    {
        return self.size.height;
    }
    return width /(self.size.width/self.size.height);
}
@end
