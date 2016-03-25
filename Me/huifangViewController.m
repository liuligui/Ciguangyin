

//
//  huifangViewController.m
//  HomeAdorn
//
//  Created by liuligui on 15/11/7.
//  Copyright © 2015年 IWork. All rights reserved.
//
#import "PublishViewController.h"
#import "Globle.h"
#import "DropDownListView.h"
#import "ASIHTTPRequest.h"
#import "JSON.h"
#import "ASIFormDataRequest.h"
#import "huifangViewController.h"

@interface huifangViewController ()
{
    NSString *iskai;
    NSArray *pickerArray;
    NSString *locationString;
}

@end

@implementation huifangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"回访";
    _username.text = _name;
    [_kaiguan addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    pickerArray = [NSArray arrayWithObjects:@"全好",@"好转",@"没灵感",@"上土",@"下泄",@"上吐下泻",@"睡眠不好",@"饮食不好",@"排泄不好",@"新增病症",@"没有来访", nil];
    _textf.inputView = _selectPicker;
    _textf.inputAccessoryView = _doneToolbar;
    _textf.delegate = self;
    _textf.text = @"全好";
    _selectPicker.delegate = self;
    _selectPicker.dataSource = self;
    //_selectPicker.frame = CGRectMake(0, 480, 320, 216);
   // textField.delegate =self;
    _selectPicker.delegate =self;
    _selectPicker.dataSource =self;
    
    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    
    locationString=[dateformatter stringFromDate:senddate];
    
    _datetimes.text = locationString;
    // Do any additional setup after loading the view from its nib.
}
-(void)switchAction:(id)sender
{
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        iskai = @"是";
    }else {
        iskai = @"否";
    }
}

-(void)InitNavigation{
    [super InitNavigation];
    [NavLeftBtn setImage:[UIImage imageNamed:@"cgyback"] forState:UIControlStateNormal];
    [NavLeftBtn handleControlEvent:UIControlEventTouchDown withBlock:^(id sender) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [NavLeftBtn  setFrame:CGRectMake(0, 0, 25, 25)];
    
    [NavRightBtn  setFrame:CGRectMake(0, 0, 60, 25)];
    [NavLeftBtn  setFrame:CGRectMake(0, 0, 25, 25)];
    [NavRightBtn setTitle:@"确定" forState:UIControlStateNormal];
    [NavRightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [NavRightBtn handleControlEvent:UIControlEventTouchDown withBlock:^(id sender) {
     
        [self huifang];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)huifang
{
    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    
    NSString *locationString=[dateformatter stringFromDate:senddate];
    

    
    //id (回访id) insm (是否在寺) hf_result (回访结果) hf_date (日期)
    NSString *username = [Globle shareInstance].user_id;
    NSString *string = [NSString stringWithFormat:@"%@%@",ServiceAddress,@"cgy/appRemoteServ/saveQfzbHf.do"];
    NSURL *url = [NSURL URLWithString:string];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    
    [request setPostValue:_mid  forKey:@"id"];
    [request setPostValue:iskai  forKey:@"insm"];
    [request setPostValue:_textf.text forKey:@"hf_result"];
    [request setPostValue:_datetimes.text forKey:@"hf_date"];
    
    request.delegate = self;
    //异步发送请求
    [request startAsynchronous];
}


#pragma mark - ASIHTTPRequestDelegate
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSString *re = request.responseString;
    NSDictionary *rd = [re JSONValue];
    
    
    if([[[rd objectForKey:@"msg"] stringValue] isEqualToString:@"1"])
    {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 移除遮盖
            
            [self.navigationController popViewControllerAnimated:YES];
            
            return ;
        });
        
    }
    else
    {
        HUD.mode = MBProgressHUDModeText;
        [HUD setLabelText:@"回访失败！"];
        [HUD show:YES];
        [HUD hide:YES afterDelay:1];
    }
    
    
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [pickerArray count];
}
-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [pickerArray objectAtIndex:row];
  
    
}
- (IBAction)btnshow:(id)sender {
    _selectPicker.hidden = NO;
    _doneToolbar.hidden = NO;
}
- (IBAction)selectButton:(id)sender {
    NSInteger row = [_selectPicker selectedRowInComponent:0];
    NSString *dd = [pickerArray objectAtIndex:row];
    _textf.text = dd;
    _selectPicker.hidden = YES;
    _doneToolbar.hidden = YES;
}




@end
