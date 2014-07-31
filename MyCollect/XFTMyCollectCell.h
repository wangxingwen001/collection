//
//  MyCollectCell.h
//  MyCollect
//
//  Created by john on 14-7-31.
//  Copyright (c) 2014年 john. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFTCustomLabel.h"
typedef NS_ENUM(NSInteger, XFTCollectionType)
{
    XFTTextCollctionType,
    XFTPictureCollctionType,
    XFTVideoCollctionType,
    XFTVoiceCollctionType,
    XFTLocationCollctionType,
    XFTCountType
};
@interface XFTMyCollectCell : UITableViewCell
@property(nonatomic,strong)UIImageView      *headeImageView;
@property(nonatomic,strong)XFTCustomLabel   *nickNameLabel;
@property(nonatomic,strong)XFTCustomLabel   *collectedTimeLabel;
@property(nonatomic,strong)XFTCustomLabel   *contentTextLabel;
@property(nonatomic,strong)UIImageView      *photoImageView;
@property(nonatomic,strong)XFTCustomLabel   *photoTextLabel;
@property(nonatomic,strong)UIImageView      *videoImageView1;
@property(nonatomic,strong)UIImageView      *videoImageView2;
@property(nonatomic,strong)XFTCustomLabel   *videoTitle;
@property(nonatomic,strong)XFTCustomLabel   *videoTimeLabel;
@property(nonatomic,strong)UIImageView      *voiceImageView;
@property(nonatomic,strong)XFTCustomLabel   *voiceTimeLabel;
@property(nonatomic,strong)UIImageView      *mapImageView;
@property(nonatomic,strong)XFTCustomLabel   *mapDetailLabel;
@property(nonatomic,strong)XFTCustomLabel   *mapLabel;


@property (nonatomic,assign)XFTCollectionType type;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier collectionType:(XFTCollectionType)myType;
@end
