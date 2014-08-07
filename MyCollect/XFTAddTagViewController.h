//
//  AddTagViewController.h
//  MyCollect
//
//  Created by john on 14-8-4.
//  Copyright (c) 2014年 john. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFTCollectModel.h"
@protocol AddTagDelegate;
@interface XFTAddTagViewController : UIViewController
@property(nonatomic,assign)id <AddTagDelegate>delegate;
@property(nonatomic,strong)XFTCollectModel *collectModel;
- (void)updateTagViewWithCollectModel:(XFTCollectModel*)model;
@end

@protocol AddTagDelegate <NSObject>
@optional
- (void)tagEditFinished:(NSArray *)tagArray;

@end