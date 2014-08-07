//
//  XFTPIctureViewController.m
//  MyCollect
//
//  Created by wen on 14-8-2.
//  Copyright (c) 2014年 wen. All rights reserved.
//

#import "XFTPictureViewController.h"
#import "UIImage+CalHeight.h"
#import "XFTAddTagViewController.h"
@interface XFTPictureViewController ()
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIImageView *headImageView;
@property(nonatomic,strong)XFTCustomLabel *nickNameLabel;
@property(nonatomic,strong)NSMutableArray *imageViewArray;
@property(nonatomic,strong) XFTAddTagViewController *addTagViewController;
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
    [super updateViewWithCollectModel:collectModel];
    
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
    CGFloat scrollView_y = self.separatorLineView.frame.origin.y + 25;
    CGFloat scrollViewHeight = scrollView_y+50;
    
    for(NSString *imageString in collectModel.imageArray)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageString]];
        imageView.frame = CGRectMake(15, scrollView_y, 290, [imageView.image calculateHeightWithWidth:290]);
        imageView.backgroundColor = [UIColor clearColor];
        imageView.contentMode =  UIViewContentModeScaleAspectFit & UIViewContentModeLeft;
        scrollView_y += imageView.frame.size.height + PICTURE_SEPARATOR;
        [self.scrollView addSubview:imageView];
        scrollViewHeight += (imageView.frame.size.height + PICTURE_SEPARATOR);
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

    self.collectTimeLabel.frame = CGRectMake(15, self.scrollView.contentSize.height-25, MainSreenWidth-30, 10);
    self.collectTimeLabel.text = collectModel.collectTime;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.imageViewArray = [[NSMutableArray alloc] initWithCapacity:0];
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
