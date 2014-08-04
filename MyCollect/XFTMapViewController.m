//
//  XFTMapViewController.m
//  MyCollect
//
//  Created by wen on 14-8-2.
//  Copyright (c) 2014年 wen. All rights reserved.
//

#import "XFTMapViewController.h"

@interface XFTMapViewController ()

@end

@implementation XFTMapViewController

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
    
    UIButton *tagButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [tagButton1 setFrame:CGRectMake(5, 330, 40, 40)];
    [tagButton1 setImage:[UIImage imageNamed:@"location_tag_icon"] forState:UIControlStateNormal];
    tagButton1.tag = 1;
    [tagButton1 addTarget:self action:@selector(tapAddTag:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tagButton1];
    
    XFTCustomLabel *tapLabel = [[XFTCustomLabel alloc] initWithFrame:CGRectMake(45, 345, 60, 10) TextFont:10 textColor:[UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1] textAliment:NSTextAlignmentLeft text:@"轻触添加标签" backGroundColor:[UIColor clearColor]];
    [self.view addSubview:tapLabel];
    
    UIView *separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(15, 370, MainSreenWidth-30, 0.5)];
    [separatorLineView setBackgroundColor:[UIColor colorWithRed:209.0/255.0 green:209.0/255.0 blue:209.0/255.0 alpha:1]];
    [self.view addSubview:separatorLineView];
    
    UIButton *tagButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [tagButton2 setFrame:CGRectMake(5, 375, 40, 40)];
    [tagButton2 setImage:[UIImage imageNamed:@"location_tag_icon"] forState:UIControlStateNormal];
    tagButton2.tag = 2;
    [tagButton2 addTarget:self action:@selector(tapAddTag:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tagButton2];
    
    XFTCustomLabel *tapLabel1 = [[XFTCustomLabel alloc] initWithFrame:CGRectMake(45, 390, 60, 10) TextFont:10 textColor:[UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1] textAliment:NSTextAlignmentLeft text:@"轻触添加标签" backGroundColor:[UIColor clearColor]];
    [self.view addSubview:tapLabel1];
    
}
#pragma mark 添加标签
- (void)tapAddTag:(UIButton*)btnp
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
