//
//  XFTVoiceViewController.m
//  MyCollect
//
//  Created by wen on 14-8-2.
//  Copyright (c) 2014年 wen. All rights reserved.
//

#import "XFTVoiceViewController.h"

@interface XFTVoiceViewController ()
@property(nonatomic,strong) UIProgressView *progressView;
@property(nonatomic,strong) NSTimer *timer;
@property(nonatomic,strong) XFTCustomLabel *playTimeLabel;
@property(nonatomic,assign)BOOL isPlaying;
@property(nonatomic,strong) UIImageView *headImageView;
@property(nonatomic,strong) XFTCustomLabel *nickNameLabel;
@property(nonatomic,strong) XFTCustomLabel *collectTimeLabel;
@property(nonatomic,assign)NSInteger voiceTimer;
@end

@implementation XFTVoiceViewController

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
    UIButton *button = (UIButton*)[self.view viewWithTag:100];
    [button setImage:[UIImage imageNamed:@"Fav_detail_voice_play"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"Fav_detail_voice_playHL"] forState:UIControlStateHighlighted];
    self.headImageView.image = [UIImage imageNamed:collectModel.headImageUrl];
    self.nickNameLabel.text = collectModel.nickName;
    self.playTimeLabel.text = @"0:15";
    self.collectTimeLabel.text = collectModel.collectTime;
    self.voiceTimer = 15;
    self.progressView.progress = 0;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:0.933 green:0.949 blue:0.961 alpha:1];
    self.navigationItem.title = @"详情";
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height - (IOS7_OR_LATER?64:44))];
    scrollView.backgroundColor = [UIColor colorWithRed:0.933 green:0.949 blue:0.961 alpha:1];
    scrollView.contentSize = CGSizeMake(MainSreenWidth, MainSreenHeight-44);
    scrollView.scrollEnabled = YES;
    [self.view addSubview:scrollView];
    
    
    
    //分割线
    UIView *separatorView1 = [[UIView alloc] initWithFrame:CGRectMake(15, 0, 290, 0.5)];
    separatorView1.backgroundColor = [UIColor colorWithRed:209.0/255.0 green:209.0/255.0 blue:209.0/255.0 alpha:1];
    [scrollView addSubview:separatorView1];
    
    self.headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 40, 40)];
    [scrollView addSubview:self.headImageView];
    
    self.nickNameLabel = [[XFTCustomLabel alloc] initWithFrame:CGRectMake(62.5, 15, MainSreenWidth-75, 20) TextFont:15 textColor:[UIColor blackColor] textAliment:NSTextAlignmentLeft text:nil backGroundColor:[UIColor clearColor]];
    [scrollView addSubview:self.nickNameLabel];
    
    UIButton *tagButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [tagButton setFrame:CGRectMake(5, 61, 40, 40)];
    [tagButton setImage:[UIImage imageNamed:@"location_tag_icon"] forState:UIControlStateNormal];
    [tagButton addTarget:self action:@selector(tapAddTag) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:tagButton];
    
    XFTCustomLabel *tapLabel = [[XFTCustomLabel alloc] initWithFrame:CGRectMake(40, 75.5, 60, 10) TextFont:10 textColor:[UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1] textAliment:NSTextAlignmentLeft text:@"轻触添加标签" backGroundColor:[UIColor clearColor]];
    [scrollView addSubview:tapLabel];
    
    UIView *separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(15, 97, MainSreenWidth-30, 1.0)];
    [separatorLineView setBackgroundColor:[UIColor colorWithRed:209.0/255.0 green:209.0/255.0 blue:209.0/255.0 alpha:1]];
    [scrollView addSubview:separatorLineView];
    
    UIView *playerView = [[UIView alloc] initWithFrame:CGRectMake(0, 140, MainSreenWidth, 50)];
    playerView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:playerView];
    
    UIButton *playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    playButton.tag = 100;
    [playButton setImage:[UIImage imageNamed:@"Fav_detail_voice_play"] forState:UIControlStateNormal];
    [playButton setImage:[UIImage imageNamed:@"Fav_detail_voice_playHL"] forState:UIControlStateHighlighted];
    playButton.frame = CGRectMake(22, 9, 32, 32);
    [playButton addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
    [playerView addSubview:playButton];
    
    self.playTimeLabel = [[XFTCustomLabel alloc] initWithFrame:CGRectMake(54, 15, 42, 20) TextFont:13 textColor:[UIColor grayColor] textAliment:NSTextAlignmentCenter text:nil backGroundColor:[UIColor clearColor]];
    [playerView addSubview:self.playTimeLabel];
    
    self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(96, 23, MainSreenWidth-111, 4)];
    if(IOS7_OR_LATER)
    self.progressView.tintColor = [UIColor colorWithRed:0.098 green:0.725 blue:0.196 alpha:1];
    self.progressView.progress = 0;
    [playerView addSubview:self.progressView];
    
    
    self.collectTimeLabel = [[XFTCustomLabel alloc] initWithFrame:CGRectMake(15, 215, 100, 10) TextFont:10 textColor:[UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1] textAliment:NSTextAlignmentLeft text:nil backGroundColor:[UIColor clearColor]];
    [scrollView addSubview:self.collectTimeLabel];
    
    [self updateViewWithCollectModel:self.collectModel];
}

- (void)pressBtn:(UIButton *)button
{
    if (!self.isPlaying)
    {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerRepeat:) userInfo:nil repeats:YES];
        [button setImage:[UIImage imageNamed:@"Fav_detail_voice_pause"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"Fav_detail_voice_pauseHL"] forState:UIControlStateHighlighted];
        self.isPlaying = YES;
    }
    else
    {
        [self.timer invalidate];
        [button setImage:[UIImage imageNamed:@"Fav_detail_voice_play"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"Fav_detail_voice_playHL"] forState:UIControlStateHighlighted];
        self.isPlaying = NO;
    }
}

- (void)timerRepeat:(NSTimer*)timer
{
    
    
    if(self.voiceTimer < 0)
    {
        [timer invalidate];
        UIButton *button = (UIButton*)[self.view viewWithTag:100];
        [button setImage:[UIImage imageNamed:@"Fav_detail_voice_play"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"Fav_detail_voice_playHL"] forState:UIControlStateHighlighted];
        self.voiceTimer = 15;
        self.playTimeLabel.text = [NSString stringWithFormat:@"%d:%d",self.voiceTimer/60,self.voiceTimer%60];
        self.progressView.progress = 0;
        self.isPlaying = NO;
    }
    
    self.playTimeLabel.text = [NSString stringWithFormat:@"%d:%d",self.voiceTimer/60,self.voiceTimer%60];
    if(self.voiceTimer < 15)
    self.progressView.progress += 14/210.0;
    self.voiceTimer --;
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
