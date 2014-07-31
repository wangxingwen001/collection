//
//  UILabel+CalHeight.h
//  uilib
//
//  Created by doujingxuan on 12-12-10.
//  Copyright (c) 2012年 doujingxuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (CalHeight)
-(CGFloat)calculateHeightWithFont:(UIFont*)font;
-(CGSize)calculateCGSizeWithFont:(UIFont *)font;
-(CGSize)calculateCGSizeWithFont:(UIFont *)font breakMode:(NSLineBreakMode)mode lines:(int)lines;
@end
