//
//  XFTSuperViewController.h
//  MyCollect
//
//  Created by wen on 14-8-2.
//  Copyright (c) 2014年 wen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFTCollectModel.h"
#import "XFTCustomLabel.h"
@interface XFTSuperViewController : UIViewController
@property(nonatomic,strong) UIScrollView *scrollView;
@property(nonatomic,strong) XFTCollectModel *collectModel;
@property(nonatomic,strong) UIView *separatorLineView;
@property(nonatomic,strong) XFTCustomLabel *collectTimeLabel;
- (void)tapAddTag;
- (void)updateViewWithCollectModel:(XFTCollectModel *)collectModel;
@end
