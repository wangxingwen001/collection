//
//  RootViewController.m
//  MyCollect
//
//  Created by john on 14-8-7.
//  Copyright (c) 2014年 john. All rights reserved.
//

#import "RootViewController.h"
#import "DisPlayView.h"
@interface RootViewController ()<DisPlayViewDelegate>
@property(nonatomic,strong)UIScrollView *scrollView;
@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0.906 green:0.906 blue:0.906 alpha:1];
    DisPlayView *disPlayView = [[DisPlayView alloc] initWithFrame:self.view.bounds];
    disPlayView.delegate = self;
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, MainSreenWidth, MainSreenHeight)];
    
    self.scrollView.contentSize = CGSizeMake(MainSreenWidth, disPlayView.frame.size.height);
    [self.scrollView addSubview:disPlayView];
    
    [self.view addSubview:self.scrollView];
}
- (void)tagBtnClick:(UIButton *)btn
{
    NSLog(@"btn.currentTitle===%@",btn.currentTitle);
    
}
- (void)disPlayButtonClick:(UIButton *)btn
{
    switch (btn.tag) {
        case 100:
        {
            NSLog(@"link");
        }
            break;
        case 101:
        {
            NSLog(@"picture");
        }
            break;
        case 102:
        {
            NSLog(@"voice");
        }
            break;
        case 103:
        {
            NSLog(@"music");
        }
            break;
        case 104:
        {
            NSLog(@"video");
        }
            break;
        default:
            break;
    }
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
