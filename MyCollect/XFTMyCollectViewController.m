//
//  XFTMyCollectViewController.m
//  MyCollect
//
//  Created by john on 14-7-31.
//  Copyright (c) 2014年 john. All rights reserved.
//

#import "XFTMyCollectViewController.h"
#import "XFTMyCollectCell.h"
#import "XFTCollectItem.h"
#import "XFTTextCell.h"
#import "XFTPictureCell.h"
#import "XFTVideoCell.h"
#import "XFTVoiceCell.h"
#import "XFTLocationCell.h"

@interface XFTMyCollectViewController ()
<
UITableViewDataSource,
UITableViewDelegate,
DNSSwipeableCellDataSource,
DNSSwipeableCellDelegate
>
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
        XFTCollectItem *item = [[XFTCollectItem alloc] init];
        item.type = i ;
        [self.dataArray addObject:item];
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
    XFTCollectItem *item = self.dataArray[indexPath.row];
    XFTMyCollectCell *collectCell = nil;
    switch (item.type) {
        case XFTTextCollctionType:
        {
            static NSString *cell1 = @"cell1";
            XFTTextCell* cell = [tableView dequeueReusableCellWithIdentifier:cell1];
            if(!cell)
            {
                cell = [[XFTTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell1];

            }
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
    XFTCollectItem *item = self.dataArray[indexPath.row];
    switch (item.type) {
        case XFTTextCollctionType:
            return 90.0f;
            break;
        case XFTPictureCollctionType:
            return 130.0f;
            break;
        case XFTVideoCollctionType:
            return 115.0f;
            break;
        case XFTVoiceCollctionType:
            return 80.0f;
            break;
        case XFTLocationCollctionType:
            return 115.0f;
            break;
        default:
            break;
    }
    
    return 0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
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
        [self tableView:self.myCollecttableView commitEditingStyle:UITableViewCellEditingStyleDelete forRowAtIndexPath:indexPath];
    } else {
//        [self showDetailForIndexPath:indexPath fromDelegateButtonAtIndex:index];
    }
}

- (void)swipeableCellDidOpen:(DNSSwipeableCell *)cell
{
    NSLog(@"open");
    NSIndexPath *indexPath = [self.myCollecttableView indexPathForRowAtPoint:cell.center];
    [self.cellsCurrentlyEditing addObject:indexPath];
    self.isOpen = YES;
    self.indexPath = indexPath;
}

- (void)swipeableCellDidClose:(DNSSwipeableCell *)cell
{
    NSLog(@"close");
    NSIndexPath *indexPath = [self.myCollecttableView indexPathForRowAtPoint:cell.center];
    [self.cellsCurrentlyEditing removeObject:indexPath];
    self.isOpen = NO;
    self.indexPath = nil;
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
