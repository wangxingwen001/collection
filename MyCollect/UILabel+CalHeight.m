//
//  UILabel+CalHeight.m
//  uilib
//
//  Created by doujingxuan on 12-12-10.
//  Copyright (c) 2012年 doujingxuan. All rights reserved.
//

#import "UILabel+CalHeight.h"

@implementation UILabel (CalHeight)
-(CGFloat)calculateHeightWithFont:(UIFont *)font
{
    if (nil == font) {
        font = [UIFont systemFontOfSize:17.0];
    }
    
    [self setNumberOfLines:0];
    self.lineBreakMode = NSLineBreakByWordWrapping;
    
    //设置一个行高上限
    NSString * labelString = self.text;
    NSLog(@"labelString is %@",labelString);
    if ((nil != labelString) && [labelString isKindOfClass:[NSString class]]) {
    CGSize size = CGSizeMake(self.frame.size.width,MAXFLOAT);
    //计算实际frame大小，并将label的frame变成实际大小
    CGSize labelsize = [self.text  sizeWithFont:font constrainedToSize:size lineBreakMode:self.lineBreakMode];
        NSLog(@"labelsize is %@",NSStringFromCGSize(labelsize));
        return labelsize.height;
    }
    else{
        return 0.0f;
    }
}
-(CGSize)calculateCGSizeWithFont:(UIFont *)font
{
    [self setNumberOfLines:1];
    self.lineBreakMode = NSLineBreakByWordWrapping;
    
    //设置一个行高上限
    NSString * labelString = self.text;
    if ((nil != labelString) && [labelString isKindOfClass:[NSString class]]) {
        CGSize size = CGSizeMake(self.frame.size.width,MAXFLOAT);
        //计算实际frame大小，并将label的frame变成实际大小
        CGSize labelsize = [self.text  sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
        return labelsize;
    }
    else{
        CGSize size = CGSizeMake(0, 0);
        return size;
    }
}
-(CGSize)calculateCGSizeWithFont:(UIFont *)font breakMode:(NSLineBreakMode)mode lines:(int)lines
{
    [self setNumberOfLines:lines];
    self.lineBreakMode = mode;
    
    //设置一个行高上限
    NSString * labelString = self.text;
    if ((nil != labelString) && [labelString isKindOfClass:[NSString class]]) {
        CGSize size = CGSizeMake(self.frame.size.width,MAXFLOAT);
        //计算实际frame大小，并将label的frame变成实际大小
        CGSize labelsize = [self.text  sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
        return labelsize;
    }
    else{
        CGSize size = CGSizeMake(0, 0);
        return size;
    }

}

@end
