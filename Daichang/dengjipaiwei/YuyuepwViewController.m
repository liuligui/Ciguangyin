

//
//  YuyuepwViewController.m
//  HomeAdorn
//
//  Created by mac on 15/8/3.
//  Copyright (c) 2015年 IWork. All rights reserved.
//

#import "YuyuepwViewController.h"
#import "YuyuedaochangViewController.h"
@interface YuyuepwViewController ()
{
    NSString *a;
}

@end

@implementation YuyuepwViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self dataInit];

    // Do any additional setup after loading the view from its nib.
}

-(void)dataInit
{
    
    [[CommonFunctions sharedlnstance] getBadNum:_smid requestBlock:^(NSObject *requestData, BOOL IsError) {

        NSDictionary *dic= (NSDictionary *)requestData;
        _week1.text =[NSString stringWithFormat:@"%@" ,dic[@"last_bak_num"]];
        _week2.text =[NSString stringWithFormat:@"%@" ,dic[@"bak_num"]];
        
    }];

}
-(BOOL)checkNull
{
    if (_time1.text.length<1) {
        return false;
    }
    if (_time2.text.length<1) {
        return false;
    }
    
    
    
    return YES;
    
}
-(void)InitNavigation{
    [super InitNavigation];
    [NavLeftBtn setImage:[UIImage imageNamed:@"cgyback"] forState:UIControlStateNormal];
    [NavLeftBtn handleControlEvent:UIControlEventTouchDown withBlock:^(id sender) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [NavRightBtn  setFrame:CGRectMake(0, 0, 60, 25)];
    [NavLeftBtn  setFrame:CGRectMake(0, 0, 25, 25)];
    
    [NavRightBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [NavRightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [NavRightBtn handleControlEvent:UIControlEventTouchDown withBlock:^(id sender) {
        
        if ([self checkNull]) {
            NSString * d = [self intervalFromLastDate:[NSString stringWithFormat:@"%@ 00:00:00",_time1.text]  toTheDate:[NSString stringWithFormat:@"%@ 00:00:00",_time2.text] ];
            
            int a = [d intValue];
            if (a > 0) {
               int b = a / 24;
                
                if (b>7) {
                    HUD.mode = MBProgressHUDModeText;
                    [HUD setLabelText:@"离寺日期不能超过到寺日期 7 天"];
                    [HUD show:YES];
                    [HUD hide:YES afterDelay:1];

                }
                else
                {
                    YuyuedaochangViewController *vc = [[YuyuedaochangViewController alloc] init];
                    vc.smid =_smid;
                    vc.cometime = _time1.text;
                    vc.gotime = _time2.text;
                    [self.navigationController pushViewController:vc animated:YES];
                }
            }
            else
            {
                int c = a / 24;
                if (c == 0)
                {
                    YuyuedaochangViewController *vc = [[YuyuedaochangViewController alloc] init];
                    vc.smid =_smid;
                    vc.cometime = _time1.text;
                    vc.gotime = _time2.text;
                    [self.navigationController pushViewController:vc animated:YES];
                }
                else
                {
                    HUD.mode = MBProgressHUDModeText;
                    [HUD setLabelText:@"离寺日期不能早于到寺日期"];
                    [HUD show:YES];
                    [HUD hide:YES afterDelay:1];
                }

               
                
            }
            
            
        }
        else
        {
            
            HUD.mode = MBProgressHUDModeText;
            [HUD setLabelText:@"请完善日期"];
            [HUD show:YES];
            [HUD hide:YES afterDelay:1];
        }

        
     
    }];
    
    _time1.delegate = self;
    _time1.tag = 10001;
    _time1.returnKeyType = UIReturnKeyDone;
    _time2.delegate = self;
    _time2.tag = 10002;
    _time2.returnKeyType = UIReturnKeyDone;
    _datetime.datePickerMode = UIDatePickerModeDate;    
    [_datetime addTarget:self action:@selector(chooseDate:) forControlEvents:UIControlEventValueChanged];
    _viewB.hidden = YES;
}

- (void)chooseDate:(UIDatePicker *)sender {
    
    NSDate *selectedDate = sender.date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";//yyyy-MM-dd HH:mm
    NSString *dateString = [formatter stringFromDate:selectedDate];
    if ([a isEqualToString:@"time1"]) {
         _time1.text = dateString;
    }
    else
    {
         _time2.text = dateString;
    }
   
}
#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [_time1 resignFirstResponder];
    [_time2 resignFirstResponder];
    if (textField.tag == 10001) {
        a = @"time1";
    }
    else
    {
        a = @"time2";
    }
    _viewB.hidden = NO;
    

    return NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)OK:(id)sender {
    [self chooseDate:_datetime];
    _viewB.hidden = YES;
}




- (NSString *)intervalFromLastDate: (NSString *) dateString1  toTheDate:(NSString *) dateString2
{
    NSArray *timeArray1=[dateString1 componentsSeparatedByString:@"."];
    dateString1=[timeArray1 objectAtIndex:0];
    
    NSArray *timeArray2=[dateString2 componentsSeparatedByString:@"."];
    dateString2=[timeArray2 objectAtIndex:0];
    
    NSLog(@"%@.....%@",dateString1,dateString2);
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *d1=[date dateFromString:dateString1];
    
    NSTimeInterval late1=[d1 timeIntervalSince1970]*1;
    
    NSDate *d2=[date dateFromString:dateString2];
    
    NSTimeInterval late2=[d2 timeIntervalSince1970]*1;
    
    NSTimeInterval cha=late2-late1;
    NSString *timeString=@"";
    NSString *house=@"";
    NSString *min=@"";
    NSString *sen=@"";
    
//    sen = [NSString stringWithFormat:@"%d", (int)cha%60];
//    //        min = [min substringToIndex:min.length-7];
//    //    秒
//    sen=[NSString stringWithFormat:@"%@", sen];
//    
//    min = [NSString stringWithFormat:@"%d", (int)cha/60%60];
//    //        min = [min substringToIndex:min.length-7];
//    //    分
//    min=[NSString stringWithFormat:@"%@", min];
//    
//    //    小时
    house = [NSString stringWithFormat:@"%d", (int)cha/3600];
    //        house = [house substringToIndex:house.length-7];
    house=[NSString stringWithFormat:@"%@", house];
    
//    timeString=[NSString stringWithFormat:@"%@:%@:%@",house,min,sen];
    
    
    return house;
}





@end
