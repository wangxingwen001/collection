//
//  XFTTextCell.h
//  MyCollect
//
//  Created by john on 14-8-1.
//  Copyright (c) 2014年 john. All rights reserved.
//

#import "XFTMyCollectCell.h"

@interface XFTTextCell : XFTMyCollectCell
@property(nonatomic,strong)XFTCustomLabel   *contentTextLabel;//文本标签
- (XFTTextCell*)loadCellWithCell:(XFTTextCell*)cell collectItem:(XFTCollectItem*)collectItem;
@end
