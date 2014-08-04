//
//  XFTMyCollectViewController.m
//  MyCollect
//
//  Created by john on 14-7-31.
//  Copyright (c) 2014年 john. All rights reserved.
//

#import "XFTMyCollectViewController.h"
#import "XFTMyCollectCell.h"
#import "XFTCollectModel.h"
#import "XFTTextCell.h"
#import "XFTPictureCell.h"
#import "XFTVideoCell.h"
#import "XFTVoiceCell.h"
#import "XFTLocationCell.h"
#import "XFTTextViewController.h"
#import "XFTVoiceViewController.h"
#import "XFTVideoViewController.h"
#import "XFTPictureViewController.h"
#import "XFTMapViewController.h"
@interface XFTMyCollectViewController ()<UITableViewDataSource,UITableViewDelegate,DNSSwipeableCellDataSource,DNSSwipeableCellDelegate>
{
    XFTTextViewController * _textVC;
    XFTVoiceViewController *_voiceVC;
    XFTVideoViewController *_videoVC;
    XFTPictureViewController * _pictureVC;
    XFTMapViewController * _mapVC;
    
}
@property(nonatomic,strong)UITableView *myCollecttableView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *cellsCurrentlyEditing;
@property (nonatomic, strong) NSMutableArray *itemTitles;
@property (nonatomic, strong) NSArray *backgroundColors;
@property (nonatomic, strong) NSArray *textColors;
@property (nonatomic, strong) NSArray *imageNames;
@property(nonatomic,assign)BOOL isOpen;
@property(nonatomic,strong)NSIndexPath *indexPath;

@end

@implementation XFTMyCollectViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)startEdit:(UIBarButtonItem*)barButtonItem
{
    NSLog(@"开始编辑");
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0.933 green:0.949 blue:0.961 alpha:1];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(startEdit:)];
    rightBarButtonItem .tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    
    CGRect rect = self.view.bounds;
    self.myCollecttableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    self.myCollecttableView.delegate = self;
    self.myCollecttableView.dataSource = self;
    self.myCollecttableView.backgroundColor = [UIColor clearColor];
    self.myCollecttableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    self.myCollecttableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.myCollecttableView];
    self.dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < 5; i ++) {
        XFTCollectModel *collectModel = [[XFTCollectModel alloc] init];
        collectModel.imageArray = [[NSMutableArray alloc]initWithCapacity:0];
        for(int i = 0; i < 10;i ++)
        {
            [collectModel.imageArray addObject:[NSString stringWithFormat:@"%d",i]];
        }
        
        collectModel.type = i ;
        collectModel.imageUrl = @"pictureImage";
        collectModel.content = @"我喜欢乡村的天是那么蓝，水是那么清，树是那么绿，山是连绵不断的青；还喜欢那里夜晚的寂静；晚上除了几声狗叫，很少听到其他的噪杂声；那里的夜晚月亮是那么亮，星星也比城市的多、亮。\n我喜欢乡村的天是那么蓝，水是那么清，树是那么绿，山是连绵不断的青；还喜欢那里夜晚的寂静；晚上除了几声狗叫，很少听到其他的噪杂声；那里的夜晚月亮是那么亮，星星也比城市的多、亮。\n我喜欢乡村的天是那么蓝，水是那么清，树是那么绿，山是连绵不断的青；还喜欢那里夜晚的寂静；晚上除了几声狗叫，很少听到其他的噪杂声；那里的夜晚月亮是那么亮，星星也比城市的多、亮。";
        collectModel.nickName = @"朱莉亚罗伯茨";
        collectModel.headImageUrl = @"headImage";
        collectModel.collectTime = @"收藏于12天前";
        [self.dataArray addObject:collectModel];
    }
    self.cellsCurrentlyEditing = [[NSMutableArray alloc] initWithCapacity:0];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XFTCollectModel *collectModel = self.dataArray[indexPath.row];
    XFTMyCollectCell *collectCell = nil;
    switch (collectModel.type) {
        case XFTTextCollctionType:
        {
            static NSString *cell1 = @"cell1";
            XFTTextCell* cell = [tableView dequeueReusableCellWithIdentifier:cell1];
            if(!cell)
            {
                cell = [[XFTTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell1];

            }
            [cell updateCurrecntCellWithModel:collectModel];
            collectCell = cell;
        }
            break;
        case XFTPictureCollctionType:
        {
            static NSString *cell2 = @"cell2";
            XFTPictureCell *cell = [tableView dequeueReusableCellWithIdentifier:cell2];
            if(!cell)
            {
                cell = [[XFTPictureCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell2 ];
            }
            
            collectCell = cell;
        }
            break;
        case XFTVideoCollctionType:
        {
            static NSString *cell3 = @"cell3";
            XFTVideoCell  *cell = [tableView dequeueReusableCellWithIdentifier:cell3];
            if(!cell)
            {
                cell = [[XFTVideoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell3];
            }
            collectCell = cell;
        }
            break;
        case XFTVoiceCollctionType:
        {
            static NSString *cell4 = @"cell4";
            XFTVoiceCell *cell = [tableView dequeueReusableCellWithIdentifier:cell4];
            if(!cell)
            {
                cell = [[XFTVoiceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell4 ];
            }
            collectCell = cell;
        }
            break;
        case XFTLocationCollctionType:
        {
            static NSString *cell5 = @"cell5";
            XFTLocationCell *cell = [tableView dequeueReusableCellWithIdentifier:cell5];
            if(!cell)
            {
                cell = [[XFTLocationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell5 ];
            }
            collectCell = cell;
        }
            break;
        default:
            break;
    }
    collectCell.delegate = self;
    collectCell.dataSource = self;
    
    [collectCell setNeedsUpdateConstraints];

    if ([self.cellsCurrentlyEditing containsObject:indexPath]) {
        [collectCell openCell:NO];
    }
    
    return collectCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XFTCollectModel *collectModel = self.dataArray[indexPath.row];
    switch (collectModel.type) {
        case XFTTextCollctionType:
        {
            CGFloat contentHeight = [collectModel.content calulateHeightForOneLyricStr_SDK:collectModel.content FontType:[UIFont systemFontOfSize:14] RowWidth:255];
            NSLog(@"%f",contentHeight);
            if(contentHeight < 40)
            {
                return contentHeight + 50;
            }
            return 85;
        }
            
            break;
        case XFTPictureCollctionType:
            return 130.0f;
            break;
        case XFTVideoCollctionType:
            return 114.0f;
            break;
        case XFTVoiceCollctionType:
            return 87.0f;
            break;
        case XFTLocationCollctionType:
            return 114.0f;
            break;
        default:
            break;
    }
    
    return 0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.indexPath != indexPath && self.isOpen)
    {
        [self.cellsCurrentlyEditing removeObject:self.indexPath];
        NSLog(@"isOpen=%d",self.isOpen);
        self.isOpen = NO;
        DNSSwipeableCell *cell = (DNSSwipeableCell*)[tableView cellForRowAtIndexPath:self.indexPath];
        [cell closeCell:YES];
        return;
    }
    
    XFTCollectModel *collectModel = self.dataArray[indexPath.row];
    switch (collectModel.type) {
        case 0:
        {
            NSLog(@"文本");
            if (!_textVC) {
                _textVC = [[XFTTextViewController alloc] init];
                _textVC.collectModel = collectModel;
            }
            else{
                [_textVC updateViewWithCollectModel:collectModel];
            }
            [self.navigationController pushViewController:_textVC animated:YES];
        }
            break;
        case 1:
        {
            NSLog(@"声音");
            if(!_voiceVC)
            {
                _voiceVC = [[XFTVoiceViewController alloc] init];
                _voiceVC.collectModel = collectModel;
            }
            else
            {
                [_voiceVC updateViewWithCollectModel:collectModel];
            }
            [self.navigationController pushViewController:_voiceVC animated:YES];
        }
            break;
        case 2:
        {
            NSLog(@"视频");
            XFTVideoViewController *videoViewController = [[XFTVideoViewController alloc] init];
            [self.navigationController pushViewController:videoViewController animated:YES];
            
        }
            break;
        case 3:
        {
            NSLog(@"图片");
            if(!_pictureVC)
            {
                _pictureVC = [[XFTPictureViewController alloc] init];
                _pictureVC.collectModel = collectModel;
            }
            else
            {
                [_pictureVC updateViewWithCollectModel:collectModel];
            }
            [self.navigationController pushViewController:_pictureVC animated:YES];
        }
            break;
        case 4:
        {
            NSLog(@"地理位置");
            XFTMapViewController *mapViewController = [[XFTMapViewController alloc] init];
            mapViewController.collectModel = collectModel;
            [self.navigationController pushViewController:mapViewController animated:YES];
            
        }
            break;
            
        default:
            break;
    }
    
    
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    //This needs to return NO or you'll only get the stock delete button.
    return NO;
}


#pragma mark - DNSSwipeableCellDataSource

#pragma mark Required Methods

- (NSInteger)numberOfButtonsInSwipeableCell:(DNSSwipeableCell *)cell
{
    return 2;
}

- (NSString *)swipeableCell:(DNSSwipeableCell *)cell titleForButtonAtIndex:(NSInteger)index
{
//    NSIndexPath *indexPath = [self.myCollecttableView indexPathForRowAtPoint:cell.center];
    switch (index) {
        case 0:
            return @"删除";
            break;
        case 1:
            return @"标签";
            break;
        default:
            break;
    }
    
    return nil;
}

- (UIColor *)swipeableCell:(DNSSwipeableCell *)cell backgroundColorForButtonAtIndex:(NSInteger)index
{
    switch (index) {
        case 0:
            return [UIColor colorWithRed:255.0/255.0 green:59.0/255.0 blue:48.0/255.0 alpha:1];
            break;
        case 1:
            return [UIColor colorWithRed:199.0/255.0 green:199.0/255.0 blue:204.0/255.0 alpha:1];
            break;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //Deletes the object from the array
        [self.dataArray removeObjectAtIndex:indexPath.row];
        
        //Deletes the row from the tableView.
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else {
        //This is something that hasn't been set up yet - add a log to determine
        //what sort of editing style you also need to handle.
        NSLog(@"Unhandled editing style! %@", @(editingStyle));
    }
    
    [self.myCollecttableView performSelector:@selector(reloadData) withObject:nil afterDelay:0.5];
}
#pragma mark - DNSSwipeableCellDelegate

- (void)swipeableCell:(DNSSwipeableCell *)cell didSelectButtonAtIndex:(NSInteger)index
{
    NSIndexPath *indexPath = [self.myCollecttableView indexPathForRowAtPoint:cell.center];
    NSLog(@"%@",indexPath);
    if (index == 0) {
        [self.cellsCurrentlyEditing removeObject:indexPath];
        self.isOpen = NO;
        
        [self tableView:self.myCollecttableView commitEditingStyle:UITableViewCellEditingStyleDelete forRowAtIndexPath:indexPath];
        
    } else {
//        [self showDetailForIndexPath:indexPath fromDelegateButtonAtIndex:index];
    }
}

- (void)swipeableCellDidOpen:(DNSSwipeableCell *)cell
{
//    NSLog(@"open");
    NSIndexPath *indexPath = [self.myCollecttableView indexPathForRowAtPoint:cell.center];
    if(self.indexPath != indexPath && self.indexPath && self.isOpen)
    {
        [self.cellsCurrentlyEditing removeObject:self.indexPath];
        DNSSwipeableCell *cell = (DNSSwipeableCell*)[self.myCollecttableView cellForRowAtIndexPath:self.indexPath];
        [cell closeCell:YES];
        
    }
   
    self.indexPath = indexPath;
    [self.cellsCurrentlyEditing addObject:indexPath];
    self.isOpen = YES;
}

- (void)swipeableCellDidClose:(DNSSwipeableCell *)cell
{
//    NSLog(@"close");
    NSIndexPath *indexPath = [self.myCollecttableView indexPathForRowAtPoint:cell.center];
    [self.cellsCurrentlyEditing removeObject:indexPath];
    self.isOpen = NO;
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
