//
//  NSString+CalHeight.h
//  MyCollect
//
//  Created by john on 14-8-1.
//  Copyright (c) 2014年 john. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CalHeight)
-(CGFloat) calulateHeightForOneLyricStr_SDK:(NSString *) lrcStr  FontType:(UIFont *) fontType RowWidth:(CGFloat) rowWidth;

@end
