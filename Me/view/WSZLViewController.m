//
//  WSZLViewController.m
//  Ciguangyin
//
//  Created by mac on 15/7/10.
//  Copyright (c) 2015年 ddsw. All rights reserved.
//

#import "WSZLViewController.h"
#import "KYforgetPwdCtr.h"
#import "Globle.h"
#import "ASIHTTPRequest.h"
#import "JSON.h"
#import "ASIFormDataRequest.h"
#import "UIImageView+MJWebCache.h"
#import "UIImageView+LBBlurredImage.h"
#import "CompressionIMAGE.h"
#import "Globle.h"
#import "MBProgressHUD+MJ.h"
@interface WSZLViewController ()

{
    UITableView *metableview;
    UIImage *avatarImage;
    UITextField *phonetext;
    UITextField *nametext;
    UITextField *signtext;
    NSArray *dataArray,*contentArray;
    UIImageView *userAvatar;
    UIImageView *topview;
}

@property(nonatomic,strong) UIImageView *avatarImageView;


@end

@implementation WSZLViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
}


-(void)InitControl{

     topview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, viewW, 120)];
    topview.userInteractionEnabled = YES;
    
    [topview didImageViewClick:^(UIImage *Image) {
        [self openMenu:1];
    }];
    NSString *Userlogo=@"";
    NSString * d= [Globle shareInstance].image_url;
    if (d!=nil) {
        Userlogo = [IMAGEURL stringByAppendingString:d];
    }
    if(Userlogo.length>1)
    {
        if([[Globle shareInstance].isLogThree  isEqualToString:@"y"])
        {
          
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                NSURL *portraitUrl = [NSURL URLWithString: d];
                UIImage *protraitImg = [UIImage imageWithData:[NSData dataWithContentsOfURL:portraitUrl]];
                [topview setImageToBlur:protraitImg
                             blurRadius:kLBBlurredImageDefaultBlurRadius
                        completionBlock:^(){
                            
                        }];
            });

        }
        else
        {
            
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                NSURL *portraitUrl = [NSURL URLWithString: Userlogo];
                UIImage *protraitImg = [UIImage imageWithData:[NSData dataWithContentsOfURL:portraitUrl]];
                
                [topview setImageToBlur:protraitImg
                             blurRadius:kLBBlurredImageDefaultBlurRadius
                        completionBlock:^(){
                            
                        }];

            });
        }
    }
    else
    {
        _avatarImageView.image =  [UIImage imageNamed:@"defaultcgy"];
    }
    
    
    
    [self.view addSubview:topview];
    avatarImage = [UIImage imageNamed:@"UserImage.png"];
    _avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.5-35,10 , 70, 70)];
    _avatarImageView.layer.masksToBounds = YES;
    _avatarImageView.layer.cornerRadius = _avatarImageView.frame.size.width/2;
    _avatarImageView.image =avatarImage;
    
    if(Userlogo.length>1)
    {
        if([[Globle shareInstance].isLogThree  isEqualToString:@"y"])
        {
          [_avatarImageView setImageURLStr:d placeholder:[UIImage imageNamed:@"defaultcgy"]];
        }
        else
        {
            [_avatarImageView setImageURLStr:Userlogo placeholder:[UIImage imageNamed:@"defaultcgy"]];
        }
    }
    else
    {
        _avatarImageView.image =  [UIImage imageNamed:@"defaultcgy"];
    }
    
    
    
    UILabel *lvtitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, viewW, 20)];
    lvtitle.text = [Globle shareInstance].user_name;
    lvtitle.font = [UIFont systemFontOfSize:13];
    lvtitle.textAlignment = NSTextAlignmentCenter;
    lvtitle.textColor = [UIColor whiteColor];
    lvtitle.font = [UIFont systemFontOfSize: 16];
    [topview addSubview:_avatarImageView];
    [topview addSubview:lvtitle];
    
    UIImageView *middleView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 120, viewW, 120)];
    middleView.userInteractionEnabled = YES;
    [self.view addSubview:middleView];
    
    //帐号
    UILabel *accountLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 30, 30)];
    accountLab.text = @"帐号";
    accountLab.font = [UIFont systemFontOfSize:13];
    [middleView addSubview:accountLab];
    
    
    phonetext = [[UITextField alloc] initWithFrame:CGRectMake(70, 20, 300, 30)];
    phonetext.text = [Globle shareInstance].user_id;
    phonetext.font = [UIFont systemFontOfSize:13];
    phonetext.enabled = NO;
    [middleView addSubview:phonetext];
    
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(10, 52, 300, 0.5)];
    line.alpha = 0.5;
    line.backgroundColor = [UIColor lightGrayColor];
    [middleView addSubview:line];
    
    //名称
    UILabel *nameLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 60, 80, 30)];
    nameLab.text = @"名称";
    nameLab.font = [UIFont systemFontOfSize:13];
    [middleView addSubview:nameLab];
    
    
    nametext = [[UITextField alloc] initWithFrame:CGRectMake(70, 60, 300, 30)];
    nametext.text = [Globle shareInstance].user_name;
    nametext.font = [UIFont systemFontOfSize:13];
    nametext.delegate = self;
    [middleView addSubview:nametext];
    
    
    
    
    UILabel *lineTwo = [[UILabel alloc]initWithFrame:CGRectMake(10, 92, 300, 0.5)];
    lineTwo.alpha = 0.5;
    lineTwo.backgroundColor = [UIColor lightGrayColor];
    [middleView addSubview:lineTwo];
    
    //签名
    UILabel *signatureLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, 80, 30)];
    signatureLab.text = @"签名";
    signatureLab.font = [UIFont systemFontOfSize:13];
    [middleView addSubview:signatureLab];
    
    signtext = [[UITextField alloc] initWithFrame:CGRectMake(70, 100, 300, 30)];
    signtext.text = [Globle shareInstance].user_sign;
    signtext.font = [UIFont systemFontOfSize:13];
    signtext.delegate = self;
    [middleView addSubview:signtext];
    
    
    UILabel *lineThree = [[UILabel alloc]initWithFrame:CGRectMake(10, 132, 300, 0.5)];
    lineThree.alpha = 0.5;
    lineThree.backgroundColor = [UIColor lightGrayColor];
    [middleView addSubview:lineThree];
    
    UIButton *btnbaoming = [[UIButton alloc] initWithFrame:CGRectMake(30, 260, viewW-60, 40)];
    [btnbaoming setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnbaoming setFont:[UIFont systemFontOfSize:12]];
    [btnbaoming setImage:[UIImage imageNamed:@"btnmo"] forState:UIControlStateNormal];
    [btnbaoming setTitle:@"提交" forState:UIControlStateNormal];
    [btnbaoming setImage:[UIImage imageNamed:@"btnhi"] forState:UIControlStateHighlighted];
    btnbaoming.titleEdgeInsets = UIEdgeInsetsMake(0, -540,0, 0);//设置title在button上的位置（上top，左left，下bottom，右right）
    [btnbaoming setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnbaoming.titleLabel.textAlignment = NSTextAlignmentCenter;//设置title的字体居中
    btnbaoming.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [btnbaoming addTarget:self action:@selector(btnp) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.view addSubview:btnbaoming];
    

    
}


-(void)AlbumImage:(NSObject *)albumImage{
    NSArray *imageArray;
    NSMutableArray *selectedArray = (NSMutableArray *)albumImage;
    for (NSDictionary *dic in selectedArray) {
        if([dic objectForKey:UIImagePickerControllerMediaType] == ALAssetTypePhoto){
            if ([dic objectForKey:UIImagePickerControllerOriginalImage]) {
                UIImage *image = [dic objectForKey:UIImagePickerControllerOriginalImage];
              
                image = [CompressionIMAGE compressionData:image Size:CGSizeMake(100, 100) Percent:.75];
                userAvatar.image = image;
                
                imageArray = @[@{@"avater":image}];
            }
        }
    }
    //    [HUD show:YES];
    
    HUD = [[MBProgressHUD alloc]init];
    HUD.delegate = self;
    [self.view addSubview:HUD];
    HUD.mode = MBProgressHUDModeIndeterminate;
    HUD.labelText = @"上传中……";
    [HUD show:YES];
    [[CommonFunctions sharedlnstance] upAvater:[Globle shareInstance].user_id PostImages:imageArray requestBlock:^(NSObject *requestData, BOOL IsError) {
        if (!IsError) {
            [HUD hide:YES];
            NSDictionary *dic = (NSDictionary *)requestData;
            if ([[[dic objectForKey:@"msg"] stringValue] isEqualToString:@"1"]) {
                
                [[CommonFunctions sharedlnstance] LoginCgy:[Globle shareInstance].user_id  Password: [Globle shareInstance].pwd requestBlock:^(NSObject *requestData, BOOL IsError) {
                    [HUD hide:YES];
                    if (!IsError) {
                        
                        NSDictionary *dic = (NSDictionary *)requestData;
    
                    [Globle shareInstance].image_url =[dic objectForKey:@"image_url"];
                                                   }
                    HUD.mode = MBProgressHUDModeText;
                    [HUD setLabelText:@"上传成功！"];
                    [HUD show:YES];
                    [HUD hide:YES afterDelay:1];

                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        // 移除遮盖
                        
                        [self.navigationController popViewControllerAnimated:YES];
                        
                        return ;
                    });

                    

                   
                }];
                                
            }else{
                HUD.mode = MBProgressHUDModeText;
                [HUD setLabelText:@"上传失败！"];
                [HUD hide:YES afterDelay:1];
            }
        }else{
            HUD.mode = MBProgressHUDModeText;
            [HUD setLabelText:(NSString *)requestData];
            [HUD hide:YES afterDelay:1];
        }
    }];
}


-(void)btnp
{
    NSLog(@"修改资料");
    NSString *phone = phonetext.text;
    NSString *name = nametext.text;
    NSString *sign = signtext.text;
    
    
    NSString *username = [Globle shareInstance].user_id;;
    
    //user_id、user_name、user_sign、user_number

    NSString *string = [NSString stringWithFormat:@"%@%@",ServiceAddress,@"cgy/appCgy/baseInfo.do"];
    NSURL *url = [NSURL URLWithString:string];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:[Globle shareInstance].user_id forKey:@"user_id"];
    [request setPostValue:name forKey:@"user_name"];
    [request setPostValue:sign forKey:@"user_sign"]; //
    [request setPostValue:[Globle shareInstance].image_url forKey:@"image_url"]; //
    [request setPostValue:[Globle shareInstance].user_id  forKey:@"user_number"];
    request.delegate = self;
    //异步发送请求
    [request startAsynchronous];


}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSString *re = request.responseString;
    NSDictionary *rd = [re JSONValue];
    NSString *name = nametext.text;
    NSString *sign = signtext.text;
    if([[[rd objectForKey:@"msg"] stringValue] isEqualToString:@"1"])
    {
        HUD.mode = MBProgressHUDModeText;
        [HUD setLabelText:@"修改成功！"];
        [HUD show:YES];
        [HUD hide:YES afterDelay:1];
        [Globle shareInstance].user_name =name;
        [Globle shareInstance].user_sign =sign;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 移除遮盖
            
            [self.navigationController popViewControllerAnimated:YES];
            
            return ;
        });
        
    }
    else
    {
        HUD.mode = MBProgressHUDModeText;
        [HUD setLabelText:@"修改失败！"];
        [HUD show:YES];
        [HUD hide:YES afterDelay:1];
    }
    
    
}

- (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size
{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

-(void)InitNavigation{
    [super InitNavigation];
    [NavLeftBtn setImage:[UIImage imageNamed:@"cgyback"] forState:UIControlStateNormal];
    [NavLeftBtn handleControlEvent:UIControlEventTouchDown withBlock:^(id sender) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [NavRightBtn setFrame:CGRectMake(0, 0, 65, 30)];
    [NavLeftBtn  setFrame:CGRectMake(0, 0, 25, 25)];
    [NavRightBtn setTitle:@"修改密码" forState:UIControlStateNormal];
    [NavRightBtn setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [NavRightBtn addTarget:self action:@selector(modifyPwd) forControlEvents:UIControlEventTouchUpInside];
    [AppUtils getUid];
}

-(void)modifyPwd{
    
    [self.navigationController pushViewController:[[KYforgetPwdCtr alloc]init] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
