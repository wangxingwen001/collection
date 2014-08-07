//
//  XFTCollectItem.h
//  MyCollect
//
//  Created by john on 14-7-31.
//  Copyright (c) 2014年 john. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XFTCollectModel : NSObject
@property(nonatomic,assign)NSInteger type;
@property(nonatomic,strong)NSString *content;
@property(nonatomic,strong)NSString *headImageUrl;
@property(nonatomic,strong)NSString *nickName;
@property(nonatomic,strong)NSString *imageUrl;
@property(nonatomic,strong)NSString *collectTime;
@property(nonatomic,strong)NSMutableArray *imageArray;
@property(nonatomic,strong)NSArray*collectTagArray;
@property(nonatomic,strong)NSArray *myTagArray;
@end
