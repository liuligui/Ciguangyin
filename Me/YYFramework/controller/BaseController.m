//
//  BaseController.m
//  Notepad
//
//  Created by ylh on 14-3-4.
//  Copyright (c) 2014年 ylh. All rights reserved.
//

#import "BaseController.h"

#define ANIMATIONDURATION 0.30f
#define KEYBOARD_Y_OFFSET   100

@interface BaseController ()



@property (nonatomic,assign) BOOL keyboardIsVisible;
@property (nonatomic,strong) UITextField *oldTextField;
@end

@implementation BaseController
//@synthesize sView;

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self initTheme];
    if ( IOS_VERSION >= 7.0)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
        self.navigationController.navigationBar.translucent = NO;
    }
    
    if(7.0 <= IOS_VERSION)
    {
        _topStatusView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, Top_Status_H)];

        _topStatusView.backgroundColor = self.themeColor;

        [self.view addSubview:_topStatusView];
    }
    
    
    //navBar
    CGRect navBarRc;
    if(IOS_VERSION < 7.0)
    {
        navBarRc = CGRectMake(0, 0, SCREEN_W, Top_NavBar_H);
    }
    else
    {
        navBarRc = CGRectMake(0, Top_Status_H, SCREEN_W, Top_NavBar_H);
    }
    
    _topNavBarView = [[UIView alloc] initWithFrame:navBarRc];
    _topNavBarView.backgroundColor = self.themeColor;
    [self.view addSubview:_topNavBarView];
    
    //title
    _titleLb = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, SCREEN_W-120, Top_NavBar_H)];
//    [_titleLb labelWithType:kNavTitle];
    [_topNavBarView addSubview:_titleLb];
    
    self.sView = [[UIView alloc] initWithFrame:VIEW_RECT];
    self.sView.tag = 1;
    [self.view addSubview:self.sView];
}

//-(void)initTheme{
//    self.view.backgroundColor = [[ThemeManager sharedManager]colorForKey:theme_bg_color];
//    self.themeColor = [YYImageUtils colorWithImage:[UIImage imageNamed:@"nav_color"]];
//    self.themeBtnColor = [[ThemeManager sharedManager]colorForKey:theme_btn_color];
//    self.themeBorderColor = [[ThemeManager sharedManager]colorForKey:theme_border_color];
//    self.themeBorderWidth = 1;
//}


- (void)navBarItemInit:(NSString*)title Position:(BOOL)left
{
    if (left) {
        _navLeftBt = [[UIButton alloc] initWithFrame:CGRectZero];
        _navLeftBt.backgroundColor = [UIColor clearColor];
        
        _navLeftLb = [[UILabel alloc] initWithFrame:CGRectZero];
        _navLeftLb.text = title;
        _navLeftLb.textColor = self.themeBtnColor;
//        [_navLeftLb labelWithType:kNavItemTitle];
        CGRect rc;
        rc = CGRectMake(0, 0, Nav_Item_W, Top_NavBar_H);
        _navLeftLb.textAlignment = NSTextAlignmentLeft;
        _navLeftLb.frame = CGRectMake(10, 0, Nav_Item_W-10, Top_NavBar_H);
        [_navLeftBt addTarget:self action:@selector(leftBarBtPressed:) forControlEvents:UIControlEventTouchUpInside];
        _navLeftBt.frame = rc;
        [_topNavBarView addSubview:_navLeftBt];
        [_topNavBarView addSubview:_navLeftLb];
    }else{
        
        _navRightBt = [[UIButton alloc] initWithFrame:CGRectZero];
        _navRightBt.backgroundColor = [UIColor clearColor];
        
        _navRightLb = [[UILabel alloc] initWithFrame:CGRectZero];
        _navRightLb.text = title;
        _navRightLb.textColor = self.themeBtnColor;
//        [_navRightLb labelWithType:kNavItemTitle];
        CGRect rc;
        rc = CGRectMake(SCREEN_W - Nav_Item_W, 0, Nav_Item_W, Top_NavBar_H);
        _navRightLb.textAlignment = NSTextAlignmentRight;
        _navRightLb.frame = CGRectMake(SCREEN_W - Nav_Item_W-10, 0, Nav_Item_W-10, Top_NavBar_H);
        [_navRightBt addTarget:self action:@selector(rightBarBtPressed:) forControlEvents:UIControlEventTouchUpInside];
        _navRightBt.frame = rc;
        [_topNavBarView addSubview:_navRightBt];
        [_topNavBarView addSubview:_navRightLb];
        
    }
}

-(void)setNavTitleBtPosintion:(BOOL)isLeft hidden:(BOOL)hidden
{
    if (isLeft) {
        _navLeftBt.hidden = hidden;
        _navLeftLb.hidden = hidden;
    }else{
        _navRightBt.hidden = hidden;
        _navRightLb.hidden = hidden;
    }
}

- (void)navBarItemInitLeftWithImage:(NSString*)title strImageName:(NSString*)imageName Position:(BOOL)left
{
    UIButton* button = [[UIButton alloc] initWithFrame:CGRectZero];
    button.backgroundColor = [UIColor clearColor];
    
    UILabel* btLb = [[UILabel alloc] initWithFrame:CGRectZero];
    btLb.text = title;
    btLb.textColor = self.themeBtnColor;
//    [btLb labelWithType:kNavItemTitle];
    
    
    CGRect rc;
    if(left)
    {
        UIImage* image = [UIImage imageNamed:imageName];
        UIImageView* imageLeft = [[UIImageView alloc] initWithImage:image];
        imageLeft.frame = CGRectMake(View_Space, (Top_NavBar_H-image.size.height)/2, image.size.width, image.size.height);
        [button addSubview:imageLeft];
        
        rc = CGRectMake(0, 0, Nav_Item_W, Top_NavBar_H);
        btLb.textAlignment = NSTextAlignmentLeft;
//        btLb.frame = CGRectMake(View_Space+imageLeft.right, 0, Nav_Item_W, Top_NavBar_H);
        [button addTarget:self action:@selector(leftBarBtPressed:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    else
    {
        UIImage* image = [UIImage imageNamed:imageName];
        UIImageView* imageLeft = [[UIImageView alloc] initWithImage:image];
        imageLeft.frame = CGRectMake(10, (Top_NavBar_H-image.size.height)/2, image.size.width, image.size.height);
        [button addSubview:imageLeft];
        
        rc = CGRectMake(SCREEN_W-imageLeft.frame.size.width-30, 0, Nav_Item_W, Top_NavBar_H);
        btLb.textAlignment = NSTextAlignmentRight;
        [button addTarget:self action:@selector(rightBarBtPressed:) forControlEvents:UIControlEventTouchUpInside];
        btLb.frame = rc;
    }
    button.frame = rc;
    [_topNavBarView addSubview:button];
    [_topNavBarView addSubview:btLb];
}

- (void)leftBarBtPressed:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightBarBtPressed:(UIButton*)sender
{
    
}


#pragma mark hide show Nav
-(void)hideNav
{
    [UIView animateWithDuration:0.1 animations:^void{
        
        if(IOS_VERSION < 7.0)
        {
            _topNavBarView.frame = CGRectMake(0, 0, SCREEN_W, 0);
        }
        else
        {
            _topNavBarView.frame = CGRectMake(0, Top_Status_H, SCREEN_W, 0);
        }

        _topNavBarView.hidden = YES;
       
    }];
}

-(void)showNav
{
    [UIView animateWithDuration:0.1 animations:^void{
        _topNavBarView.hidden = NO;
        if(IOS_VERSION < 7.0)
        {
            _topNavBarView.frame = CGRectMake(0, 0, SCREEN_W, Top_NavBar_H);
        }
        else
        {
            _topNavBarView.frame = CGRectMake(0, Top_Status_H, SCREEN_W, Top_NavBar_H);
        }

    }];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark textfield delegate

//开始编辑输入框的时候，软键盘出现，执行此事件
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    _oldTextField = textField;
    CGRect frame =  [self.sView convertRect:textField.frame fromView:[textField superview]];
    
    int offset = frame.origin.y + KEYBOARD_Y_OFFSET - (self.sView.frame.size.height - 216.0);//键盘高度216
    

    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if(offset > 0){
        [UIView transitionWithView:self.sView duration:ANIMATIONDURATION options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.sView.frame = CGRectMake(0.0f, -offset, self.sView.frame.size.width, self.sView.frame.size.height);
            //标题栏不变
            //_topStatusView.top = offset;
            //_topNavBarView.top = _topStatusView ? _topStatusView.bottom :_topNavBarView.top + offset;
            //[_topStatusView removeFromSuperview];
            //[_topNavBarView removeFromSuperview];
            //[self.view addSubview:_topStatusView];
            //[self.view addSubview:_topNavBarView];
        } completion:^(BOOL finished){
            
        }];
    }
}

//当用户按下return键或者按回车键，keyboard消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    switch (textField.returnKeyType) {
        case UIReturnKeyNext:
            [self textFieldNext:textField];
            break;
        default:
            [self textFieldReturn:textField];
            [textField resignFirstResponder];
            break;
    }
    return  YES;
}

-(void)textFieldNext:(UITextField *)textField{
    UIView *view = [textField.superview viewWithTag:textField.tag+1];
    if ([view isKindOfClass:[UITextField class]]) {
        UITextField *next = (UITextField *)view;
        [next becomeFirstResponder];
    }else{
        [textField resignFirstResponder];
    }
}

-(void)textFieldReturn:(UITextField *)textField{
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
  return  YES;
}


//输入框编辑完成以后，将视图恢复到原始状态
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (!_keyboardIsVisible) {
        [UIView transitionWithView:self.view duration:ANIMATIONDURATION options:UIViewAnimationOptionCurveEaseOut animations:^void{
            self.sView.frame =CGRectMake(0, K_VC_Y, self.sView.frame.size.width, self.sView.frame.size.height);
        }completion:nil];
    }
}


#pragma mark 检测键盘状态
//点击空白
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center  addObserver:self selector:@selector(keyboardDidShow)  name:UIKeyboardDidShowNotification  object:nil];
    [center addObserver:self selector:@selector(keyboardDidHide)  name:UIKeyboardWillHideNotification object:nil];
    _keyboardIsVisible = NO;
    
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [center removeObserver:self name:UIKeyboardDidHideNotification object:nil];
    //隐藏键盘
    [_oldTextField resignFirstResponder];
}

- (void)keyboardDidShow
{
    _keyboardIsVisible = YES;
}

- (void)keyboardDidHide
{
    _keyboardIsVisible = NO;
}

@end
