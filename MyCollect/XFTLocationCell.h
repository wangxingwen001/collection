//
//  XFTMapCell.h
//  MyCollect
//
//  Created by john on 14-8-1.
//  Copyright (c) 2014年 john. All rights reserved.
//

#import "XFTMyCollectCell.h"

@interface XFTLocationCell : XFTMyCollectCell
@property(nonatomic,strong)UIImageView      *mapImageView;
@property(nonatomic,strong)XFTCustomLabel   *mapDetailLabel;//地理位置详情
@property(nonatomic,strong)XFTCustomLabel   *mapLabel;//地理位置
@end
