//
//  MyLayer.m
//  SoldPhoto
//
//  Created by wen on 13-11-26.
//
//

#import "MyLayer.h"
#import <QuartzCore/QuartzCore.h>
@implementation MyLayer
//view:被修改的view  cornerRadius:弧度大小    borderWidth:边框宽度  borderColor:边框颜色  
+(void) RoundedWithBorder:(UIView*)view cornerRadius:(CGFloat)myCornerRadius borderWidth:(CGFloat)myBorderWidth borderColor:(UIColor*)myBorderColor masksToBounds:(BOOL)myMasksToBounds
{
    //设置圆角
    view.layer.cornerRadius = myCornerRadius;
    view.layer.masksToBounds = myMasksToBounds;
    view.layer.borderWidth = myBorderWidth;
    view.layer.borderColor = [myBorderColor CGColor];
}
@end
