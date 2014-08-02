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
@property(nonatomic,strong)UIImageView      *headeImageView;
@property(nonatomic,strong)XFTCustomLabel   *nickNameLabel;
@property(nonatomic,strong)XFTCustomLabel   *collectedTimeLabel;

@end
