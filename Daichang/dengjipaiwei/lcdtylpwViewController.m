//
//  lcdtylpwViewController.m
//  HomeAdorn
//
//  Created by mac on 15/8/12.
//  Copyright (c) 2015年 IWork. All rights reserved.
//

#import "lcdtylpwViewController.h"
#import "IntroductGoodsController.h"
#import "cityPickerViewController.h"
#import "Globle.h"
#import "ASIHTTPRequest.h"
#import "JSON.h"
#import "ASIFormDataRequest.h"
#import "BookTableViewCell.h"
#import "YGAddContaccCtr.h"
@interface lcdtylpwViewController   ()<setcityDelegate>
{
    UIView *yincahngview;
    UIView *footvoew;
    UIView *topview;
    UIView *checkView;
    UILabel *lbaddress ;
    NSString *gender;
    NSString *jieyuanpin;
    UILabel *lbwaddress ;
    NSString *sw;
    NSArray *_dataArr;//总数据源
    NSMutableString *_predicateStr;//谓词语句
    UITableView *resulttableview;
    UITextField *passwordTextField;
    NSString *type;
}


@end

@implementation lcdtylpwViewController

- (void)viewDidLoad {
    self.title =_vctitle;
    [super viewDidLoad];
      [self initUItableView];
    // Do any additional setup after loading the view.
    
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [Globle shareInstance].contactsArray.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [resulttableview deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dic = [Globle shareInstance].contactsArray[indexPath.row];
    
    
    if ([type isEqualToString:@"1"]) {
        UITextField *uitext1 = (UITextField *)[self.view viewWithTag:1000];
        UITextField *uiage = (UITextField *)[self.view viewWithTag:1002];
        
        
        uitext1.text = dic[@"lx_name"];
        uiage.text = dic[@"lx_age"];
        
    }
    if ([type isEqualToString:@"2"])
    {
        
        UITextField *uitext2 = (UITextField *)[self.view viewWithTag:100000];
        UITextField *uitext3 = (UITextField *)[self.view viewWithTag:100002];
        
        
        uitext2.text = dic[@"lx_name"];
        uitext3.text = dic[@"phone"];
        lbaddress.text =dic[@"now_address"];
    }
    
    
    
    [resulttableview setHidden:YES];
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    static NSString *CellTableIdentifier = @"BookTableViewCell";
    BOOL nibsRegistered = NO;
    if (!nibsRegistered) {
        UINib *nib = [UINib nibWithNibName:@"BookTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CellTableIdentifier];
        nibsRegistered = YES;
    }
    
    BookTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                               CellTableIdentifier];
    NSDictionary *dic = [Globle shareInstance].contactsArray[indexPath.row];
    
    cell.bookname.text = [dic objectForKey:@"lx_name"];
    return cell;
    
    
}
-(void)initUItableView
{
    resulttableview = [[UITableView alloc] initWithFrame:CGRectMake(105, 40, 150, 200)];
    resulttableview.delegate = self;
    resulttableview.dataSource = self;
    
    [self.view addSubview:resulttableview];
    [resulttableview setHidden:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [[CommonFunctions sharedlnstance] getContact:[Globle shareInstance].user_id requestBlock:^(NSObject *requestData, BOOL IsError) {
        
        NSDictionary *dic= (NSDictionary *)requestData;
        int count = [[dic objectForKey:@"count"] intValue];
        if(count > 0)
        {
            [Globle shareInstance].contactsArray = dic[@"record"];
            
        }
        else
        {
            [Globle shareInstance].contactsArray =nil;
        }
        
    }];
    
}
-(void)InitNavigation{
    [super InitNavigation];
    [NavLeftBtn setImage:[UIImage imageNamed:@"cgyback"] forState:UIControlStateNormal];
    [NavLeftBtn handleControlEvent:UIControlEventTouchDown withBlock:^(id sender) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [NavLeftBtn  setFrame:CGRectMake(0, 0, 25, 25)];
    
}
-(void)setcity:(NSString *)city
{
    if ( [sw isEqualToString:@"sw"]) {
        lbwaddress.text = city;
    }
    else
    {
        lbaddress.text = city;
    }
}


-(void)InitControl{
    
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    topview = [[UIView alloc] initWithFrame:CGRectMake(0,0, viewW, 160)];
    [topview setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:topview];
    
    NSArray *titleArray = @[@"夫姓名",@"妻姓名",@"内容",@"父妻地址",@"填表人姓名"];
    self.view.backgroundColor=[UIColor colorWithRed:(CGFloat)246/255 green:(CGFloat)246/255 blue:(CGFloat)249/255 alpha:1.0];
    float y = 0;
    for (int i = 0; i < titleArray.count; i++) {
        UIView *lines = [[UIView alloc] initWithFrame:CGRectMake(y > 20 ? 20:0, y, winsize.width, .5)];
        lines.backgroundColor = [UIColor lightGrayColor];
        [topview addSubview:lines];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, y+10, 80, 20)];
        titleLabel.textAlignment = NSTextAlignmentRight;
      
        titleLabel.text = [NSString stringWithFormat:@"%@：",titleArray[i]];
        titleLabel.font = [UIFont systemFontOfSize:12];
        [topview addSubview:titleLabel];
        
        if(i !=3)
        {
            
            UITextField *passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(90, y, winsize.width - 100, 40)];
            
            passwordTextField.placeholder = [NSString stringWithFormat:@"请输入%@",titleArray[i]];
            passwordTextField.font = [UIFont systemFontOfSize:12];
            passwordTextField.delegate= self;
            passwordTextField.tag =1000+i;
            [passwordTextField resignFirstResponder];
            [topview addSubview:passwordTextField];
        }
        if (i==3) {
            
            lbwaddress = [[UILabel alloc] initWithFrame:CGRectMake(90, y, winsize.width - 100, 40)];
            lbwaddress.text = @"请输入夫妻地址";
            lbwaddress.textColor = [UIColor grayColor];
            lbwaddress.font = [UIFont systemFontOfSize:12];
            lbwaddress.userInteractionEnabled=YES;
            UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelTouchUpInside:)];
            
            [lbwaddress addGestureRecognizer:labelTapGestureRecognizer];
            
            [topview addSubview:lbwaddress];
            
        }
        
        y += 40;
        
        //        if (i == 2) {
        //            UIView *bottomlines = [[UIView alloc] initWithFrame:CGRectMake(0, y, winsize.width, .5)];
        //            bottomlines.backgroundColor = [UIColor lightGrayColor];
        //            [topview addSubview:bottomlines];
        //        }
        
    }
    
    
    UIView  *clickview = [[UIView alloc] initWithFrame:CGRectMake(0,165, viewW,35)];
    [clickview setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:clickview];
    
    UIImageView *imagev = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 20, 20)];
    imagev.image = [UIImage imageNamed:@"bat_yes"];
    [clickview addSubview:imagev];
    
    UILabel *lb =  [[UILabel alloc] initWithFrame:CGRectMake(40, 10, 230, 20)];
    [lb setText:@"我需要结缘品"];
    lb.font = [UIFont systemFontOfSize:12];
    [clickview addSubview:lb];
    
    UIButton *btnn = [[UIButton alloc] initWithFrame:CGRectMake(0,0, viewW,35)];
    [btnn setTitle:@"click" forState:UIControlStateNormal];
    [btnn addTarget:self action:@selector(showviews:) forControlEvents:UIControlEventTouchUpInside];
    [clickview addSubview:btnn];
    
    
    yincahngview = [[UIView alloc] initWithFrame:CGRectMake(0,220, viewW, 120)];
    [yincahngview setBackgroundColor:[UIColor whiteColor]];
    [yincahngview setHidden:YES];
    NSArray *twoArray = @[@"填表人姓名",@"地址",@"联系电话"];
    float j = 0;
    for (int i = 0; i < twoArray.count; i++) {
        UIView *lines = [[UIView alloc] initWithFrame:CGRectMake(j > 20 ? 20:0, j, winsize.width, .5)];
        lines.backgroundColor = [UIColor lightGrayColor];
        [yincahngview addSubview:lines];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, j+10, 80, 20)];
        titleLabel.textAlignment = NSTextAlignmentRight;
        titleLabel.text = [NSString stringWithFormat:@"%@：",twoArray[i]];
        titleLabel.font = [UIFont systemFontOfSize:12];
        [yincahngview addSubview:titleLabel];
        
        if (i==1) {
            
            lbaddress = [[UILabel alloc] initWithFrame:CGRectMake(90, j, winsize.width - 100, 40)];
            lbaddress.text = @"请填写地址";
            lbaddress.textColor = [UIColor grayColor];
            lbaddress.font = [UIFont systemFontOfSize:12];
            lbaddress.userInteractionEnabled=YES;
            UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelTouchUpInside:)];
            
            [lbaddress addGestureRecognizer:labelTapGestureRecognizer];
            
            [yincahngview addSubview:lbaddress];
            j += 40;
            
            
            
            
        }
        if (i!=1) {
            UITextField *passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(90, j, winsize.width - 100, 40)];
            passwordTextField.placeholder = [NSString stringWithFormat:@"请输入%@",twoArray[i]];
            passwordTextField.font = [UIFont systemFontOfSize:12];
            [passwordTextField resignFirstResponder];
            passwordTextField.delegate= self;
            passwordTextField.tag = 100000+i;
            [yincahngview addSubview:passwordTextField];
            
            if (i==0) {
                UIImageView *ima = [[UIImageView alloc] initWithFrame:CGRectMake(winsize.width - 30, j+10, 20, 15)];
                ima.image = [UIImage imageNamed:@"wzimage2"];
                [yincahngview addSubview:ima];
                UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(winsize.width - 100, j, 100, 20)];
                [btn handleControlEvent:UIControlEventTouchDown withBlock:^(id sender) {
                    type = @"2";
                    [resulttableview setFrame:CGRectMake(150, j+40+140, 150, 200)];
                    if ( [Globle shareInstance].contactsArray.count>0) {
                        [resulttableview reloadData];
                        [resulttableview setHidden:NO];
                    }
                    else
                    {
                        [resulttableview setHidden:YES];
                    }
                }];
                [yincahngview addSubview:btn];
            }
            j += 40;
            
            if (i == 2) {
                UIView *bottomlines = [[UIView alloc] initWithFrame:CGRectMake(0, j, winsize.width, .5)];
                bottomlines.backgroundColor = [UIColor lightGrayColor];
                passwordTextField.keyboardType = UIKeyboardTypePhonePad;
                [yincahngview addSubview:bottomlines];
            }
            
        }
        
    }
    checkView = [[UIView alloc] initWithFrame:CGRectMake(0,340, viewW, 80)];
    [self.view addSubview:checkView];
    [checkView setHidden:YES];
    
    
    NSArray *end = [Globle shareInstance].end;
    for (int i=0; i<end.count; i++) {
        NSDictionary *dit =end[i];
        
        
        
        QRadioButton *_radio1 = [[QRadioButton alloc] initWithDelegate:self groupId:@"jieyuanpin"];
        _radio1.frame = CGRectMake(40, 40*i, 100, 40);
        [_radio1 setTitle:dit[@"jy_name"] forState:UIControlStateNormal];
        [_radio1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_radio1.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
        [_radio1 setChecked:YES];
        [checkView addSubview:_radio1];
        
    }
    
    int h=5;
    for (int i=0; i<end.count; i++) {
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(120, h, 80,30)];
        lb.font = [UIFont systemFontOfSize:12];
        lb.text = @"结缘品介绍";
        [checkView addSubview:lb];
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(120, h, 80,30)];
        [checkView addSubview:btn];
        h = h +40;
        [btn addTarget:self action:@selector(showjyp:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }

    //[yincahngview setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:yincahngview];
    int k = 10;
    footvoew = [[UIView alloc] initWithFrame:CGRectMake(0, 190, viewW, 100)];

    NSArray *btntit = @[@"预览",@"提交"];
    for (int i=0; i<2; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(k, 30, viewW/2-20,40)];
        [btn setBackgroundColor:[UIColor orangeColor]];
        btn.font = [UIFont systemFontOfSize:13];
        [btn setTitle:btntit[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnsubmit:) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.cornerRadius = 5;
        [footvoew addSubview:btn];
        
        k+= viewW/2;
    }
    
    [self.view addSubview:footvoew];
}
- (void)didSelectedRadioButton:(QRadioButton *)radio groupId:(NSString *)groupId {
    
    if([groupId isEqualToString:@"sex"])
    {
        gender = radio.titleLabel.text;
    }
    if([groupId isEqualToString:@"jieyuanpin"])
    {
        jieyuanpin = radio.titleLabel.text;
    }
    
    
}

-(void) labelTouchUpInside:(UITapGestureRecognizer *)recognizer{
    
    UILabel *label=(UILabel*)recognizer.view;
    if([label.text isEqualToString:@"请输入夫妻地址"])
    {
        sw = @"sw";
    }
    else
    {
        sw = @"ts";
    }
    NSLog(@"%@被点击了",label.text);
    cityPickerViewController *citypick = [[cityPickerViewController alloc] init];
    citypick.delegate =self;
    [self.navigationController pushViewController:citypick animated:YES];
}



-(void)showjyp:(UIButton *)btn
{
    IntroductGoodsController *intro = [[IntroductGoodsController alloc] init];
    [self.navigationController pushViewController:intro animated:YES];
}



-(void)showviews:(UIButton *)btn
{
    if (yincahngview.hidden) {
        [yincahngview setHidden:NO];
        [checkView setHidden:NO];
        [footvoew setFrame:CGRectMake(0, 400, viewW, 100)];
    }
    else
    {
        [yincahngview setHidden:YES];
        [checkView setHidden:YES];
        [footvoew setFrame:CGRectMake(0, 190, viewW, 100)];
    }
}
-(bool)checknil
{
    UITextField *uitext1 = (UITextField *)[self.view viewWithTag:1000];
    UITextField *uitext2 = (UITextField *)[self.view viewWithTag:100000];
    UITextField *uitext3 = (UITextField *)[self.view viewWithTag:100002];
    NSString *name=uitext1.text;
    NSString *tbr =uitext2.text;// tbr
    NSString *phone =uitext3.text;// phone
    if (name.length<1) {
        HUD.mode = MBProgressHUDModeText;
        [HUD setLabelText:@"请填写姓名"];
        [HUD show:YES];
        [HUD hide:YES afterDelay:2];
        return false;
    }
    
    return true;
}
-(void)btnsubmit:(UIButton *)btn
{
    if ([btn.titleLabel.text isEqualToString:@"提交"]) {
        
        if ([self checknil]) {
            NSArray *arr = [Globle shareInstance].contactsArray;
            UITextField *uitext1 = (UITextField *)[self.view viewWithTag:1000];
            NSString *name =  uitext1.text;
            if (arr.count>0) {
                int  i=0;
                do {
                    NSDictionary *dicc = arr[i];
                    NSString *aname = dicc[@"lx_name"];
                    
                    if ([aname isEqualToString:name]) {
                        
                        [self btnp];
                        break;
                    }
                    else
                    {
                        i++;
                    }
                    
                    
                }
                while (i<arr.count);
                {
                    if (i==arr.count) {
                        
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"添加此联系人？" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"添加", nil];
                        [alert showWithCompletionHandler:^(NSInteger buttonIndex) {
                            if (buttonIndex == 1) {
                                YGAddContaccCtr *intro = [[YGAddContaccCtr alloc] init];
                                UITextField *uitext1 = (UITextField *)[self.view viewWithTag:1000];
                                intro.contactName=uitext1.text;
                                
                                [self.navigationController pushViewController:intro animated:YES];
                                
                            }else{
                                [self btnp];
                                
                            }
                        }];
                        
                    }
                    
                }
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"添加此联系人？" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"添加", nil];
                [alert showWithCompletionHandler:^(NSInteger buttonIndex) {
                    if (buttonIndex == 1) {
                        YGAddContaccCtr *intro = [[YGAddContaccCtr alloc] init];
                        UITextField *uitext1 = (UITextField *)[self.view viewWithTag:1000];
                        intro.contactName=uitext1.text;
                        
                        [self.navigationController pushViewController:intro animated:YES];
                        
                    }else{
                        [self btnp];
                        
                    }
                }];
                
            }
            
            
            
            
        }
        else
        {
            
        }
        
        
    }
    if ([btn.titleLabel.text isEqualToString:@"预览"]) {
        
    }
}


-(void)btnp{
    UITextField *fname = (UITextField *)[self.view viewWithTag:1000];
    UITextField *qname = (UITextField *)[self.view viewWithTag:1001];
    UITextField *neirong = (UITextField *)[self.view viewWithTag:1002];
    
    
    UITextField *uitext2 = (UITextField *)[self.view viewWithTag:100000];
    UITextField *uitext3 = (UITextField *)[self.view viewWithTag:100002];
    NSString *ffname=fname.text;
    NSString *qqname=qname.text;
    NSString *nneirong=fname.text;
    NSString *tbr =uitext2.text;
    NSString *phone =uitext3.text;

    
    
    
    
    NSString *isiy;
    if(tbr.length>0&&phone.length>0)
    {
        isiy =@"yes";
    }
    else
    {
        isiy = @"no";
    }
    
    NSString *x =@"";
    
    if ([gender isEqualToString:@"男"]) {
        x =@"1";
    }
    else
    {
        x =@"2";
    }
    
    if ([jieyuanpin isEqualToString:@"佛珠"]) {
        jieyuanpin =@"1";
    }
    else
    {
        jieyuanpin =@"2";
    }
    
 
    

    NSString *string = [NSString stringWithFormat:@"%@%@",ServiceAddress,@"cgy/appRemoteServ/saveZtlz.do"];
    NSURL *url = [NSURL URLWithString:string];
    NSString *addres = lbaddress.text;
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:[Globle shareInstance].user_id forKey:@"user_id"];
    [request setPostValue:ffname forKey:@"fu_name"];
    [request setPostValue:qqname forKey:@"qi_name"];
    [request setPostValue:lbwaddress.text forKey:@"zt_address"];
    [request setPostValue:tbr forKey:@"zt_tbr"];
    [request setPostValue:isiy forKey:@"is_jy"];
    [request setPostValue:_dicInfo[@"id"] forKey:@"sm_id"];
    [request setPostValue:tbr forKey:@"tbr"];
    [request setPostValue:addres forKey:@"address"];
    [request setPostValue:phone forKey:@"phone"];
    [request setPostValue:jieyuanpin forKey:@"jy_id"];
    
    
    request.delegate = self;
    //异步发送请求
    [request startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSString *re = request.responseString;
    NSDictionary *rd = [re JSONValue];
    if([[[rd objectForKey:@"msg"] stringValue] isEqualToString:@"1"])
    {
        HUD.mode = MBProgressHUDModeText;
        [HUD setLabelText:@"提交成功！"];
        [HUD show:YES];
        [HUD hide:YES afterDelay:1];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 移除遮盖
            
            [self.navigationController popViewControllerAnimated:YES];
            
            return ;
        });
        
    }
    else
    {
        HUD.mode = MBProgressHUDModeText;
        [HUD setLabelText:@"提交失败！"];
        [HUD show:YES];
        [HUD hide:YES afterDelay:1];
    }
    
    
}


@end
