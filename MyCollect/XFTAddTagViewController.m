//
//  AddTagViewController.m
//  MyCollect
//
//  Created by john on 14-8-4.
//  Copyright (c) 2014年 john. All rights reserved.
//

#import "XFTAddTagViewController.h"
#import "XFTTagWriteView.h"
@interface XFTAddTagViewController ()
@property(nonatomic,strong) XFTTagWriteView *tagWriteView;
@end

@implementation XFTAddTagViewController

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
    self.view.backgroundColor = [UIColor colorWithRed:0.933 green:0.949 blue:0.961 alpha:1];
    UIView *navigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainSreenWidth, IOS7_OR_LATER?64:44)];
    navigationView.backgroundColor = [UIColor colorWithRed:0.094 green:0.557 blue:0.800 alpha:1]
    ;
    [self.view addSubview:navigationView];
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(5, navigationView.frame.size.height-40, 44, 44);
    leftButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [leftButton setTitle:@"取消" forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [navigationView addSubview:leftButton];
    
    XFTCustomLabel *titleLabel = [[XFTCustomLabel alloc] initWithFrame:CGRectMake(49, navigationView.frame.size.height-30, MainSreenWidth-98, 20) TextFont:17 textColor:[UIColor whiteColor] textAliment:NSTextAlignmentCenter text:@"编辑标签" backGroundColor:[UIColor clearColor]];
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [navigationView addSubview:titleLabel];
    
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(MainSreenWidth-49, navigationView.frame.size.height-40, 44, 44);
    rightButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [rightButton setTitle:@"完成" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor colorWithRed:0.059 green:0.741 blue:0.008 alpha:1] forState:UIControlStateNormal];
    rightButton.userInteractionEnabled = NO;
    [rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [navigationView addSubview:rightButton];
    
    
    self.tagWriteView = [[XFTTagWriteView alloc] initWithFrame:CGRectMake(0, navigationView.frame.size.height, MainSreenWidth, MainSreenHeight-navigationView.frame.size.height)];
    self.tagWriteView.font = [UIFont systemFontOfSize:15];
    self.tagWriteView.tagForegroundColor = [UIColor colorWithRed:0.059 green:0.741 blue:0.008 alpha:1];
    self.tagWriteView.tagBackgroundColor = [UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:1];
    self.tagWriteView.myTagColor = [UIColor blackColor];
    [self.tagWriteView updateTag:@[@"高兴",@"快乐",@"悲伤"]];
    [self.tagWriteView updateMyTagView:@[@"高兴",@"快乐",@"悲伤",@"1223",@"123456",@"1212",@"232123"]];
    
    [self.view addSubview:self.tagWriteView];
}
- (void)leftButtonClick:(UIButton*)btn
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.tagWriteView removeNotication:UITextFieldTextDidChangeNotification];
}
- (void)rightButtonClick:(UIButton*)btn
{
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.tagWriteView showKeyBoard:YES];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [self.tagWriteView showKeyBoard:NO];
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
