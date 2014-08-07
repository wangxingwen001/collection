//
//  XFTVoiceViewController.m
//  MyCollect
//
//  Created by wen on 14-8-2.
//  Copyright (c) 2014年 wen. All rights reserved.
//

#import "XFTVoiceViewController.h"
#import "XFTAddTagViewController.h"
@interface XFTVoiceViewController ()
@property(nonatomic,strong) UIProgressView *progressView;
@property(nonatomic,strong) NSTimer *timer;
@property(nonatomic,strong) XFTCustomLabel *playTimeLabel;
@property(nonatomic,assign)BOOL isPlaying;
@property(nonatomic,strong) UIImageView *headImageView;
@property(nonatomic,strong) XFTCustomLabel *nickNameLabel;
@property(nonatomic,strong) XFTCustomLabel *collectTimeLabel;
@property(nonatomic,assign)NSInteger voiceTimer;
@property(nonatomic,strong) XFTAddTagViewController *addTagViewController;
@property(nonatomic,strong) UIView *playerView;
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
    [super updateViewWithCollectModel:collectModel];
    
    UIButton *button = (UIButton*)[self.view viewWithTag:100];
    [button setImage:[UIImage imageNamed:@"Fav_detail_voice_play"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"Fav_detail_voice_playHL"] forState:UIControlStateHighlighted];
    
    
    CGFloat playerView_Y = self.separatorLineView.frame.origin.y + 44;
    
    CGRect frame = self.playerView.frame;
    frame.origin.y = playerView_Y ;
    self.playerView.frame = frame;
    
    frame = self.collectTimeLabel.frame;
    
    frame.origin.y = self.playerView.frame.origin.y + self.playerView.frame.size.height + 25;
    self.collectTimeLabel.frame = frame;
    
    self.playTimeLabel.text = @"0:15";
    self.voiceTimer = 15;
    self.progressView.progress = 0;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGFloat playerView_Y = self.separatorLineView.frame.origin.y + 44;
    
    self.playerView = [[UIView alloc] initWithFrame:CGRectMake(0, playerView_Y, MainSreenWidth, 50)];
    self.playerView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:self.playerView];
    
    UIButton *playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    playButton.tag = 100;
    [playButton setImage:[UIImage imageNamed:@"Fav_detail_voice_play"] forState:UIControlStateNormal];
    [playButton setImage:[UIImage imageNamed:@"Fav_detail_voice_playHL"] forState:UIControlStateHighlighted];
    playButton.frame = CGRectMake(22, 9, 32, 32);
    [playButton addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.playerView addSubview:playButton];
    
    self.playTimeLabel = [[XFTCustomLabel alloc] initWithFrame:CGRectMake(54, 15, 42, 20) TextFont:13 textColor:[UIColor grayColor] textAliment:NSTextAlignmentCenter text:nil backGroundColor:[UIColor clearColor]];
    [self.playerView addSubview:self.playTimeLabel];
    
    self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(96, 23, MainSreenWidth-111, 4)];
    if(IOS7_OR_LATER)
    self.progressView.tintColor = [UIColor colorWithRed:0.098 green:0.725 blue:0.196 alpha:1];
    self.progressView.progress = 0;
    [self.playerView addSubview:self.progressView];

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


- (void)tagEditFinished:(NSArray *)tagArray
{
    for(NSString *tag in tagArray)
    {
        NSLog(@"%@",tag);
    }
    self.collectModel.collectTagArray = tagArray;
    [self updateViewWithCollectModel:self.collectModel];
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
