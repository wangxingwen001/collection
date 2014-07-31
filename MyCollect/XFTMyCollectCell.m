//
//  MyCollectCell.m
//  MyCollect
//
//  Created by john on 14-7-31.
//  Copyright (c) 2014年 john. All rights reserved.
//

#import "XFTMyCollectCell.h"
#import "XFTCustomLabel.h"
@interface XFTMyCollectCell ()

@end
@implementation XFTMyCollectCell
@synthesize headeImageView,nickNameLabel,collectedTimeLabel,contentTextLabel,photoImageView,photoTextLabel,videoImageView1,videoImageView2,videoTitle,videoTimeLabel,voiceImageView,voiceTimeLabel,mapImageView,mapDetailLabel,mapLabel,voiceImageView1;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier collectionType:(XFTCollectionType)myType
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        //分割线
        UIView *separatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.5)];
        separatorView.backgroundColor = [UIColor colorWithRed:0.871 green:0.886 blue:0.898 alpha:1];
        [self addSubview:separatorView];
        //头像
        self.headeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 35, 35)];
        self.headeImageView.image = [UIImage imageNamed:@"headImage.jpg"];
        [self addSubview:self.headeImageView];
        //昵称
        self.nickNameLabel = [[XFTCustomLabel alloc] initWithFrame:CGRectMake(55, 7, 200, 20) TextFont:15 textColor:[UIColor blackColor] textAliment:NSTextAlignmentLeft text:@"情人节快乐" backGroundColor:[UIColor clearColor]];
        [self addSubview:self.nickNameLabel];
        //收藏时间
        self.collectedTimeLabel = [[XFTCustomLabel alloc] initWithFrame:CGRectMake(240, 7, 70, 20) TextFont:15 textColor:[UIColor colorWithRed:125.0/255.0 green:125.0/255.0 blue:125.0/255.0 alpha:1] textAliment:NSTextAlignmentRight text:@"14-7-31" backGroundColor:[UIColor clearColor]];
        [self addSubview:self.collectedTimeLabel];
        
        switch (myType) {
            case XFTTextCollctionType:
            {
                [self createTextCell];
            }
                break;
            case XFTPictureCollctionType:
            {
                [self createPictureCell];
            }
                break;
            case XFTVideoCollctionType:
            {
                [self createVideoCell];
            }
                break;
            case XFTVoiceCollctionType:
            {
                [self createVoiceCell];
            }
                break;
            case XFTLocationCollctionType:
            {
                [self createLocationCell];
            }
                break;
            case XFTCountType:
            {
                
            }
                break;
            default:
                break;
        }
    }
    return self;
}

- (void)createTextCell
{
    self.contentTextLabel = [[XFTCustomLabel alloc] initWithFrame:CGRectMake(55, 30, 255, 45) TextFont:14 textColor:[UIColor blackColor] textAliment:NSTextAlignmentLeft text:@"情人节即将到来，祝有情人情人节快乐，没情人的破坏别人的快乐，哈哈哈！！！！" backGroundColor:[UIColor clearColor]];
    self.contentTextLabel.numberOfLines = 2;
    [self addSubview:self.contentTextLabel];
}

- (void)createPictureCell
{
    self.photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(55, 35, 100, 60)];
    self.photoImageView.image = [UIImage imageNamed:@"picture"];
    [self addSubview:self.photoImageView];
    self.photoTextLabel = [[XFTCustomLabel alloc] initWithFrame:CGRectMake(55, 100,255, 20) TextFont:14 textColor:[UIColor colorWithRed:125.0/255.0 green:125.0/255.0 blue:125.0/255.0 alpha:1.0] textAliment:NSTextAlignmentLeft text:@"图片包含:团结湖 下午 上班" backGroundColor:[UIColor clearColor]];
    [self addSubview:self.photoTextLabel];
}

- (void)createVideoCell
{
    CGRect rect = CGRectMake(55, 35, 60, 60);
    self.videoImageView1 = [[UIImageView alloc] initWithFrame:rect];
    self.videoImageView1.image = [UIImage imageNamed:@"photo"];
    [self addSubview:self.videoImageView1];
    rect = CGRectMake(27/2, 27/2, 33, 33);
    self.videoImageView2 = [[UIImageView alloc] initWithFrame:rect];
    self.videoImageView2.image = [UIImage imageNamed:@"playImage"];
    [self.videoImageView1 addSubview:self.videoImageView2];
    
    self.videoTitle = [[XFTCustomLabel alloc] initWithFrame:CGRectMake(125, 30, 80, 20) TextFont:14 textColor:[UIColor blackColor] textAliment:NSTextAlignmentLeft text:@"视频" backGroundColor:[UIColor clearColor]];
    [self addSubview:self.videoTitle];
    self.videoTimeLabel = [[XFTCustomLabel alloc] initWithFrame:CGRectMake(125, 55, 80, 20) TextFont:14 textColor:[UIColor colorWithRed:125.0/255.0 green:125.0/255.0 blue:125.0/255.0 alpha:1] textAliment:NSTextAlignmentLeft text:@"40秒" backGroundColor:[UIColor clearColor]];
    [self addSubview:self.videoTimeLabel];
}


- (void)createVoiceCell
{
    self.voiceImageView = [[UIImageView alloc] initWithFrame:CGRectMake(55, 30, 75, 32)];
    UIImage * image = [[UIImage imageNamed:@"chat_message_other"] resizableImageWithCapInsets:UIEdgeInsetsMake(15, 15, 15, 15)];
    [self.voiceImageView setImage:image];
//    self.voiceImageView.image = [UIImage imageNamed:@"chat_message_other"];
    [self addSubview:self.voiceImageView];
    self.voiceTimeLabel = [[XFTCustomLabel alloc] initWithFrame:CGRectMake(self.voiceImageView.frame.origin.x + 10 + 75, self.voiceImageView.center.y-10, 40, 20) TextFont:14 textColor:[UIColor colorWithRed:125.0/255.0 green:125.0/255.0 blue:125.0/255.0 alpha:1] textAliment:NSTextAlignmentLeft text:@"3\"" backGroundColor:[UIColor clearColor]];
    
    self.voiceImageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(45, 6, 20, 20)];
    self.voiceImageView1.image = [UIImage imageNamed:@"bottleReceiverVoiceNodePlaying"];
    [self.voiceImageView addSubview:self.voiceImageView1];
    [self addSubview:self.voiceTimeLabel];
}

- (void)createLocationCell
{
    self.mapImageView = [[UIImageView alloc] initWithFrame:CGRectMake(55, 35, 60, 60)];
    self.mapImageView.image = [UIImage imageNamed:@"mapImage"];
    [self addSubview:self.mapImageView];
    
    self.mapDetailLabel = [[XFTCustomLabel alloc] initWithFrame:CGRectMake(125, 30, 320-135, 40) TextFont:14 textColor:[UIColor blackColor] textAliment:NSTextAlignmentLeft text:@"朝阳区团结湖东三环北路17号新时代证券大厦803室" backGroundColor:[UIColor clearColor]];
    self.mapDetailLabel.numberOfLines = 2;
    [self addSubview:self.mapDetailLabel];
    
    self.mapLabel = [[XFTCustomLabel alloc] initWithFrame:CGRectMake(125, 65, 40, 20) TextFont:14 textColor:[UIColor colorWithRed:125.0/255.0 green:125.0/255.0 blue:125.0/255.0 alpha:1] textAliment:NSTextAlignmentLeft text:@"位置" backGroundColor:[UIColor clearColor]];
    [self addSubview:self.mapLabel];
    
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
