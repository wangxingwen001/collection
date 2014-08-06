//
//  XFTTagWriteView.m
//  MyCollect
//
//  Created by john on 14-8-5.
//  Copyright (c) 2014年 john. All rights reserved.
//

#import "XFTTagWriteView.h"
#import "MyLayer.h"
#import "NSString+CalWidth.h"
#import "XFTButton.h"
#import "XFTMenuItem.h"
#import "XFTMenuController.h"
#define TAG_COLOR_GREEN [UIColor colorWithRed:0.059 green:0.741 blue:0.008 alpha:1]
#define TAG_COLOR_GRAY [UIColor colorWithRed:0.875 green:0.875 blue:0.867 alpha:1]
#define TITLE_COLOR [UIColor colorWithRed:0.239 green:0.239 blue:0.239 alpha:1]
@interface XFTTagWriteView()<UITextFieldDelegate,UIScrollViewDelegate>
@property(nonatomic,strong) UIScrollView *inputScrollView;
@property(nonatomic,strong) UIScrollView *showTagScrollView;
@property(nonatomic,strong) UITextField *inputTextField;
@property (nonatomic, strong) UIButton *deleteButton;
@property(nonatomic,strong)NSMutableArray *tagMadeArray;
@property(nonatomic,strong)NSMutableArray *tagViews;
@property(nonatomic,strong)NSMutableArray *myTagViews;
@property(nonatomic,strong)XFTMenuController *deleteMenuController;
@property(nonatomic,strong)XFTMenuItem *deleteMenuItem;
@property(nonatomic,assign)BOOL isSelected;
@property(nonatomic,assign)NSInteger beyoundNum;
@end
@implementation XFTTagWriteView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.inputTagArray = [[NSMutableArray alloc] initWithCapacity:0];
        
        self.tagMadeArray = [[NSMutableArray alloc] initWithCapacity:self.collectTagArray.count];
        
        self.tagViews = [[NSMutableArray alloc] initWithCapacity:0];
        
        self.backgroundColor = [UIColor colorWithRed:0.933 green:0.949 blue:0.961 alpha:1];
        self.inputScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, MainSreenWidth, 50)];
        self.inputScrollView.tag = 10;
        self.inputScrollView.backgroundColor = [UIColor whiteColor];
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesPress:)];
        [self.inputScrollView addGestureRecognizer:tapGes];
        
       
        
        [self addSubview:self.inputScrollView];
    
        
        
        self.inputTextField = [[UITextField alloc] initWithFrame:CGRectMake(15, 12.5, 80, 25)];
        self.inputTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.inputTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        self.inputTextField.returnKeyType = UIReturnKeyDone;
        self.inputTextField.adjustsFontSizeToFitWidth = NO;
        self.inputTextField.delegate = self;
        self.inputTextField.font = self.font;
        self.inputTextField.text = @"";
        self.inputTextField.placeholder = @"添加标签";
        [self.inputScrollView addSubview:self.inputTextField];
        
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 25)];
        leftView.backgroundColor = [UIColor clearColor];
        self.inputTextField.leftView = leftView;
        self.inputTextField.leftViewMode = UITextFieldViewModeAlways;
        
        self.showTagScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0 , self.inputScrollView.frame.size.height, MainSreenWidth, MainSreenHeight-self.inputScrollView.frame.size.height)];
        self.showTagScrollView.contentSize = CGSizeMake(MainSreenWidth, MainSreenHeight-self.inputScrollView.frame.size.height+0.5);
        self.showTagScrollView.delegate = self;
        self.showTagScrollView.tag = 20;
        self.showTagScrollView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.showTagScrollView];
        
        UIView *separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainSreenWidth, 1)];
        separatorLineView.backgroundColor = [UIColor colorWithRed:0.847 green:0.843 blue:0.855 alpha:1];
        [self.showTagScrollView addSubview:separatorLineView];
        //添加键盘通知，当用户开始输入的时候调用
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldStartChange:) name:UITextFieldTextDidChangeNotification object:self.inputTextField];
        
        UILabel *myTagLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 100, 15)];
        myTagLabel.font = [UIFont systemFontOfSize:13];
        myTagLabel.text = @"我的标签";
        myTagLabel.backgroundColor = [UIColor clearColor];
        myTagLabel.textColor = [UIColor colorWithRed:0.647 green:0.675 blue:0.698 alpha:1];
        [self.showTagScrollView addSubview:myTagLabel];
        
        if(!self.deleteMenuController)
        {
            self.deleteMenuController = [[XFTMenuController alloc] init];
            
            self.deleteMenuItem = [[XFTMenuItem alloc] initWithTitle:@"删除" action:@selector(deleteMenuItemClick:)];
            self.deleteMenuController.menuItems = nil;
            self.deleteMenuController.menuItems = @[self.deleteMenuItem];
        }
        
    }
    return self;
}

- (void)showKeyBoard:(BOOL)isShow
{
    if(isShow)
    {
        [self.inputTextField becomeFirstResponder];
    }
    else
    {
        
        [self.inputTextField resignFirstResponder];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if(scrollView.tag == 20)
    {
        [self showKeyBoard:NO];
    }
}
- (void)tagbtnPress:(XFTButton*)btn
{
    NSLog(@"点击了标签");
    [self.deleteMenuController setTargetRect:btn.bounds inView:btn];
     self.deleteMenuController.tag = btn.tag;
    
    for(XFTButton *btn1 in self.tagViews)
    {
        if(btn1 != btn)
        {
            [self resetButton:btn1 isSelect:NO];
        }
    }
    if(btn.select)
    {
        
        [self resetButton:btn isSelect:NO];
        [self.deleteMenuController setMenuVisible:NO animated:YES];
    }
    else
    {
        [btn becomeFirstResponder];
        [self resetButton:btn isSelect:YES];
        [self.deleteMenuController setMenuVisible:YES animated:YES];
       
    }
    
}
//isSelect为NO 选中
-(void)resetButton:(XFTButton*)btn isSelect:(BOOL)isSelect
{
    if(isSelect)
    {
        btn.select = YES;
        [btn setBackgroundColor:TAG_COLOR_GREEN];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    else
    {
        btn.select = NO;
        [btn setBackgroundColor:[UIColor whiteColor]];
        [btn setTitleColor:TAG_COLOR_GREEN forState:UIControlStateNormal];
    }
}
- (void)resetMyTagButton:(XFTButton*)button isDelete:(BOOL)isDelete
{
    if(isDelete)
    {
        button.select = YES;
        [self addTagWith:button.titleLabel.text];
        [button setTitleColor:TAG_COLOR_GREEN forState:UIControlStateNormal];
        button.layer.borderColor = TAG_COLOR_GREEN.CGColor;
    }
    else
    {
        button.select = NO;
        [self deleteTag:button.titleLabel.text];
        [button setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
        button.layer.borderColor = TAG_COLOR_GRAY.CGColor;
    }
}
- (void)deleteMenuItemClick:(XFTMenuController*)menuController
{
    [self deleteTag:[self.inputTagArray objectAtIndex:menuController.tag]];
}
//动态创建标签按钮
- (void)updateTag:(NSArray *)tags
{
    if(tags.count > 0)
    {
        CGFloat tag_X = 15,tag_Y = 10;
        if(self.tagViews.count > 0)
        {
            XFTButton *tagBtn = [self.tagViews lastObject];
            tag_X = tagBtn.frame.origin.x + tagBtn.frame.size.width;
            tag_Y = tagBtn.frame.origin.y;
        }
        for(NSString *tag in tags)
        {
            if(self.tagViews.count > 0)
            {
                XFTButton *tagBtn = [self.tagViews lastObject];
                tag_X = tagBtn.frame.origin.x + tagBtn.frame.size.width + 7.5;
                if(tag_X + [tag calculateWidthForFont:self.font]+20 > MainSreenWidth - 15)
                {
                    tag_Y = tagBtn.frame.origin.y + tagBtn.frame.size.height + 10;
                    tag_X = 15;
                }
            }
            XFTButton *tagBtn = [XFTButton buttonWithType:UIButtonTypeCustom];
            [tagBtn addTarget:self action:@selector(tagbtnPress:) forControlEvents:UIControlEventTouchUpInside];

            tagBtn.frame = CGRectMake(tag_X, tag_Y, [tag calculateWidthForFont:self.font]+20, 25);
            
            tagBtn.titleLabel.font = self.font;
            [tagBtn setTitle:tag forState:UIControlStateNormal];
            [MyLayer RoundedWithBorder:tagBtn cornerRadius:tagBtn.frame.size.height/2 borderWidth:0.5 borderColor:TAG_COLOR_GREEN masksToBounds:YES];
            [tagBtn setTitleColor:TAG_COLOR_GREEN forState:UIControlStateNormal];
            [self.inputScrollView addSubview:tagBtn];
            [self.tagViews addObject:tagBtn];
            NSInteger index = [self.tagViews indexOfObject:tagBtn];
            tagBtn.tag = index;
            [self.inputTagArray addObject:tag];
            NSLog(@"%@",tag);
            [self layoutInputAndScroll];
        }
    }
}

- (void)layoutInputAndScroll
{
    XFTButton *btn = [self.tagViews lastObject];
    CGRect fram = self.inputTextField.frame;
    CGFloat x = btn.frame.origin.x + btn.frame.size.width + 15;
    CGFloat y = btn.frame.origin.y;
    if(85 > MainSreenWidth - x )
    {
        x = 15;
        y += 35;
    }
    if(!btn)
    {
        x = 15;
        y = 12.5;
    }
    fram.origin = CGPointMake(x, y);
    self.inputTextField.frame = fram;
    self.inputTextField.text = @"";
    [self textFieldStartChange:nil];
    [self setScrollOffsetToShowInputView];
}
- (void)setScrollOffsetToShowInputView
{
    CGSize size = CGSizeMake(MainSreenWidth, self.inputTextField.frame.origin.y + 40);
    
    self.inputScrollView.contentSize = size;
    if(size.height <= 125)
    {
       self.inputScrollView.frame = CGRectMake(0, 0, MainSreenWidth, size.height);
    }
    else
    {
        [UIView animateWithDuration:0.1 animations:^{
            self.inputScrollView.contentOffset = CGPointMake(0, self.inputTextField.frame.origin.y - 80);
        }];
    }
    CGRect frame = self.showTagScrollView.frame;
    frame.origin.y = self.inputScrollView.frame.size.height;
    self.showTagScrollView.frame = frame;
}
- (void)addTagWith:(NSString*)tag
{
    NSArray *result = [self.inputTagArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF == %@", tag]];
    NSMutableArray *newTags = [[NSMutableArray alloc] initWithCapacity:0];
    if(result.count == 0)
    {
        [newTags addObject:tag];
        [self updateTag:newTags];
    }
    NSInteger index = -1;
    for(NSString *str in self.myTagArray)
    {
        if([str isEqualToString:tag])
        {
            index = [self.myTagArray indexOfObject:str];
            break;
        }
    }
    if(index >= 0 )
    {
        XFTButton *btn = [self.myTagViews objectAtIndex:index];
        btn.titleLabel.font = self.font;
        UIImage * image = [[UIImage imageNamed:@"Fav_Green_Tab"] resizableImageWithCapInsets:UIEdgeInsetsMake(15, 15, 15, 15)];
        [btn setBackgroundImage:image forState:UIControlStateNormal];
        UIImage * image_HL = [[UIImage imageNamed:@"Fav_Green_TabHL"] resizableImageWithCapInsets:UIEdgeInsetsMake(15, 15, 15, 15)];
        [btn setBackgroundImage:image_HL forState:UIControlStateHighlighted];
        [btn setTitleColor:self.tagForegroundColor forState:UIControlStateNormal];
        btn.select = YES;
    }
        
}
- (void)gesPress:(UIGestureRecognizer*)ges
{
    NSLog(@"gesPress");
    [self showKeyBoard:YES];
    if(self.inputTextField.text.length > 18)
    {
        return ;
    }
    else if(self.inputTextField.text.length > 0 && self.inputTextField.text.length <= 18)
    {
        [self addTagWith:self.inputTextField.text];
    }
    self.inputTextField.text = @"";
    [self textFieldStartChange:nil];
    for(XFTButton *btn in self.tagViews)
    {
        if(btn.select)
        {
            [self resetButton:btn isSelect:NO];
        }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"%@",textField.text);
    if(textField.text.length > 18)
    {
        return NO;
    }
    else if(textField.text.length > 0 && textField.text.length <= 18)
    {
        [self addTagWith:textField.text];
    }
    textField.text = @"";
    [self textFieldStartChange:nil];
    return YES;
}
- (void)removeNotication:(NSString *)name
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:name object:self.inputTextField];
}
- (void)textFieldStartChange:(NSNotification*)info
{
    if(self.inputTextField.text.length > 18)//字符数字超过18个
    {
        NSLog(@"标签最多支持18个字，已超过%d字",self.inputTextField.text.length-18);
        self.beyoundNum = self.inputTextField.text.length - 18;
    }
    CGFloat width = [self.inputTextField.text calculateWidthForFont:_font] + 30;
    if(width >= 80 &width < MainSreenWidth-40)
    {
        CGRect frame = self.inputTextField.frame;
        frame.size.width = width;
        self.inputTextField.frame = frame;
        
    }
    else if(width < 80)
    {
        CGRect frame = self.inputTextField.frame;
        frame.size.width = 80;
        self.inputTextField.frame = frame;
    }
    if(width == 30)
    {
        [MyLayer RoundedWithBorder:self.inputTextField cornerRadius:0 borderWidth:0 borderColor:nil masksToBounds:YES];
        CGRect frame = self.inputTextField.frame;
        frame.size.width = 80;
        self.inputTextField.frame = frame;
    }
    else
    {
        [MyLayer RoundedWithBorder:self.inputTextField cornerRadius:12.5 borderWidth:0.5 borderColor:[UIColor lightGrayColor] masksToBounds:YES];
    }
    if(self.tagViews.count > 0 )
    {
        XFTButton *lastBtn = [self.tagViews lastObject];
        if(width ==30)
        {
            if(85 > MainSreenWidth - (lastBtn.frame.origin.x + lastBtn.frame.size.width + 15))
            {
                CGRect frame = self.inputTextField.frame;
                frame.origin.y = lastBtn.frame.origin.y + 35;
                frame.origin.x = 15;
                self.inputTextField.frame = frame;
                [self setScrollOffsetToShowInputView];
                return;
            }
        }
        if(width + 15 > MainSreenWidth - (lastBtn.frame.origin.x + lastBtn.frame.size.width + 15))
        {
            
            CGRect frame = self.inputTextField.frame;
            frame.origin.y = lastBtn.frame.origin.y + 35;
            frame.origin.x = 15;
            self.inputTextField.frame = frame;
            [self setScrollOffsetToShowInputView];
        }
        else
        {
            CGRect frame = self.inputTextField.frame;
            frame.origin.y = lastBtn.frame.origin.y ;
            frame.origin.x = lastBtn.frame.origin.x +lastBtn.frame.size.width + 15;
            self.inputTextField.frame = frame;
            [self setScrollOffsetToShowInputView];
        }
    }
   
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //不能以空格符开头
    if(range.location==0 && [string isEqualToString:@" "])
    {
        NSLog(@"不能以空格符开头");
        return NO;
    }
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    for(XFTButton *btn in self.tagViews)
    {
        if(btn.select)
        {
            [self resetButton:btn isSelect:NO];
        }
    }
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if(textField.text.length == 0)
    {
        NSLog(@"删除");
    }
    return YES;
}
- (void)updateMyTagView:(NSArray *)myTags
{
    self.beyoundNum = 0;
    self.myTagArray = myTags;
    if(!self.myTagViews)
    {
        self.myTagViews = [[NSMutableArray alloc] initWithCapacity:0];
    }
    if(self.myTagViews.count>0)
    {
        for(XFTButton *btn in self.myTagViews)
        {
            [btn removeFromSuperview];
        }
        [self.myTagViews removeAllObjects];
    }
    CGFloat x = 15,y = 45;
    for(NSString *tag in myTags)
    {
        if(self.myTagViews.count > 0)
        {
            XFTButton *lastBtn = [self.myTagViews lastObject];
            x = lastBtn.frame.origin.x + lastBtn.frame.size.width + 10;
            if(x + [tag calculateWidthForFont:self.font]+20 > MainSreenWidth - 15)
            {
                x = 15;
                y = lastBtn.frame.origin.y + lastBtn.frame.size.height + 10;
            }
        }
        NSArray *result = [self.inputTagArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF == %@",tag]];
        
        CGFloat width = [tag calculateWidthForFont:self.font] + 20;
        XFTButton *btn = [XFTButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = self.font;
        btn.frame = CGRectMake(x, y, width, 25);
        [btn setTitle:tag forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor whiteColor];
        if(result.count == 0)
        {
            [MyLayer RoundedWithBorder:btn cornerRadius:btn.frame.size.height/2 borderWidth:0.5 borderColor:TAG_COLOR_GRAY masksToBounds:YES];
            [btn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
            btn.select = NO;
        }
        else
        {
            [MyLayer RoundedWithBorder:btn cornerRadius:btn.frame.size.height/2 borderWidth:0.5 borderColor:TAG_COLOR_GREEN masksToBounds:YES];
            [btn setTitleColor:TAG_COLOR_GREEN forState:UIControlStateNormal];
            btn.select = YES;
            
        }
        
       
        [btn addTarget:self action:@selector(tagBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.showTagScrollView addSubview:btn];
        [self.myTagViews addObject:btn];
        
    }
}
- (void)tagBtnClick:(XFTButton*)btn
{
    [self showKeyBoard:NO];
    if(btn.select)
    {

        [self resetMyTagButton:btn isDelete:YES];
        
    }
    else
    {
        [self resetMyTagButton:btn isDelete:YES];
    }
    for(XFTButton *btn in self.tagViews)
    {
        if(btn.select)
        {
            [self resetButton:btn isSelect:NO];
        }
    }
    
}

- (void)deleteTag:(NSString*)tag
{
    NSInteger index = -1;
    NSInteger index1 = -1;
    for(NSString *str in self.inputTagArray)
    {
        if([str isEqualToString:tag])
        {
            index = [self.inputTagArray indexOfObject:str];
            break;
        }
    }
    for(NSString *str in self.myTagArray)
    {
        if([str isEqualToString:tag])
        {
            index1 = [self.myTagArray indexOfObject:str];
            break;
        }
    }
    NSLog(@"index=%d,index1=%d",index,index1);
    if(index1 >= 0)
    {
        XFTButton *btn = [self.myTagViews objectAtIndex:index1];
        btn.select = NO;
        [btn setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
        btn.layer.borderColor = TAG_COLOR_GRAY.CGColor;
    }
    if(index >= 0)
    {
        [self.inputTagArray removeObjectAtIndex:index];
        [self reLayoutTags:self.inputTagArray];
        NSLog(@"%d",self.inputTagArray.count);
    }
    
    
}
- (void)reLayoutTags:(NSArray*)tags
{
    if(self.tagViews.count > 0)
    {
        for(XFTButton *btn in self.tagViews)
        {
            [btn removeFromSuperview];
        }
        [self.tagViews removeAllObjects];
        
        CGFloat tag_X = 15,tag_Y = 10;
        for(NSString *tag in tags)
        {
            if(self.tagViews.count > 0)
            {
                XFTButton *tagBtn = [self.tagViews lastObject];
                tag_X = tagBtn.frame.origin.x + tagBtn.frame.size.width + 7.5;
                if(tag_X + [tag calculateWidthForFont:self.font]+20 > MainSreenWidth - 15)
                {
                    tag_Y = tagBtn.frame.origin.y + tagBtn.frame.size.height + 10;
                    tag_X = 15;
                }
            }
            XFTButton *tagBtn = [XFTButton buttonWithType:UIButtonTypeCustom];
            tagBtn.titleLabel.font = self.font;
            [tagBtn addTarget:self action:@selector(tagbtnPress:) forControlEvents:UIControlEventTouchUpInside];
            tagBtn.titleLabel.font = self.font;
            tagBtn.frame = CGRectMake(tag_X, tag_Y, [tag calculateWidthForFont:self.font]+20, 25);
            [tagBtn setTitle:tag forState:UIControlStateNormal];
            [MyLayer RoundedWithBorder:tagBtn cornerRadius:tagBtn.frame.size.height/2 borderWidth:0.5 borderColor:TAG_COLOR_GREEN masksToBounds:YES];
            [tagBtn setTitleColor:TAG_COLOR_GREEN forState:UIControlStateNormal];
            [self.inputScrollView addSubview:tagBtn];
            [self.tagViews addObject:tagBtn];
            NSInteger index = [self.tagViews indexOfObject:tagBtn];
            tagBtn.tag = index;
            NSLog(@"%@",tag);
            
        }
        NSLog(@"btns=%d",self.tagViews.count);
        [self layoutInputAndScroll];
    }
}
- (void)deleteTag
{
    if(self.tagViews.count > 0)
    {
        NSString *lastTag = [self.inputTagArray lastObject];
        [self deleteTag:lastTag];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
