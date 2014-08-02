//
//  XFTVideoCell.h
//  MyCollect
//
//  Created by john on 14-8-1.
//  Copyright (c) 2014年 john. All rights reserved.
//

#import "XFTMyCollectCell.h"

@interface XFTVideoCell : XFTMyCollectCell
@property(nonatomic,strong)UIImageView      *videoImageView1;//视频图片
@property(nonatomic,strong)UIImageView      *videoImageView2;//视频播放
@property(nonatomic,strong)XFTCustomLabel   *videoTitle;//视频标题
@property(nonatomic,strong)XFTCustomLabel   *videoTimeLabel;//视频时长
@end
