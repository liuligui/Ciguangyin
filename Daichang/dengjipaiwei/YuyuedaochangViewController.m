//
//  YuyuedaochangViewController.m
//  HomeAdorn
//
//  Created by mac on 15/8/3.
//  Copyright (c) 2015年 IWork. All rights reserved.
//

#import "YuyuedaochangViewController.h"
#import "cityPickerViewController.h"
#import "CommonFunctions.h"
#import "Globle.h"
#import "ASIHTTPRequest.h"
#import "JSON.h"
#import "ASIFormDataRequest.h"
#import "BookTableViewCell.h"
@interface YuyuedaochangViewController ()<setcityDelegate>
{
    NSString *btn;
    NSArray *_dataArr;//总数据源
    NSMutableString *_predicateStr;//谓词语句
    UITableView *resulttableview;
    UITextField *passwordTextField;
    NSString *type;
}
@property (nonatomic, strong)UIActionSheet *sheet;
@end

@implementation YuyuedaochangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"预约道场";
    [self initUItableView];
}


-(void)InitNavigation{
    [super InitNavigation];
    [NavLeftBtn setImage:[UIImage imageNamed:@"cgyback"] forState:UIControlStateNormal];
    [NavLeftBtn handleControlEvent:UIControlEventTouchDown withBlock:^(id sender) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [NavLeftBtn  setFrame:CGRectMake(0, 0, 25, 25)];
    
}
- (IBAction)selectpersion:(id)sender {
    //105, 110, 150, 200
    type = @"2";
    [resulttableview setFrame:CGRectMake(105, 440, 150, 200)];
    if ( [Globle shareInstance].contactsArray.count>0) {
        [resulttableview reloadData];
        [resulttableview setHidden:NO];
    }
    else
    {
        [resulttableview setHidden:YES];
    }
    
}


- (IBAction)choosec:(id)sender {
     type = @"1";
     [resulttableview setFrame:CGRectMake(105, 110, 150, 200)];
    if ( [Globle shareInstance].contactsArray.count>0) {
        [resulttableview reloadData];
        [resulttableview setHidden:NO];
    }
    else
    {
        [resulttableview setHidden:YES];
    }
}

-(void)initUItableView
{
    NSArray *arr = [Globle shareInstance].contactsArray;
    _dataArr=[[NSArray alloc] initWithArray:arr];
    _predicateStr=[[NSMutableString alloc] init];
    _scroview.userInteractionEnabled = YES;
    _scroview.showsVerticalScrollIndicator = YES;
    [ _scroview setContentSize:CGSizeMake(viewW, 1000)];
    _scroview.scrollEnabled = YES;
    
    resulttableview = [[UITableView alloc] initWithFrame:CGRectMake(105, 110, 150, 200)];
    resulttableview.delegate = self;
    resulttableview.dataSource = self;
    resulttableview.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [_scroview addSubview:resulttableview];
    [resulttableview setHidden:YES];
}

-(void)valueChanged:(UITextField *)text
{
    NSString *name =  text.text;
    
    
    _predicateStr=[NSMutableString stringWithFormat:@""];
    
    [_predicateStr appendString:[NSString stringWithFormat:@"self.lx_name CONTAINS [CD] '%@' OR ",name]];
    
    
    [_predicateStr deleteCharactersInRange:NSMakeRange(_predicateStr.length-4,4)];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:_predicateStr];
    
    _searchResultArr = [NSMutableArray arrayWithArray:[_dataArr filteredArrayUsingPredicate:predicate]];
    
    [resulttableview reloadData];
    if (_searchResultArr.count>0) {
        [resulttableview setHidden:NO];
    }
    else
    {
        [resulttableview setHidden:YES];
    }
    
}


- (IBAction)btnsex:(id)sender {
    
    [self choosesex];
}
- (IBAction)idaddress:(id)sender {
    
    cityPickerViewController *citypick = [[cityPickerViewController alloc] init];
    citypick.delegate =self;
    btn = @"idaddress";
    [self.navigationController pushViewController:citypick animated:YES];
}
- (IBAction)nowaddress:(id)sender {
    
    cityPickerViewController *citypick = [[cityPickerViewController alloc] init];
    citypick.delegate =self;
     btn = @"nowaddress";
    [self.navigationController pushViewController:citypick animated:YES];
}

- (IBAction)familyaddress:(id)sender {
    
    cityPickerViewController *citypick = [[cityPickerViewController alloc] init];
    citypick.delegate =self;
      btn = @"familyaddress";
    [self.navigationController pushViewController:citypick animated:YES];
}
- (IBAction)famliyhealth:(id)sender {
    
    [self choosehealth];
}
-(void)setcity:(NSString *)city
{
    if ([btn isEqualToString:@"idaddress"]) {
       [_idaddress setTitle:city forState:UIControlStateNormal];
    }
    if ([btn isEqualToString:@"nowaddress"]) {
        [_nowaddress setTitle:city forState:UIControlStateNormal];
    }
    if ([btn isEqualToString:@"familyaddress"]) {
        [_famlieaddress setTitle:city forState:UIControlStateNormal];
    }
}
-(void)yydc
{
    if ([self chenckNull]) {
        

        [self btnp];
    }
    else
    {
        HUD.mode = MBProgressHUDModeText;
        [HUD setLabelText:@"请填写完整资料！"];
        [HUD show:YES];
        [HUD hide:YES afterDelay:1];
    }
}


-(void)btnp
{
    
    NSString *username = [Globle shareInstance].user_id;;
      NSString *x =@"";
    
    if ([_sex.titleLabel.text isEqualToString:@"男"]) {
        x =@"1";
    }
    else
    {
        x =@"2";
    }
    
    NSString *string = [NSString stringWithFormat:@"%@%@",ServiceAddress,@"cgy/appRemoteServ/saveYuDing.do"];
    NSURL *url = [NSURL URLWithString:string];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:[Globle shareInstance].user_id forKey:@"user_id"];
    [request setPostValue:username forKey:@"user_id"];
    [request setPostValue:_name.text forKey:@"yy_name"];
    [request setPostValue:x forKey:@"yy_sex"];
    [request setPostValue:_age.text forKey:@"yy_age"];
    [request setPostValue:_idno.text forKey:@"yy_id"];
    [request setPostValue:_idaddress.titleLabel.text forKey:@"id_address"];
    [request setPostValue:_nowaddress.titleLabel.text forKey:@"now_address"];
    [request setPostValue:_phone.text forKey:@"yy_phone"];
    [request setPostValue:_email.text forKey:@"yy_email"];
    [request setPostValue:_email.text forKey:@"js_name"];
    [request setPostValue:_familephone.text  forKey:@"js_phone"];
    [request setPostValue:_famlieaddress.titleLabel.text forKey:@"js_address"];
    
    [request setPostValue:_health.titleLabel.text forKey:@"health"];
    [request setPostValue:_cometime forKey:@"come_time"];
    [request setPostValue:_gotime forKey:@"go_time"];
    [request setPostValue:_smid forKey:@"sm_id"];
    
    
    [request setPostValue:[Globle shareInstance].user_id  forKey:@"user_number"];
    request.delegate = self;
    //异步发送请求
    [request startAsynchronous];
    
    
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
    
    if ([type isEqualToString:@"2"]) {
        _familename.text = dic[@"lx_name"];
        _familephone.text = dic[@"phone"];
        [_famlieaddress setTitle: dic[@"id_address"] forState:UIControlStateNormal];
        
        
    }
    else
    {
        _name.text = dic[@"lx_name"];
        // _sex.text = dic[@"lx_sex"];
        _age.text = dic[@"lx_age"];
        _idno.text = dic[@"lx_name"];
        _phone.text = dic[@"phone"];
        _email.text = dic[@"lx_email"];
        _familename.text = dic[@"lx_familename"];
        _familephone.text = dic[@"other_phone"];
        [_idaddress setTitle:dic[@"id_address"] forState:UIControlStateNormal];
        [_nowaddress setTitle: dic[@"other_address"] forState:UIControlStateNormal];
        [_famlieaddress setTitle: dic[@"other_address"] forState:UIControlStateNormal];
        
        
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
    cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
    cell.bookname.text = [dic objectForKey:@"lx_name"];
    return cell;
    
    
}
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSString *re = request.responseString;
    NSDictionary *rd = [re JSONValue];
    if([[[rd objectForKey:@"msg"] stringValue] isEqualToString:@"1"])
    {
        HUD.mode = MBProgressHUDModeText;
        [HUD setLabelText:@"预约成功！"];
        [HUD show:YES];
        [HUD hide:YES afterDelay:1];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 移除遮盖
            
//             [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
            
            [self.navigationController popViewControllerAnimated:YES];
            
           
        });
        
    }
    else
    {
        HUD.mode = MBProgressHUDModeText;
        [HUD setLabelText:@"预约失败！"];
        [HUD show:YES];
        [HUD hide:YES afterDelay:1];
    }
    
    
}

-(void)UIInit
{

     _name.delegate = self;
     _age.delegate = self;
     _idno.delegate = self;
     _phone.delegate = self;
     _email.delegate = self;
     _familename.delegate = self;
     _familephone.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 *
 */
- (void)choosesex{
    
    _sheet = [[UIActionSheet alloc] initWithTitle:@"请选择性别" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"男",@"女", nil];
    _sheet.tag = 10001;
   [_sheet showInView:self.view];
    
}
- (void)choosehealth{
    
    _sheet = [[UIActionSheet alloc] initWithTitle:@"请选择身体状况" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"儿童",@"孕妇",@"普通障碍",@"严重障碍", nil];
    _sheet.tag = 10002;
    [_sheet showInView:self.view];
    
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (_sheet.tag == 10001) {
        if (buttonIndex == _sheet.cancelButtonIndex) {
            NSLog(@"取消");
            
        }
        switch (buttonIndex) {
            case 0:
                [_sex setTitle:@"男" forState:UIControlStateNormal];
                break;
            case 1:
                [_sex setTitle:@"女" forState:UIControlStateNormal];
                break;
                
            default:
                break;
        }
    }
    if (_sheet.tag == 10002) {
        if (buttonIndex == _sheet.cancelButtonIndex) {
            NSLog(@"取消");
            
        }
        switch (buttonIndex) {
            case 0:
                [_health setTitle:@"儿童" forState:UIControlStateNormal];
                break;
            case 1:
                [_health setTitle:@"孕妇" forState:UIControlStateNormal];
                break;
            case 2:
                [_health setTitle:@"普通障碍" forState:UIControlStateNormal];
                break;
            case 3:
                [_health setTitle:@"严重障碍" forState:UIControlStateNormal];
                break;
                
                
            default:
                break;
        }
    }
   
}
- (IBAction)submit:(id)sender {
    [self yydc];
}

-(BOOL)chenckNull
{
    if (_name.text.length<1) {
        return false;
    }
    if (_age.text.length<1) {
        return false;
    }
    if (_idno.text.length<1) {
        return false;
    }
    if (_email.text.length<1) {
        return false;
    }
    if (_familename.text.length<1) {
        return false;
    }
    if (_familephone.text.length<1) {
        return false;
    }
    if (_idaddress.titleLabel.text.length<1) {
        return false;
    }
    if (_nowaddress.titleLabel.text.length<1) {
        return false;
    }
    if (_famlieaddress.titleLabel.text.length<1) {
        return false;
    }
    if (_health.titleLabel.text.length<1) {
        return false;
    }
    if (_sex.titleLabel.text.length<1) {
        return false;
    }

    return YES;
}
@end
