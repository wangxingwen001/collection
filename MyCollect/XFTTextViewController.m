//
//  XFTTextViewController.m
//  MyCollect
//
//  Created by wen on 14-8-2.
//  Copyright (c) 2014年 wen. All rights reserved.
//

#import "XFTTextViewController.h"
#import "NSString+CalHeight.h"
#import "XFTAddTagViewController.h"
@interface XFTTextViewController ()
@property(nonatomic,strong) UIImageView *headImageView;
@property(nonatomic,strong) XFTCustomLabel *nickNameLabel;
@property(nonatomic,strong) XFTCustomLabel *contentLabel;
@property(nonatomic,strong) XFTCustomLabel *collectTimeLabel;
@property(nonatomic,strong) UIScrollView *scrollView;
@end

@implementation XFTTextViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)updateViewWithCollectModel:(XFTCollectModel *)collectModel
{
    self.collectModel = collectModel;
    self.scrollView.contentOffset = CGPointMake(0, 0);

    self.headImageView.image = [UIImage imageNamed:collectModel.headImageUrl];
    self.nickNameLabel.text = collectModel.nickName;
    self.collectTimeLabel.text = collectModel.collectTime;
    
    CGFloat contentHeight = [collectModel.content calulateHeightForOneLyricStr_SDK:collectModel.content FontType:[UIFont systemFontOfSize:15] RowWidth:MainSreenWidth-30];
    self.contentLabel.frame = CGRectMake(15, 120, MainSreenWidth-30, contentHeight);
    self.contentLabel.text = collectModel.content;
    
    
    CGFloat scrollViewHeight = self.contentLabel.frame.origin.y + contentHeight + 55;
    if(scrollViewHeight > MainSreenHeight)
    {
        self.scrollView.contentSize = CGSizeMake(MainSreenWidth, scrollViewHeight);
    }
    self.collectTimeLabel.frame = CGRectMake(15, self.scrollView.contentSize.height-20, 100, 10);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"详情";
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height - (IOS7_OR_LATER?64:44))];
    self.scrollView.backgroundColor = [UIColor colorWithRed:0.933 green:0.949 blue:0.961 alpha:1];
    self.scrollView.contentSize = CGSizeMake(MainSreenWidth, MainSreenHeight-44);
    self.scrollView.scrollEnabled = YES;
    [self.view addSubview:self.scrollView];
    
    //分割线
    UIView *separatorView1 = [[UIView alloc] initWithFrame:CGRectMake(15, 0, 290, 1.0)];
    separatorView1.backgroundColor = [UIColor colorWithRed:209.0/255.0 green:209.0/255.0 blue:209.0/255.0 alpha:1];
    [self.scrollView addSubview:separatorView1];
    
    self.headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 40, 40)];
    [self.scrollView addSubview:self.headImageView];
    
    self.nickNameLabel = [[XFTCustomLabel alloc] initWithFrame:CGRectMake(62.5, 15, MainSreenWidth-75, 20) TextFont:15 textColor:[UIColor blackColor] textAliment:NSTextAlignmentLeft text:nil backGroundColor:[UIColor clearColor]];
    [self.scrollView addSubview:self.nickNameLabel];
    
    UIButton *tapButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [tapButton setFrame:CGRectMake(5, 61, 40, 40)];
    [tapButton setImage:[UIImage imageNamed:@"location_tag_icon"] forState:UIControlStateNormal];
    [tapButton addTarget:self action:@selector(tapAddTag) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:tapButton];
    
    XFTCustomLabel *tapLabel = [[XFTCustomLabel alloc] initWithFrame:CGRectMake(40, 75.5, 60, 10) TextFont:10 textColor:[UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1] textAliment:NSTextAlignmentLeft text:@"轻触添加标签" backGroundColor:[UIColor clearColor]];
    [self.scrollView addSubview:tapLabel];
    
    UIView *separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(15, 97, MainSreenWidth-30, 0.5)];
    [separatorLineView setBackgroundColor:[UIColor colorWithRed:209.0/255.0 green:209.0/255.0 blue:209.0/255.0 alpha:1]];
    [self.scrollView addSubview:separatorLineView];
    
    self.contentLabel = [[XFTCustomLabel alloc] initWithFrame:CGRectMake(15, 120, MainSreenWidth-30, 0) TextFont:15 textColor:[UIColor blackColor] textAliment:NSTextAlignmentLeft text:self.collectModel.content backGroundColor:[UIColor clearColor]];
    [self.scrollView addSubview:self.contentLabel];
    
    self.collectTimeLabel = [[XFTCustomLabel alloc] initWithFrame:CGRectMake(15, 145, 100, 10) TextFont:10 textColor:[UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1] textAliment:NSTextAlignmentLeft text:nil backGroundColor:[UIColor clearColor]];
    [self.scrollView addSubview:self.collectTimeLabel];
    
    [self updateViewWithCollectModel:self.collectModel];
    
}
#pragma mark 添加标签
- (void)tapAddTag
{
    XFTAddTagViewController *addTagViewController = [[XFTAddTagViewController alloc] init];
    [self presentViewController:addTagViewController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recre、ated.
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
