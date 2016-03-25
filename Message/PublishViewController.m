//
//  PublishViewController.m
//  HomeAdorn
//
//  Created by mac on 15/7/14.
//  Copyright (c) 2015年 IWork. All rights reserved.
//
#import "SeeViewController.h"
#import "CompressionIMAGE.h"
#import "PublishViewController.h"
#import "Globle.h"
#import "DropDownListView.h"
#import "ASIHTTPRequest.h"
#import "JSON.h"
#import "ASIFormDataRequest.h"
@interface PublishViewController ()
{
    UITextField *titleTextField;
    UITextView *ContentTextView;
    UIScrollView *ImageScroll;
    NSMutableArray *UpLoadArray;
    NSMutableArray *ImageArray;
    NSMutableArray *selectedArray;
    UIButton *btn1;
    NSString *type;
      NSMutableArray *chooseArray ;
    
}
@property (nonatomic, strong)UIActionSheet *sheet;

@end

@implementation PublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    chooseArray = [NSMutableArray arrayWithArray:@[
                                                   @[
                                                       @"请选择消息分类",
                                                       @"佛学学习",
                                                       @"法师开示",
                                                       @"科学放生",
                                                       @"素食",
                                                       @"禅修",
                                                       @"生活感悟",
                                                       @"健康",
                                                       @"家庭",
                                                       @"事业",
                                                       @"生命",
                                                       @"国学",
                                                       @"书画",

                                                       ]
                                                  
                                                   ]];
    
    DropDownListView * dropDownView = [[DropDownListView alloc] initWithFrame:CGRectMake(0,17, self.view.frame.size.width, 30) dataSource:self delegate:self];
    dropDownView.mSuperView = self.view;
    
    
    [self.view addSubview:dropDownView];

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}


#pragma mark -- dropDownListDelegate
-(void) chooseAtSection:(NSInteger)section index:(NSInteger)index
{
    NSLog(@"童大爷选了section:%d ,index:%d",section,index);
    switch (index-1) {
        case 0:
            [btn1 setTitle:@"佛学学习" forState:UIControlStateNormal];
            type = @"fxxx";
            break;
        case 1:
            [btn1 setTitle:@"法师开示" forState:UIControlStateNormal];
            type = @"fsks";
            break;
        case 2:
            [btn1 setTitle:@"科学放生" forState:UIControlStateNormal];
            type = @"kxfs";
            break;
        case 3:
            [btn1 setTitle:@"素食" forState:UIControlStateNormal];
            type = @"ss";
            break;
        case 4:
            [btn1 setTitle:@"禅修" forState:UIControlStateNormal];
            type = @"cx";
            break;
        case 5:
            [btn1 setTitle:@"生活感悟" forState:UIControlStateNormal];
            type = @"shgw";
            break;
        case 6:
            [btn1 setTitle:@"健康" forState:UIControlStateNormal];
            type = @"jk";
            break;
        case 7:
            [btn1 setTitle:@"家庭" forState:UIControlStateNormal];
            type = @"jt";
            break;
        case 8:
            [btn1 setTitle:@"事业" forState:UIControlStateNormal];
            type = @"sy";
            break;
        case 9:
            [btn1 setTitle:@"生命" forState:UIControlStateNormal];
            type = @"sm";
            break;
        case 10:
            [btn1 setTitle:@"国学" forState:UIControlStateNormal];
            type = @"gx";
            break;
        case 11:
            [btn1 setTitle:@"书画" forState:UIControlStateNormal];
            type = @"sh";
            break;
            
        default:
            break;
    }

}

#pragma mark -- dropdownList DataSource
-(NSInteger)numberOfSections
{
    return [chooseArray count];
}
-(NSInteger)numberOfRowsInSection:(NSInteger)section
{
    NSArray *arry =chooseArray[section];
    return [arry count];
}
-(NSString *)titleInSection:(NSInteger)section index:(NSInteger) index
{
    return chooseArray[section][index];
}
-(NSInteger)defaultShowSection:(NSInteger)section
{
    return 0;
}



-(void)InitNavigation{
    [super InitNavigation];
    NSString *name = @"发布消息";
    if (self.TitleName) {
        name = self.TitleName;
    }
    self.title = name;
    [NavLeftBtn setImage:[UIImage imageNamed:@"cgyback"] forState:UIControlStateNormal];
    [NavLeftBtn handleControlEvent:UIControlEventTouchDown withBlock:^(id sender) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [NavLeftBtn  setFrame:CGRectMake(0, 0, 25, 25)];

    [NavRightBtn setTitle:@"发布" forState:UIControlStateNormal];
    [NavRightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [NavRightBtn handleControlEvent:UIControlEventTouchDown withBlock:^(id sender) {
        [titleTextField resignFirstResponder];
        [ContentTextView resignFirstResponder];
        BOOL IsBool = NO;
        if ([name isEqualToString:@"发布"]) {
            if (titleTextField.text.length > 0 && ContentTextView.text.length > 0)
                IsBool = YES;
        }else{
            if (ContentTextView.text.length > 0)
                IsBool = YES;
        }
        if (IsBool) {
           
            
            if ([btn1.titleLabel.text isEqualToString:@"请选择消息分类"]) {
                HUD.labelText = @"您还没有选择消息分类！";
                [HUD show:YES];
                [HUD hide:YES afterDelay:1];
            }
            else
            {
               [self submission];
            }
            
           
            
            
           
        }else{
            HUD.mode = MBProgressHUDModeText;
            if ([name isEqualToString:@"投稿"]) {
                if (titleTextField.text.length == 0) {
                    HUD.labelText = @"请输入标题！";
                }
                
            }else if (ContentTextView.text.length == 0){
                HUD.labelText = @"请输入内容！";
            }
            [HUD show:YES];
            [HUD hide:YES afterDelay:1];
        }
    }];
}

- (void)choosetype{

    _sheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:
                @"佛学学习",
                @"法师开示",
                @"科学放生",
                @"素食",
                @"禅修",
                @"生活感悟",
                @"健康",
                @"家庭",
                @"事业",
                @"生命",
                @"国学",
                @"书画",
              
              nil];
        _sheet.frame= CGRectMake(_sheet.frame.origin.x, 100, _sheet.frame.size.width, 300);
    _sheet.tag = 10001;
    [_sheet showInView:self.view];
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
   
        if (buttonIndex == _sheet.cancelButtonIndex) {
            NSLog(@"取消");
            
        }
        switch (buttonIndex) {
            case 0:
               [btn1 setTitle:@"佛学学习" forState:UIControlStateNormal];
                type = @"fxxx";
                break;
            case 1:
               [btn1 setTitle:@"法师开示" forState:UIControlStateNormal];
                   type = @"fsks";
                break;
            case 2:
                [btn1 setTitle:@"科学放生" forState:UIControlStateNormal];
                   type = @"kxfs";
                break;
            case 3:
                [btn1 setTitle:@"素食" forState:UIControlStateNormal];
                   type = @"ss";
                break;
            case 4:
                [btn1 setTitle:@"禅修" forState:UIControlStateNormal];
                   type = @"cx";
                break;
            case 5:
                [btn1 setTitle:@"生活感悟" forState:UIControlStateNormal];
                   type = @"shgw";
                break;
            case 6:
                [btn1 setTitle:@"健康" forState:UIControlStateNormal];
                   type = @"jk";
                break;
            case 7:
                [btn1 setTitle:@"家庭" forState:UIControlStateNormal];
                   type = @"jt";
                break;
            case 8:
                [btn1 setTitle:@"事业" forState:UIControlStateNormal];
                   type = @"sy";
                break;
            case 9:
                [btn1 setTitle:@"生命" forState:UIControlStateNormal];
                   type = @"sm";
                break;
            case 10:
                [btn1 setTitle:@"国学" forState:UIControlStateNormal];
                   type = @"gx";
                break;
            case 11:
                [btn1 setTitle:@"书画" forState:UIControlStateNormal];
                   type = @"sh";
                break;
                
            default:
                break;
        }
    
}

-(void)InitControl{
    UpLoadArray = [[NSMutableArray alloc] init];
    ImageArray = [[NSMutableArray alloc] init];
    selectedArray = [NSMutableArray array];
    UIScrollView *ViewScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, winsize.width, winsize.height - 60 - 50)];
    ViewScroll.userInteractionEnabled = YES;
    ViewScroll.backgroundColor = [UIColor colorWithRed:247 green:247 blue:247 alpha:0.8];
    [self.view addSubview:ViewScroll];
    
    
     btn1 = [[UIButton alloc] initWithFrame:CGRectMake(30, 17, winsize.width - 60 , 30)];
    btn1.layer.masksToBounds = YES;
    btn1.layer.cornerRadius = 2;
    btn1.layer.borderColor = [UIColor lightGrayColor].CGColor;
    //btn1.layer.borderWidth = .5;
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //[btn1 setTitle:@"请选择消息分类" forState:UIControlStateNormal];
    btn1.font = [UIFont systemFontOfSize:12];
    [btn1 addTarget:self action:@selector(choosetype) forControlEvents:UIControlEventTouchUpInside];
    btn1.backgroundColor = [UIColor whiteColor];
    
    [ViewScroll addSubview:btn1];
    ContentTextView = [UITextView allInitFillet:CGRectMake(10, 57, winsize.width - 20, 150)];
    
    ContentTextView.backgroundColor = [UIColor whiteColor];
    ContentTextView.placeholder = @"请输入消息内容";
    [ViewScroll addSubview:ContentTextView];
    
    UILabel *illustrate= [[UILabel alloc]initWithFrame:CGRectMake(10, 210, 200, 20)];
    illustrate.text = @"选择图片（最多9张图片）";
    [ViewScroll addSubview:illustrate];
    
    UIButton *btn = [UIButton buttonWithImage:@"SelectImage"];
    btn.frame = CGRectMake(10, 235, 75, 75);
    [btn handleControlEvent:UIControlEventTouchDown withBlock:^(id sender) {
        [self openMenu:9];
    }];
    [ViewScroll addSubview:btn];
    
    ImageScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(-1, 320, winsize.width+2, 3*75+5)];
    ImageScroll.layer.borderColor = [UIColor lightGrayColor].CGColor;
    ImageScroll.layer.borderWidth = .5;
    [ViewScroll addSubview:ImageScroll];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellTappeds:)];
    [ImageScroll addGestureRecognizer:tapRecognizer];
    [ViewScroll setContentSize:CGSizeMake(winsize.width, 560)];
}


-(void)showchoose
{
    
}

-(void)AlbumImage:(NSObject *)albumImage{
    [UpLoadArray removeAllObjects];
    [ImageArray removeAllObjects];
    [ImageScroll removeAllSubviews];
    
    [selectedArray addObjectsFromArray:(NSArray *)albumImage];
    //    selectedArray = (NSMutableArray *)albumImage;
    [self InitImageScroll];
}

-(void)InitImageScroll{
    [ImageScroll removeAllSubviews];
    CGRect frame = CGRectMake(4, 4, 75, 75);
    int i = 0;
    for (NSDictionary *dic in selectedArray) {
        if([dic objectForKey:UIImagePickerControllerMediaType] == ALAssetTypePhoto){
            if ([dic objectForKey:UIImagePickerControllerOriginalImage]) {
                UIImage *image = [dic objectForKey:UIImagePickerControllerOriginalImage];
                UILongPressGestureRecognizer *logPressGr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(cellLongPressGr:)];
                logPressGr.minimumPressDuration = 1;
                
                UIImageView *AlbImageView = [[UIImageView alloc] initWithImage:image];
                AlbImageView.frame = frame;
                AlbImageView.tag = i;
                AlbImageView.userInteractionEnabled = YES;
                [AlbImageView addGestureRecognizer:logPressGr];
                
                [UpLoadArray addObject:[dic objectForKey:UIImagePickerControllerReferenceURL]];
                [ImageArray addObject:image];
                
                [ImageScroll addSubview:AlbImageView];
                frame.origin.x = frame.origin.x + frame.size.width + 4;
                if (frame.origin.x == winsize.width) {
                    frame.origin.x = 4;
                    frame.origin.y = frame.origin.y + frame.size.height + 4;
                }
                
                i++;
            }
        }
    }
    [ImageScroll setPagingEnabled:YES];
    [ImageScroll setContentSize:CGSizeMake(winsize.width, frame.origin.y + frame.size.height + 10)];
}

-(void)cellLongPressGr:(UILongPressGestureRecognizer *)logGr{
    if (logGr.state == UIGestureRecognizerStateBegan) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"是否取消该图片" delegate:nil cancelButtonTitle:@"取 消" otherButtonTitles:@"确 定", nil];
        [alert showWithCompletionHandler:^(NSInteger buttonIndex) {
            if (buttonIndex == 1) {
                NSInteger index = ((UIImageView *)logGr.view).tag;
                [ImageArray removeObjectAtIndex:index];
                [UpLoadArray removeObjectAtIndex:index];
                [selectedArray removeObjectAtIndex:index];
                [self InitImageScroll];
            }
        }];
    }
}

//选中图片弹出最大化查看
-(void)cellTappeds:(UITapGestureRecognizer *)tapRecognizer{
    CGPoint point = [tapRecognizer locationInView:ImageScroll];
    CGRect frame = CGRectMake(4, 4, 75, 75);
    for (int i = 0; i < UpLoadArray.count; i++) {
        if (CGRectContainsPoint(frame, point)) {
            //选中处理事件
            NSLog(@"选中处理事件");
            SeeViewController *viewControllert = [[SeeViewController alloc] initWithExamine:ImageArray didSeleted:i];
            viewControllert.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
            [self presentViewController:viewControllert animated:YES completion:nil];
        }
        frame.origin.x = frame.origin.x + frame.size.width + 4;
        if (frame.origin.x == winsize.width) {
            frame.origin.x = 4;
            frame.origin.y = frame.origin.y + frame.size.height + 4;
        }
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    for (UIView *v in self.view.subviews) {
        if (touch.view == v) {
            [titleTextField resignFirstResponder];
            [ContentTextView resignFirstResponder];
        }
    }
}

-(void)submission{
    _msgid = @"";
     [HUD show:YES];
    if (ImageArray.count>0) {
        NSArray *array = [[NSArray alloc] init];
        for (int i = 0; i <  1; i++) {
            UIImage *images = ImageArray[i];
            images = [CompressionIMAGE compressionData:images Size:CGSizeMake(500, 500) Percent:.75];
            array = @[@{@"avater":images}];
            
        }
        
        
        [[CommonFunctions sharedlnstance] submission:_msgid PostImages:array requestBlock:^(NSObject *requestData, BOOL IsError) {
            if (!IsError) {
                NSDictionary *dic = (NSDictionary *)requestData;
                if ([[[dic objectForKey:@"msg"] stringValue] isEqualToString:@"1"]) {
                   
                    _msgid =dic[@"msg_id"];

                    NSString *username = [Globle shareInstance].user_id;
                    NSString *string = [NSString stringWithFormat:@"%@%@",ServiceAddress,@"cgy/appCgyMeg/releaseMsg.do"];
                    NSURL *url = [NSURL URLWithString:string];
                    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];

        
                    [request setPostValue:username  forKey:@"user_id"];
                    [request setPostValue: [ContentTextView.text stringByReplacingOccurrencesOfString:@" " withString:@""]forKey:@"context"];
                    [request setPostValue:type forKey:@"xx_type"];
                    [request setPostValue:_msgid forKey:@"msg_id"];
                 
                    request.delegate = self;
                    //异步发送请求
                    [request startAsynchronous];
                    
                     if (ImageArray.count==1) {
                          [HUD hide:YES];
                         [self.navigationController popViewControllerAnimated:YES];

                     }
                    
                    if (ImageArray.count>1) {
                        NSArray *arrayy = [[NSArray alloc] init];
                        for (int i = 1; i <  ImageArray.count; i++) {
                            UIImage *imagess = ImageArray[i];
                            imagess = [CompressionIMAGE compressionData:imagess Size:CGSizeMake(300, 300) Percent:.75];
                            NSString *nstr = [NSString stringWithFormat:@"avater%d",i];
                            arrayy = @[@{nstr:imagess}];
                            [[CommonFunctions sharedlnstance] submission:_msgid PostImages:arrayy requestBlock:^(NSObject *requestData, BOOL IsError) {
                                
                                if (i==ImageArray.count-1) {
//                                    HUD.mode = MBProgressHUDModeText;
//                                    [HUD setLabelText:@"发布成功！"];
//                                    [HUD show:YES];
                                    [HUD hide:YES];
                                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                        // 移除遮盖
                                        
                                        [self.navigationController popViewControllerAnimated:YES];
                                        
                                      
                                    });

                                }
                                
                            }];
                            
                        }
                    }
                    
                }else{
                    HUD.mode = MBProgressHUDModeText;
                    [HUD setLabelText:@"提交失败"];
                    [HUD hide:YES afterDelay:1];
                }
            }else{
                HUD.mode = MBProgressHUDModeText;
                [HUD setLabelText:(NSString *)requestData];
                [HUD hide:YES afterDelay:1];
            }
        }];
        
        

    }
    else
    {
        
      [HUD show:YES];
       NSString *string = [NSString stringWithFormat:@"%@%@",ServiceAddress,@"cgy/appCgyMeg/releaseMsg.do"];
    
        NSURL *url = [NSURL URLWithString:string];
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        
        [request setPostValue:[Globle shareInstance].user_id  forKey:@"user_id"];
        [request setPostValue: [ContentTextView.text stringByReplacingOccurrencesOfString:@" " withString:@""] forKey:@"context"];
        [request setPostValue:type forKey:@"xx_type"];
        [request setPostValue:_msgid forKey:@"msg_id"];
        
        request.delegate = self;
        //异步发送请求
        [request startAsynchronous];
    }
    
    
}


#pragma mark - ASIHTTPRequestDelegate
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSString *re = request.responseString;
    NSDictionary *rd = [re JSONValue];
    
    if([[[rd objectForKey:@"msg"] stringValue] isEqualToString:@"1"])
    {
        if (ImageArray.count==0) {
//            HUD.mode = MBProgressHUDModeText;
//            [HUD setLabelText:@"发布成功！"];
//            [HUD show:YES];
            [HUD hide:YES];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                // 移除遮盖
                
                [self.navigationController popViewControllerAnimated:YES];
                
                return ;
            });
        }
        
        
    }
    else
    {
        HUD.mode = MBProgressHUDModeText;
        [HUD setLabelText:@"发布失败！"];
        [HUD show:YES];
        [HUD hide:YES afterDelay:1];
    }
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
