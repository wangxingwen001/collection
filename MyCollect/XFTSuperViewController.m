//
//  XFTSuperViewController.m
//  MyCollect
//
//  Created by wen on 14-8-2.
//  Copyright (c) 2014年 wen. All rights reserved.
//

#import "XFTSuperViewController.h"
#import "XFTAddTagViewController.h"
@interface XFTSuperViewController ()<AddTagDelegate>
@property(nonatomic,strong) UIImageView *headImageView;
@property(nonatomic,strong) XFTCustomLabel *nickNameLabel;
@property(nonatomic,strong) XFTCustomLabel *tapLabel;
@property(nonatomic,strong) XFTAddTagViewController *addTagViewController;

@end

@implementation XFTSuperViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (id)init
{
    if(self = [super init])
    {
        self.view.backgroundColor = [UIColor whiteColor];
        self.navigationItem.title = @"详情";
        
        UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:10 target:self action:@selector(backHome)];
        
        leftBarButton.tintColor = [UIColor whiteColor];
        leftBarButton.title = @"返回";
        self.navigationItem.leftBarButtonItem = leftBarButton;
    }
    return self;
}
- (void)updateViewWithCollectModel:(XFTCollectModel *)collectModel
{
    self.collectModel = collectModel;
    
    self.scrollView.contentOffset = CGPointMake(0, 0);
    
    self.headImageView.image = [UIImage imageNamed:collectModel.headImageUrl];
    self.nickNameLabel.text = collectModel.nickName;
    if(collectModel.collectTagArray.count > 0)
    {
        NSMutableString *tags = [[NSMutableString alloc] initWithCapacity:0];
        for(int i =0 ;i < collectModel.collectTagArray.count;i ++)
        {
            NSString *tag = collectModel.collectTagArray[i];
            [tags appendString:tag];
            if(i < collectModel.collectTagArray.count-1)
            {
                [tags appendString:@"，"];
            }
            
        }
        self.tapLabel.text = tags;
        self.tapLabel.textColor = TAG_COLOR_GREEN;
        CGFloat tagH = [tags calulateHeightForOneLyricStr_SDK:tags FontType:self.tapLabel.font RowWidth:MainSreenWidth-80];
        CGRect frame = self.tapLabel.frame;
        frame.size.height = tagH;
        self.tapLabel.frame = frame;
        frame = self.separatorLineView.frame;
        frame.origin.y  = self.tapLabel.frame.origin.y + self.tapLabel.frame.size.height + 9;
        self.separatorLineView.frame = frame;
    }
    else
    {
        self.tapLabel.text = @"添加标签";
        self.tapLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1];
        self.tapLabel.frame = CGRectMake(40, 75.5, MainSreenWidth-80, 10);
    }
    CGRect frame  = self.separatorLineView.frame;
    frame.origin.y  = self.tapLabel.frame.origin.y + self.tapLabel.frame.size.height + 9;
    self.separatorLineView.frame = frame;
    self.collectTimeLabel.text = collectModel.collectTime;
    
}
- (void)backHome
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"详情";
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height - (IOS7_OR_LATER?64:44))];
    self.scrollView.backgroundColor = [UIColor colorWithRed:0.933 green:0.949 blue:0.961 alpha:1];
    self.scrollView.contentSize = CGSizeMake(MainSreenWidth, MainSreenHeight);
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
    
    self.tapLabel = [[XFTCustomLabel alloc] initWithFrame:CGRectMake(40, 75.5, MainSreenWidth-80, 10) TextFont:10 textColor:[UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1] textAliment:NSTextAlignmentLeft text:@"轻触添加标签" backGroundColor:[UIColor clearColor]];
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAddTag)];
    self.tapLabel.lineBreakMode = NSLineBreakByCharWrapping;
    self.tapLabel.numberOfLines = 0;
    self.tapLabel.userInteractionEnabled = YES;
    [self.tapLabel addGestureRecognizer:tapGes];
    [self.scrollView addSubview:self.tapLabel];
    
    self.separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(15, 97, MainSreenWidth-30, 0.5)];
    [self.separatorLineView setBackgroundColor:[UIColor colorWithRed:209.0/255.0 green:209.0/255.0 blue:209.0/255.0 alpha:1]];
    [self.scrollView addSubview:self.separatorLineView];
    
    self.collectTimeLabel = [[XFTCustomLabel alloc] initWithFrame:CGRectMake(15, 145, 100, 10) TextFont:10 textColor:[UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1] textAliment:NSTextAlignmentLeft text:nil backGroundColor:[UIColor clearColor]];
    [self.scrollView addSubview:self.collectTimeLabel];
}
- (void)tapAddTag
{
    if(!self.addTagViewController)
    {
        self.addTagViewController = [[XFTAddTagViewController alloc] init];
        self.addTagViewController.collectModel = self.collectModel;
    }
    else
    {
        [self.addTagViewController updateTagViewWithCollectModel:self.collectModel];
    }
    self.addTagViewController.delegate = self;
    [self presentViewController:self.addTagViewController animated:YES completion:nil];
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
