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
@interface XFTMyCollectViewController ()
<
UITableViewDataSource,
UITableViewDelegate
>
@property(nonatomic,strong)UITableView *myCollecttableView;
@property(nonatomic,strong)NSMutableArray *dataArray;
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
    XFTMyCollectCell *cell;
    switch (item.type) {
        case XFTTextCollctionType:
        {
            static NSString *cell1 = @"cell1";
            cell = [tableView dequeueReusableCellWithIdentifier:cell1];
            if(!cell)
            {
                cell = [[XFTMyCollectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell1 collectionType:XFTTextCollctionType];
            }
        }
            break;
        case XFTPictureCollctionType:
        {
            static NSString *cell2 = @"cell2";
            cell = [tableView dequeueReusableCellWithIdentifier:cell2];
            if(!cell)
            {
                cell = [[XFTMyCollectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell2 collectionType:XFTPictureCollctionType];
            }
        }
            break;
        case XFTVideoCollctionType:
        {
            static NSString *cell3 = @"cell3";
            cell = [tableView dequeueReusableCellWithIdentifier:cell3];
            if(!cell)
            {
                cell = [[XFTMyCollectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell3 collectionType:XFTVideoCollctionType];
            }
        }
            break;
        case XFTVoiceCollctionType:
        {
            static NSString *cell4 = @"cell4";
            cell = [tableView dequeueReusableCellWithIdentifier:cell4];
            if(!cell)
            {
                cell = [[XFTMyCollectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell4 collectionType:XFTVoiceCollctionType];
            }
        }
            break;
        case XFTLocationCollctionType:
        {
            static NSString *cell5 = @"cell5";
            cell = [tableView dequeueReusableCellWithIdentifier:cell5];
            if(!cell)
            {
                cell = [[XFTMyCollectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell5 collectionType:XFTLocationCollctionType];
            }
        }
            break;
        default:
            break;
    }

    return cell;
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
