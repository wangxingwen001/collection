//
//  XFTTextViewController.h
//  MyCollect
//
//  Created by wen on 14-8-2.
//  Copyright (c) 2014年 wen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFTCollectModel.h"
@interface XFTTextViewController : UIViewController
@property(nonatomic,strong)XFTCollectModel *collectModel;
- (void)updateViewWithCollectModel:(XFTCollectModel *)collectModel;
@end
