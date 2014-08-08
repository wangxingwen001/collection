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

static XFTMenuController *deleteMenuController = nil;

@interface XFTTagWriteView()<UITextFieldDelegate,UIScrollViewDelegate,UITextViewDelegate>
@property(nonatomic,strong) UIScrollView *inputScrollView;
@property(nonatomic,strong) UIScrollView *showTagScrollView;
@property(nonatomic,strong) UITextField *inputTextField;
@property (nonatomic, strong) UIButton *deleteButton;
@property(nonatomic,strong)NSMutableArray *tagMadeArray;
@property(nonatomic,strong)NSMutableArray *tagViews;
@property(nonatomic,strong)NSMutableArray *myTagViews;
@property(nonatomic,strong)XFTMenuItem *deleteMenuItem;
@property(nonatomic,assign)BOOL isSelected;
@property(nonatomic,assign)NSInteger beyoundNum;
@property(nonatomic,strong)UITextView *inputTextView;
@property(nonatomic,strong)UILabel *placeholderLabel;
@end
@implementation XFTTagWriteView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor colorWithRed:0.933 green:0.949 blue:0.961 alpha:1];
        
        self.inputTagArray = [[NSMutableArray alloc] initWithCapacity:0];
        
        self.tagMadeArray = [[NSMutableArray alloc] initWithCapacity:self.collectTagArray.count];
        
        
        
        self.inputScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, MainSreenWidth, 50)];
        self.inputScrollView.tag = 10;
        self.inputScrollView.backgroundColor = [UIColor whiteColor];
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesPress:)];
        [self.inputScrollView addGestureRecognizer:tapGes];
        
       
        
        [self addSubview:self.inputScrollView];
 
        self.inputTextView = [[UITextView alloc] initWithFrame:CGRectMake(15, 9, 80, 25)];
        self.inputTextView.backgroundColor = [UIColor whiteColor];
        self.inputTextView.autocapitalizationType = UITextAutocapitalizationTypeNone;
        self.inputTextView.font = self.font;
        self.inputTextView.delegate = self;
        self.inputTextView.returnKeyType = UIReturnKeyDone;
        [self.inputScrollView addSubview:self.inputTextView];
        
         [self.inputTextView
          addObserver:self forKeyPath:@"contentSize" options:(NSKeyValueObservingOptionNew) context:NULL];
        
        self.placeholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 7.5, 80, 15)];
        self.placeholderLabel.text = @"添加标签";
        self.placeholderLabel.textColor = PLACEHOLDER_COLOR;
        self.placeholderLabel.font = [UIFont systemFontOfSize:13];
        
        [self.inputTextView addSubview:self.placeholderLabel];
        
        
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
        
        if(!deleteMenuController)
        {
            deleteMenuController = [[XFTMenuController alloc] init];
            
            self.deleteMenuItem = [[XFTMenuItem alloc] initWithTitle:@"删除" action:@selector(deleteMenuItemClick:)];
            deleteMenuController.menuItems = nil;
            deleteMenuController.menuItems = @[self.deleteMenuItem];
        }
    }
    return self;
}
#pragma mark - KVO
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    UITextView *tv = object;
    // Center vertical alignment
    CGFloat topCorrect = ([tv bounds].size.height - [tv contentSize].height * [tv zoomScale])/2.0;
    topCorrect = ( topCorrect < 0.0 ? 0.0 : topCorrect );
    tv.contentOffset = (CGPoint){.x = 0, .y = -topCorrect};
    
    //    // Bottom vertical alignment
    //    CGFloat topCorrect = ([tv bounds].size.height - [tv contentSize].height);
    //    topCorrect = (topCorrect <0.0 ? 0.0 : topCorrect);
    //    tv.contentOffset = (CGPoint){.x = 0, .y = -topCorrect};
    
}
- (void)showKeyBoard:(BOOL)isShow
{
    if(isShow)
    {
        [self.inputTextView becomeFirstResponder];
    }
    else
    {
        
        [self.inputTextView resignFirstResponder];
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
    [deleteMenuController setTargetRect:btn.bounds inView:btn];
     deleteMenuController.tag = btn.tag;
    
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
        [deleteMenuController setMenuVisible:NO animated:YES];
    }
    else
    {
        [btn becomeFirstResponder];
        [self resetButton:btn isSelect:YES];
        [deleteMenuController setMenuVisible:YES animated:YES];
       
    }
    
}
//isSelect为YES 选中
-(void)resetButton:(XFTButton*)btn isSelect:(BOOL)isSelect
{
    if(isSelect)
    {
        self.isSelected = YES;
        btn.select = YES;
        [btn setBackgroundColor:TAG_COLOR_GREEN];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    else
    {
        self.isSelected = NO;
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
    if(self.isSelected && self.tagViews.count > 0)
    {
        [self deleteTag:[self.inputTagArray objectAtIndex:menuController.tag]];
    }
    else
    {
        self.isSelected = NO;
    }
}
- (void)updateThisCollectTags:(NSArray *)tags
{
    if(!self.tagViews)
    {
        self.tagViews = [[NSMutableArray alloc] initWithCapacity:0];
    }
    if(self.tagViews.count > 0)
    {
        for(XFTButton *btn in self.tagViews)
        {
            [btn removeFromSuperview];
        }
        [self.tagViews removeAllObjects];
        [self.inputTagArray removeAllObjects];
    }
    if(tags.count > 0)
    {
        CGFloat tag_X = 15,tag_Y = 12.5;
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
//动态创建标签按钮
- (void)updateTag:(NSArray *)tags
{
    if(tags.count > 0)
    {
        CGFloat tag_X = 15,tag_Y = 12.5;
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
    CGRect fram = self.inputTextView.frame;
    CGFloat x = btn.frame.origin.x + btn.frame.size.width + 15;
    CGFloat y = btn.frame.origin.y-3.5;
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
    self.inputTextView.frame = fram;
    self.inputTextView.text = @"";
    [self textViewDidChange:self.inputTextView];
    [self setScrollOffsetToShowInputView];
}
- (void)setScrollOffsetToShowInputView
{
    CGSize size = CGSizeMake(MainSreenWidth, self.inputTextView.frame.origin.y + 40);
    
    self.inputScrollView.contentSize = size;
    if(size.height <= 125)
    {
       self.inputScrollView.frame = CGRectMake(0, 0, MainSreenWidth, size.height);
    }
    else
    {
        [UIView animateWithDuration:0.1 animations:^{
            self.inputScrollView.contentOffset = CGPointMake(0, self.inputTextView.frame.origin.y - 80);
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
    [self layoutInputAndScroll];
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
        [btn setTitleColor:TAG_COLOR_GREEN forState:UIControlStateNormal];
        btn.layer.borderColor = TAG_COLOR_GREEN.CGColor;
        btn.select = YES;
    }
        
}
- (void)gesPress:(UIGestureRecognizer*)ges
{
    NSLog(@"gesPress");
    [self showKeyBoard:YES];
    if(self.inputTextView.text.length > 0 && self.inputTextView.text.length <= 18)
    {
        [self addTagWith:self.inputTextView.text];
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
    if(width >= 80 && width < MainSreenWidth-40)
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

- (void)textViewDidChange:(UITextView *)textView
{
    if(textView.text.length > 0)
    {
        self.placeholderLabel.hidden = YES;
        [MyLayer RoundedWithBorder:textView cornerRadius:textView.frame.size.height/2 borderWidth:0.5 borderColor:TAG_COLOR_GREEN masksToBounds:YES];
        for(XFTButton *btn in self.tagViews)
        {
            if(btn.select)
            {
                [self resetButton:btn isSelect:NO];
            }
        }
    }
    
    else
    {
        self.placeholderLabel.hidden = NO;
        [MyLayer RoundedWithBorder:textView cornerRadius:0 borderWidth:0 borderColor:nil masksToBounds:NO];
    }
    
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [deleteMenuController setMenuVisible:NO animated:YES];
    for(XFTButton *btn in self.tagViews)
    {
        if(btn.select)
        {
            [self resetButton:btn isSelect:NO];
        }
    }
    return YES;
}
- (CGFloat)widthForInputViewWithText:(NSString *)text
{
    return MAX(80.0, [text calculateWidthForFont:self.font] + 25);
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSLog(@"length%d",textView.text.length);
    CGFloat width = [self widthForInputViewWithText:textView.text];

    if((range.location == 0 && [text isEqualToString:@" "]) || [text isEqualToString:@"\n"])
    {
        NSLog(@"不能以空格符开头");
        if([text isEqualToString:@"\n"])
        {
            if(textView.text.length <=18 && textView.text.length > 0)
            {
                [self addTagWith:textView.text];
            }
        }
        return NO;
    }
    
    CGRect frame = self.inputTextView.frame;
    if(width < MainSreenWidth - 30)
    {
        frame.size.width = width;
    }
    self.inputTextView.frame = frame;
    
    if(self.tagViews.count > 0)
    {
        XFTButton *lastBtn = [self.tagViews lastObject];
    
        if(width + 15 > MainSreenWidth - (lastBtn.frame.origin.x + lastBtn.frame.size.width + 15))
        {
            
            CGRect frame = self.inputTextView.frame;
            frame.origin.y = lastBtn.frame.origin.y + 35;
            frame.origin.x = 15;
            self.inputTextView.frame = frame;
            [self setScrollOffsetToShowInputView];
        }
        else
        {
            CGRect frame = self.inputTextView.frame;
            frame.origin.y = lastBtn.frame.origin.y ;
            frame.origin.x = lastBtn.frame.origin.x +lastBtn.frame.size.width + 15;
            self.inputTextView.frame = frame;
            [self setScrollOffsetToShowInputView];
        }
    }
    if(text.length == 0)
    {
        if(text.length + textView.text.length ==0)
        {
            NSLog(@"开始删除");
            [self deleteTagFromLastIndex];
        }
        return YES;
    }
    if(textView.text.length + text.length > 18)
    {
        return NO;
    }
    
    
    
    
    
    return YES;
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

        [self resetMyTagButton:btn isDelete:NO];
        
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
        
        CGFloat tag_X = 15,tag_Y = 12.5;
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
- (void)deleteTagFromLastIndex
{
    if(self.tagViews.count > 0)
    {
        XFTButton *lastBtn = [self.tagViews lastObject];
        if(lastBtn.select)
        {
            [lastBtn removeFromSuperview];
            [self.tagViews removeLastObject];
            [self.inputTagArray removeLastObject];
            [self resetMyTagButton:lastBtn isDelete:NO];
            [self layoutInputAndScroll];
        }
        else
        {
            lastBtn.select = YES;
            [self resetButton:lastBtn isSelect:YES];
        }
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
