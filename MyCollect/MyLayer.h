//
//  MyLayer.h
//  SoldPhoto
//
//  Created by wen on 13-11-26.
//
//

#import <Foundation/Foundation.h>

@interface MyLayer : NSObject
+(void) RoundedWithBorder:(UIView*)view cornerRadius:(CGFloat)myCornerRadius borderWidth:(CGFloat)myBorderWidth borderColor:(UIColor*)myBorderColor masksToBounds:(BOOL)myMasksToBounds;
@end
