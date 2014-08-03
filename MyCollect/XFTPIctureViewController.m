//
//  XFTPIctureViewController.m
//  MyCollect
//
//  Created by wen on 14-8-2.
//  Copyright (c) 2014年 wen. All rights reserved.
//

#import "XFTPictureViewController.h"

@interface XFTPictureViewController ()

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0.933 green:0.949 blue:0.961 alpha:1];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height - 64)];
    scrollView.backgroundColor = [UIColor colorWithRed:0.933 green:0.949 blue:0.961 alpha:1];
    scrollView.contentSize = CGSizeMake(MainSreenWidth, MainSreenHeight-44);
    scrollView.scrollEnabled = YES;
    [self.view addSubview:scrollView];
    
    UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 40, 40)];
    [headImageView setImage:[UIImage imageNamed:self.collectItem.headImageUrl]];
    [scrollView addSubview:headImageView];
    
    XFTCustomLabel *nickNameLabel = [[XFTCustomLabel alloc] initWithFrame:CGRectMake(62.5, 15, MainSreenWidth-75, 20) TextFont:15 textColor:[UIColor blackColor] textAliment:NSTextAlignmentLeft text:self.collectItem.nickName backGroundColor:[UIColor clearColor]];
    [scrollView addSubview:nickNameLabel];
    
    UIButton *tagButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [tagButton setFrame:CGRectMake(5, 61, 40, 40)];
    [tagButton setImage:[UIImage imageNamed:@"location_tag_icon"] forState:UIControlStateNormal];
    [tagButton addTarget:self action:@selector(tapAddTag) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:tagButton];
    
    XFTCustomLabel *tapLabel = [[XFTCustomLabel alloc] initWithFrame:CGRectMake(40, 75.5, 60, 10) TextFont:10 textColor:[UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1] textAliment:NSTextAlignmentLeft text:@"轻触添加标签" backGroundColor:[UIColor clearColor]];
    [scrollView addSubview:tapLabel];
    
    UIView *separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(15, 97, MainSreenWidth-30, 0.5)];
    [separatorLineView setBackgroundColor:[UIColor colorWithRed:209.0/255.0 green:209.0/255.0 blue:209.0/255.0 alpha:1]];
    [scrollView addSubview:separatorLineView];
    UIImage *image = [UIImage imageNamed:self.collectItem.imageUrl];
    CGSize imageSize = image.size;
    UIImageView *pictureImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 112, MainSreenWidth-30, imageSize.height)];
    pictureImageView.contentMode = UIViewContentModeScaleAspectFit;
    pictureImageView.userInteractionEnabled = YES;
    pictureImageView.image = image;
    [scrollView addSubview:pictureImageView];
    
    
    XFTCustomLabel *collectTimeLabel = [[XFTCustomLabel alloc] initWithFrame:CGRectMake(15, pictureImageView.frame.origin.y + pictureImageView.frame.size.height + 25, 100, 10) TextFont:10 textColor:[UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1] textAliment:NSTextAlignmentLeft text:@"收藏于12天前" backGroundColor:[UIColor clearColor]];
    [scrollView addSubview:collectTimeLabel];
    
    
    CGFloat scrollViewHeight = pictureImageView.frame.origin.y + pictureImageView.frame.size.height + 50;
    if(scrollViewHeight > MainSreenHeight)
    {
        scrollView.contentSize = CGSizeMake(MainSreenWidth, scrollViewHeight);
    }
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
