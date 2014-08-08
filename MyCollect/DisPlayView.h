//
//  DisPlayView.h
//  MyCollect
//
//  Created by john on 14-8-7.
//  Copyright (c) 2014年 john. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DisPlayViewDelegate<NSObject>
- (void)disPlayButtonClick:(UIButton*)btn;
- (void)tagBtnClick:(UIButton*)btn;
@end
@interface DisPlayView : UIView
@property(nonatomic,assign)id <DisPlayViewDelegate> delegate;
- (id)initWithFrame:(CGRect)frame;
@end
