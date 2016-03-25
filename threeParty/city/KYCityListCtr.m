//
//  CityListViewController.m
//  CityList
//
//  Created by Chen Yaoqiang on 14-3-6.
//
//

#import "KYCityListCtr.h"

@interface KYCityListCtr ()
{
    citySelectBlock cityBlock;
    NSArray *cityArr;
    UITableView *tableViewSearch;
    NSMutableArray *searchCitys;

}


@property (nonatomic, strong) NSMutableDictionary *cities;
@property (nonatomic, strong) NSMutableArray *keys; //城市首字母
@property (nonatomic, strong) NSMutableArray *arrayCitys;   //城市数据
@property (nonatomic, strong) NSMutableArray *arrayHotCity;
@property(nonatomic,strong)UITableView *tableView;



@end

@implementation KYCityListCtr

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.arrayHotCity = [NSMutableArray arrayWithObjects:@"全部",@"广州市",@"北京市",@"天津市",@"西安市",@"重庆市",@"沈阳市",@"青岛市",@"济南市",@"深圳市",@"长沙市",@"无锡市", nil];
        self.keys = [NSMutableArray array];
        self.arrayCitys = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self getCityData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChange:) name:UITextFieldTextDidChangeNotification object:nil];
    
    UITextField *search = [[UITextField alloc]initWithFrame:CGRectMake(50, 6, SCREEN_W-100, 32)];
    search.delegate = self;
    search.backgroundColor = [UIColor whiteColor];
    [search setBorderStyle:UITextBorderStyleRoundedRect];
    [self.topNavBarView addSubview:search];
    
    //取消按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(SCREEN_W - 50, 5, 50, 34);
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    [btn setTintColor:[UIColor whiteColor]];
    [btn addTarget:self action:@selector(clickCancle) forControlEvents:UIControlEventTouchUpInside];
    //[btn.layer setCornerRadius:10.0];
    [self.topNavBarView addSubview:btn];
    
	// Do any additional setup after loading the view.
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H-K_VC_Y) style:UITableViewStylePlain];
    _tableView.autoresizingMask = (UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight);
    _tableView.backgroundColor = [UIColor grayColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.sectionIndexBackgroundColor = [UIColor grayColor];
    _tableView.sectionIndexColor = [UIColor whiteColor];
    
    [self.sView addSubview:_tableView];
    
    tableViewSearch = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H-K_VC_Y) style:UITableViewStylePlain];
    tableViewSearch.backgroundColor = [UIColor grayColor];
    tableViewSearch.delegate = self;
    tableViewSearch.dataSource = self;
    //隐藏没有数据的cell的分隔线
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableViewSearch setTableFooterView:view];
    
//    [self.sView addSubview:tableViewSearch];
    
    //tableViewSearch.hidden = YES;
}

#pragma mark - 获取城市数据
-(void)getCityData{
    NSString *path=[[NSBundle mainBundle] pathForResource:@"citydict"
                                                   ofType:@"plist"];
    self.cities = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    
    [self.keys addObjectsFromArray:[[self.cities allKeys] sortedArrayUsingSelector:@selector(compare:)]];
    
    //添加热门城市
    NSString *strHot = @"热";
    [self.keys insertObject:strHot atIndex:0];
    [self.cities setObject:_arrayHotCity forKey:strHot];
}

#pragma mark - tableView
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (_tableView.hidden == YES) {
        
        return 0;
    }
    return 20.0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    bgView.backgroundColor = [UIColor grayColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, 0, 250, 20)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:20];
    
    NSString *key = [_keys objectAtIndex:section];
    if ([key rangeOfString:@"热"].location != NSNotFound) {
        titleLabel.text = @"热门城市";
    }
    else
        titleLabel.text = key;
    
    [bgView addSubview:titleLabel];
    
    return bgView;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    
    if (_tableView.hidden == YES) {
        
        return 0;
    }
    return _keys;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_tableView.hidden == YES) {
        
        return 1;
    }
    return [_keys count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (_tableView.hidden == YES) {
        
        return searchCitys.count;
    }
    NSString *key = [_keys objectAtIndex:section];
    NSArray *citySection = [_cities objectForKey:key];
    return [citySection count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_tableView.hidden == YES) {
        static NSString *CellIdentifier = @"Cell";

        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
            cell.backgroundColor = [UIColor clearColor];
            cell.contentView.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            [cell.textLabel setTextColor:[UIColor whiteColor]];
            cell.textLabel.font = [UIFont systemFontOfSize:18];
        }
        cell.textLabel.text = searchCitys[indexPath.row];
        return cell;
    }
    static NSString *CellIdentifier = @"Cell";
    
    NSString *key = [_keys objectAtIndex:indexPath.section];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell.textLabel setTextColor:[UIColor whiteColor]];
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    }
    cell.textLabel.text = [[_cities objectForKey:key] objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_tableView.hidden == YES) {
       
        cityBlock(searchCitys[indexPath.row]);
        [self.navigationController popViewControllerAnimated:YES];
    }else{
    
        NSString *key = [_keys objectAtIndex:indexPath.section];
        cityBlock([[_cities objectForKey:key] objectAtIndex:indexPath.row]);
        [self.navigationController popViewControllerAnimated:YES];
    }
}


#pragma mark - 其它

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    if ([textField.text isEqualToString:@""]) {
        
        _tableView.hidden = NO;
        tableViewSearch.hidden = YES;
    }
    
    return YES;
}

-(void)textFieldChange:(NSNotification *)notication
{
    UITextField *textField = [notication object];
    if (textField.text.length>0) {
        [self.sView addSubview:tableViewSearch];
        _tableView.hidden = YES;
        tableViewSearch.hidden = NO;
        [tableViewSearch reloadData];
        
        NSMutableArray *arrr = [[NSMutableArray alloc]init];
        
        for (int a = 0; a<23; a++) {
            
            NSString *key = [self.keys objectAtIndex:a];
            NSArray *arr = [_cities objectForKey:key];//拿到首字母相同的地名的数组
            for (int i = 0; i<arr.count; i++) {
                
                NSString *str = arr[i];
                if ([str rangeOfString:textField.text].location != NSNotFound) {
                    
                    [arrr addObject:str];
                }
            }
        }
        searchCitys = arrr;
        [tableViewSearch reloadData];
    }else{
        _tableView.hidden = NO;
        tableViewSearch.hidden = YES;
    }

}

-(void)clickCancle{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setBlock:(citySelectBlock)block{
    cityBlock = block;
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];

}

@end
