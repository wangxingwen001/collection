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
@property(nonatomic,strong) XFTAddTagViewController *addTagViewController;

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
    [super updateViewWithCollectModel:collectModel];
//    self.collectModel = collectModel;
    
    NSLog(@"%@",collectModel.collectTime);
    CGFloat contentLabel_Y = self.separatorLineView.frame.origin.y + 25;
    CGFloat contentHeight = [collectModel.content calulateHeightForOneLyricStr_SDK:collectModel.content FontType:[UIFont systemFontOfSize:15] RowWidth:MainSreenWidth-30];
    
    self.contentLabel.frame = CGRectMake(15, contentLabel_Y, MainSreenWidth-30, contentHeight);
    self.contentLabel.text = collectModel.content;
    
    
    CGFloat scrollViewHeight = contentLabel_Y + contentHeight + 55;
    
    if(scrollViewHeight > MainSreenHeight)
    {
        self.scrollView.contentSize = CGSizeMake(MainSreenWidth, scrollViewHeight);
    }
    self.collectTimeLabel.frame = CGRectMake(15, self.contentLabel.frame.size.height + self.contentLabel.frame.origin.y + 25, 100, 10);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.contentLabel = [[XFTCustomLabel alloc] initWithFrame:CGRectMake(15, 120, MainSreenWidth-30, 0) TextFont:15 textColor:[UIColor blackColor] textAliment:NSTextAlignmentLeft text:self.collectModel.content backGroundColor:[UIColor clearColor]];
    [self.scrollView addSubview:self.contentLabel];
    
//    [self updateViewWithCollectModel:self.collectModel];
    
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
