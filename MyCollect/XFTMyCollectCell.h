//
//  MyCollectCell.h
//  MyCollect
//
//  Created by john on 14-7-31.
//  Copyright (c) 2014年 john. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFTCustomLabel.h"
#import "DNSSwipeableCell.h"
#import "XFTCollectItem.h"
@interface XFTMyCollectCell : DNSSwipeableCell
@property(nonatomic,strong)UIImageView      *headeImageView;//头像
@property(nonatomic,strong)XFTCustomLabel   *nickNameLabel;//昵称
@property(nonatomic,strong)XFTCustomLabel   *collectedTimeLabel;//收藏时间

@end
