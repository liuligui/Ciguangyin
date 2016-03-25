//
//  cityPickerViewController.m
//  HomeAdorn
//
//  Created by mac on 15/8/2.
//  Copyright (c) 2015年 IWork. All rights reserved.
//

#import "cityPickerViewController.h"
#import "HZAreaPickerView.h"
@interface cityPickerViewController  () <UITextFieldDelegate, HZAreaPickerDelegate>
@property (strong, nonatomic) NSString *areaValue, *cityValue;
@property (strong, nonatomic) HZAreaPickerView *locatePicker;
@end


@implementation cityPickerViewController


-(void)InitNavigation{
   
    [super InitNavigation];
    [NavLeftBtn setImage:[UIImage imageNamed:@"cgyback"] forState:UIControlStateNormal];
    [NavLeftBtn handleControlEvent:UIControlEventTouchDown withBlock:^(id sender) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [NavRightBtn  setFrame:CGRectMake(0, 0, 40, 25)];
    [NavLeftBtn  setFrame:CGRectMake(0, 0, 25, 25)];
    NavRightBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [NavRightBtn setTitle:@"确定" forState:UIControlStateNormal];
    [NavRightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [NavRightBtn handleControlEvent:UIControlEventTouchDown withBlock:^(id sender) {
      NSString  *strStreet =  _areaText.text;
      NSString *provincre  = _lbprovince.text;
      NSString *address = [provincre stringByAppendingString:strStreet];
        [self.delegate setcity:address];
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _areaText.delegate = self;
    if ([_type isEqualToString:@"b"]) {
        _lbtype.text = @"点击选中病例组别";
             _areaText.placeholder = @"病例组没有找到，在这里填写。";
       }
    else
    {
        _lbtype.text = @"省、市、区（点击选择）";
           _areaText.placeholder = @"详细地址";
    }
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)hidekeyb:(id)sender {
    [_areaText resignFirstResponder];
      [self cancelLocatePicker];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnP:(id)sender {
    if ([_type isEqualToString:@"b"]) {
        [self cancelLocatePicker];
        self.locatePicker = [[HZAreaPickerView alloc] initWithStyle:HZAreaPickerWithStateAndCity delegate:self];
        [self.locatePicker showInView:self.view];  //HZAreaPickerWithStateAndCityAndDistrict

    }
    else
    {
        [self cancelLocatePicker];
        self.locatePicker = [[HZAreaPickerView alloc] initWithStyle:HZAreaPickerWithStateAndCityAndDistrict delegate:self];
        [self.locatePicker showInView:self.view];  //

    }
    
    
}

#pragma mark - HZAreaPicker delegate
-(void)pickerDidChaneStatus:(HZAreaPickerView *)picker
{
    if ([_type isEqualToString:@"b"]) {
        _lbprovince.text = [NSString stringWithFormat:@"%@ %@ ", picker.locate.state, picker.locate.city];
      
    }
    else
    {
        _lbprovince.text = [NSString stringWithFormat:@"%@ %@ %@", picker.locate.state, picker.locate.city, picker.locate.district];
      

        
    }
    
          }

-(void)cancelLocatePicker
{
    [self.locatePicker cancelPicker];
    self.locatePicker.delegate = nil;
    self.locatePicker = nil;
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [_areaText resignFirstResponder]
    ;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
