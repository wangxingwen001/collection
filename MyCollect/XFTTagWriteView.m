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
@interface XFTTagWriteView()<UITextFieldDelegate,UIScrollViewDelegate>
@property(nonatomic,strong) UIScrollView *inputScrollView;
@property(nonatomic,strong) UIScrollView *showTagScrollView;
@property(nonatomic,strong) UITextField *inputTextField;
@property (nonatomic, strong) UIButton *deleteButton;
@property(nonatomic,strong)NSMutableArray *inputTagArray;
@property(nonatomic,strong)NSMutableArray *tagMadeArray;
@property(nonatomic,strong)NSMutableArray *tagViews;
@property(nonatomic,strong)NSMutableArray *myTagViews;
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
        self.inputTextField.placeholder = @"添加标签";
//        [self.inputTextField becomeFirstResponder];
        [self.inputScrollView addSubview:self.inputTextField];
        
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
        
        UILabel *myTagLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 100, 20)];
        myTagLabel.font = self.font;
        myTagLabel.text = @"我的标签";
        myTagLabel.backgroundColor = [UIColor clearColor];
        myTagLabel.textColor = [UIColor colorWithRed:0.647 green:0.675 blue:0.698 alpha:1];
        [self.showTagScrollView addSubview:myTagLabel];
        
        
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
//动态创建标签按钮
- (void)updateTag:(NSArray *)tags
{
    
    if(tags.count > 0)
    {
        CGFloat tag_X = 15,tag_Y = 10;
        if(self.tagViews.count > 0)
        {
            UIButton *tagBtn = [self.tagViews lastObject];
            tag_X = tagBtn.frame.origin.x + tagBtn.frame.size.width;
            tag_Y = tagBtn.frame.origin.y;
        }
        for(NSString *tag in tags)
        {
            if(self.tagViews.count > 0)
            {
                UIButton *tagBtn = [self.tagViews lastObject];
                tag_X = tagBtn.frame.origin.x + tagBtn.frame.size.width + 7.5;
                if(tag_X + [tag calculateWidthForFont:self.font]+20 > MainSreenWidth - 15)
                {
                    tag_Y = tagBtn.frame.origin.y + tagBtn.frame.size.height + 10;
                    tag_X = 15;
                }
            }
            UIButton *tagBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            tagBtn.titleLabel.font = self.font;
            tagBtn.frame = CGRectMake(tag_X, tag_Y, [tag calculateWidthForFont:self.font]+20, 25);
            [MyLayer RoundedWithBorder:tagBtn cornerRadius:12.5 borderWidth:0.5 borderColor:self.tagForegroundColor masksToBounds:YES];
            [tagBtn setTitle:tag forState:UIControlStateNormal];
            [tagBtn setTitleColor:self.tagForegroundColor forState:UIControlStateNormal];
            [self.inputScrollView addSubview:tagBtn];
            [self.tagViews addObject:tagBtn];
            [self.inputTagArray addObject:tag];
            NSLog(@"%@",tag);
            [self layoutInputAndScroll];
        }
    }
}

- (void)layoutInputAndScroll
{
    
    UIButton *btn = [self.tagViews lastObject];
    CGRect fram = self.inputTextField.frame;
    CGFloat x = btn.frame.origin.x + btn.frame.size.width + 15;
    CGFloat y = btn.frame.origin.y;
    if(x + 80 > MainSreenWidth-15)
    {
        x = 15;
        y += 35;
    }
    fram.origin = CGPointMake(x, y);
    self.inputTextField.frame = fram;
    self.inputTextField.text = nil;
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
        [self.inputTagArray addObject:tag];
        [newTags addObject:tag];
        [self updateTag:newTags];
    }
        
}
- (void)gesPress:(UIGestureRecognizer*)ges
{
    NSLog(@"gesPress");
    [self showKeyBoard:YES];
    if(self.inputTextField.text.length > 18)
    {
        [self addTagWith:[self.inputTextField.text substringToIndex:18]];
    }
    else if(self.inputTextField.text.length > 0 && self.inputTextField.text.length <= 18)
    {
        [self addTagWith:self.inputTextField.text];
    }
    self.inputTextField.text = nil;
    [self textFieldStartChange:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"%@",textField.text);
    if(textField.text.length > 18)
    {
        [self addTagWith:[textField.text substringToIndex:18]];
    }
    else if(textField.text.length > 0 && textField.text.length <= 18)
    {
        [self addTagWith:textField.text];
    }
    textField.text = nil;
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
    }
    CGFloat width = [self.inputTextField.text calculateWidthForFont:_font] + 30;
    if(width >= 70 &width < MainSreenWidth-40)
    {
        CGRect frame = self.inputTextField.frame;
        frame.size.width = width;
        self.inputTextField.frame = frame;
        
    }
    else if(width < 70)
    {
        CGRect frame = self.inputTextField.frame;
        frame.size.width = 70;
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
    if(self.tagViews.count > 0)
    {
        UIButton *lastBtn = [self.tagViews lastObject];
        
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

- (void)updateMyTagView:(NSArray *)myTags
{
    if(!self.myTagViews)
    {
        self.myTagViews = [[NSMutableArray alloc] initWithCapacity:0];
    }
    if(self.myTagViews.count>0)
    {
        for(UIButton *btn in self.myTagViews)
        {
            [btn removeFromSuperview];
        }
        [self.myTagViews removeAllObjects];
    }
    CGFloat x = 15,y = 40;
    for(NSString *tag in myTags)
    {
        if(self.myTagViews.count > 0)
        {
            UIButton *lastBtn = [self.myTagViews lastObject];
            x = lastBtn.frame.origin.x + lastBtn.frame.size.width + 10;
            if(x + [tag calculateWidthForFont:self.font] + 10 > MainSreenWidth - x )
            {
                x = 15;
                y = lastBtn.frame.origin.y + lastBtn.frame.size.height + 10;
            }
        }
        NSArray *result = [self.inputTagArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF == %@",tag]];
        
        CGFloat width = [tag calculateWidthForFont:self.font] + 20;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(x, y, width, 25);
        [btn setTitle:tag forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor whiteColor];
        UIColor *bolderColor = nil;
        if(result.count == 0)
        {
            [btn setTitleColor:self.myTagColor forState:UIControlStateNormal];
            bolderColor = [UIColor colorWithRed:0.906 green:0.902 blue:0.906 alpha:1];
            btn.selected = NO;
        }
        else
        {
            [btn setTitleColor:self.tagForegroundColor forState:UIControlStateNormal];
            bolderColor = self.tagForegroundColor;
            btn.selected = YES;
        }
        [btn addTarget:self action:@selector(tagBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [MyLayer RoundedWithBorder:btn cornerRadius:12.5 borderWidth:0.5 borderColor:bolderColor masksToBounds:YES];
        [self.showTagScrollView addSubview:btn];
        [self.myTagViews addObject:btn];
        
    }
}
- (void)tagBtnClick:(UIButton*)btn
{
    [self showKeyBoard:NO];
    UIColor *bolderColor = nil;
    if(btn.selected)
    {
        [btn setTitleColor:self.myTagColor forState:UIControlStateNormal];
        bolderColor = [UIColor colorWithRed:0.906 green:0.902 blue:0.906 alpha:1];
        btn.selected = NO;
        [self deleteTag:btn.titleLabel.text];
    }
    else
    {
        [btn setTitleColor:self.tagForegroundColor forState:UIControlStateNormal];
        bolderColor = self.tagForegroundColor;
        btn.selected = YES;
        [self addTagWith:btn.titleLabel.text];
    }
    [MyLayer RoundedWithBorder:btn cornerRadius:12.5 borderWidth:0.5 borderColor:bolderColor masksToBounds:YES];
}

- (void)deleteTag:(NSString*)tag
{
    NSInteger index = [self.inputTagArray indexOfObject:tag];
    UIButton *btn = [self.tagViews objectAtIndex:index];
    [btn removeFromSuperview];
    [self.inputTagArray removeObjectAtIndex:index];
    [self.tagViews removeObjectAtIndex:index];
    [self reLayoutTagsWithIndex:index];
}
- (void)reLayoutTagsWithIndex:(NSInteger)index
{
    
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
