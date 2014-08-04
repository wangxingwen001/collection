//
//  XFTPIctureViewController.m
//  MyCollect
//
//  Created by wen on 14-8-2.
//  Copyright (c) 2014年 wen. All rights reserved.
//

#import "XFTPictureViewController.h"
#import "UIImage+CalHeight.h"
@interface XFTPictureViewController ()
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIImageView *headImageView;
@property(nonatomic,strong)XFTCustomLabel *nickNameLabel;
@property(nonatomic,strong)XFTCustomLabel *collectTimeLabel;
@property(nonatomic,strong)NSMutableArray *imageViewArray;

@end

@implementation XFTPictureViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"详情";
    }
    return self;
}

- (void)updateViewWithCollectModel:(XFTCollectModel *)collectModel
{
    self.collectModel = collectModel;
    self.scrollView.contentOffset = CGPointMake(0, 0);
    self.headImageView.image = [UIImage imageNamed:collectModel.headImageUrl];
    self.nickNameLabel.text = collectModel.nickName;
    
    if(self.imageViewArray.count > 0)
    {
        for(UIImageView *imageView in self.imageViewArray)
        {
            [imageView removeFromSuperview];
        }
        [self.imageViewArray removeAllObjects];
    }
    CGFloat scrollView_y = 115.0f;
    CGFloat scrollViewHeight = 155.0f;
    for(NSString *imageString in collectModel.imageArray)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageString]];
        imageView.frame = CGRectMake(15, scrollView_y, 290, [imageView.image calculateHeightWithWidth:290]);
        imageView.backgroundColor = [UIColor clearColor];
        imageView.contentMode =  UIViewContentModeScaleAspectFit & UIViewContentModeLeft;
        scrollView_y += imageView.frame.size.height + PICTURE_SEPARATOR;
        [self.scrollView addSubview:imageView];
        scrollViewHeight +=(imageView.frame.size.height + PICTURE_SEPARATOR);
        [self.imageViewArray addObject:imageView];
    }
    if(scrollViewHeight > MainSreenHeight)
    {
        self.scrollView.contentSize = CGSizeMake(MainSreenWidth, scrollViewHeight);
    }
    else
    {
        self.scrollView.contentSize = CGSizeMake(MainSreenWidth, MainSreenHeight-24);
    }

    self.collectTimeLabel.frame = CGRectMake(15, self.scrollView.contentSize.height-10-PICTURE_SEPARATOR, MainSreenWidth-30, 10);
    self.collectTimeLabel.text = collectModel.collectTime;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.imageViewArray = [[NSMutableArray alloc] initWithCapacity:0];
    self.view.backgroundColor = [UIColor colorWithRed:0.933 green:0.949 blue:0.961 alpha:1];
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height - (IOS7_OR_LATER?64:44))];
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView.contentSize = CGSizeMake(MainSreenWidth, MainSreenHeight-24);
    self.scrollView.scrollEnabled = YES;
    [self.view addSubview:self.scrollView];
    
    //分割线
    UIView *separatorView1 = [[UIView alloc] initWithFrame:CGRectMake(15, 0, 290, 0.5)];
    separatorView1.backgroundColor = [UIColor colorWithRed:209.0/255.0 green:209.0/255.0 blue:209.0/255.0 alpha:1];
    [self.scrollView addSubview:separatorView1];
    
    self.headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 40, 40)];
    [self.scrollView addSubview:self.headImageView];
    
    self.nickNameLabel = [[XFTCustomLabel alloc] initWithFrame:CGRectMake(62.5, 15, MainSreenWidth-75, 20) TextFont:15 textColor:[UIColor blackColor] textAliment:NSTextAlignmentLeft text:self.collectModel.nickName backGroundColor:[UIColor clearColor]];
    [self.scrollView addSubview:self.nickNameLabel];
    
    UIButton *tagButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [tagButton setFrame:CGRectMake(5, 61, 40, 40)];
    [tagButton setImage:[UIImage imageNamed:@"location_tag_icon"] forState:UIControlStateNormal];
    [tagButton addTarget:self action:@selector(tapAddTag) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:tagButton];
    
    XFTCustomLabel *tapLabel = [[XFTCustomLabel alloc] initWithFrame:CGRectMake(40, 75.5, 60, 10) TextFont:10 textColor:[UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1] textAliment:NSTextAlignmentLeft text:@"轻触添加标签" backGroundColor:[UIColor clearColor]];
    [self.scrollView addSubview:tapLabel];
    
    UIView *separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(15, 97, MainSreenWidth-30, 1)];
    [separatorLineView setBackgroundColor:[UIColor colorWithRed:209.0/255.0 green:209.0/255.0 blue:209.0/255.0 alpha:1]];
    [self.scrollView addSubview:separatorLineView];
    
    self.collectTimeLabel = [[XFTCustomLabel alloc] initWithFrame:CGRectMake(15, 115, 100, 10) TextFont:10 textColor:[UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1] textAliment:NSTextAlignmentLeft text:nil backGroundColor:[UIColor clearColor]];
    [self.scrollView addSubview:self.collectTimeLabel];
    
    [self updateViewWithCollectModel:self.collectModel];
}

#pragma mark 添加标签
- (void)tapAddTag
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
