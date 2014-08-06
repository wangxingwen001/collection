//
//  XFTTagWriteView.h
//  MyCollect
//
//  Created by john on 14-8-5.
//  Copyright (c) 2014年 john. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol XFTTagWriteViewDelegate;

@interface XFTTagWriteView : UIView
@property(nonatomic,strong)UIColor *myTagColor;
@property(nonatomic,strong)UIColor *bolderColor;
@property(nonatomic,strong)UIColor *tagBackgroundColor;
@property(nonatomic,strong)UIColor *tagForegroundColor;
@property(nonatomic,strong)UIFont  *font;
@property(nonatomic,strong)NSArray *collectTagArray;
@property(nonatomic,strong)NSArray *myTagArray;
@property(nonatomic,strong)NSMutableArray *inputTagArray;
- (void)removeNotication:(NSString*)name;
- (void)showKeyBoard:(BOOL)isShow;
- (void)updateTag:(NSArray *)tags;
- (void)updateMyTagView:(NSArray *)myTags;
@end

@protocol XFTTagWriteViewDelegate <NSObject>


@end