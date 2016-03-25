//
//  DownloadBookViewController.m
//  HomeAdorn
//
//  Created by mac on 15/7/21.
//  Copyright (c) 2015年 IWork. All rights reserved.
//

#import "DownloadBookViewController.h"
#import "BookTableViewCell.h"
#import "Globle.h"
#import "BViewController.h"
@interface DownloadBookViewController ()
{
    UITableView *book;
    int jsonFlag;//解析是否完成标识符
    int bookNumber;//数据库章节数标识符
    int localBookNumber;//本地章节数标识符
    NSMutableArray *bookList;//文章章节名
    NSMutableArray *down;
}

@end

@implementation DownloadBookViewController
-(void)InitNavigation{
    [super InitNavigation];
    [NavLeftBtn setImage:[UIImage imageNamed:@"cgyback"] forState:UIControlStateNormal];
    [NavLeftBtn handleControlEvent:UIControlEventTouchDown withBlock:^(id sender) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [NavLeftBtn  setFrame:CGRectMake(0, 0, 25, 25)];
    
    
}

- (void)viewDidLoad {
    [self loadData];
    [super viewDidLoad];
    down = [NSMutableArray array];
    book = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, viewW, viewH-64)];
    book.delegate = self;
    book.dataSource = self;
    [self setExtraCellLineHidden:book];
    [self.view addSubview:book];


}


-(void)loadData
{
    [down removeAllObjects];
    [[CommonFunctions sharedlnstance] getDownLoad:_smid user_id:[Globle shareInstance].user_id requestBlock:^(NSObject *requestData, BOOL IsError) {
        
        if (!IsError) {
            NSDictionary *dic = (NSDictionary *)requestData;
            down  = (NSArray *) [dic objectForKey:@"record"];
            
            if (down.count>0) {
                [book reloadData];
            }
            else
            {
                UILabel *lb= [[UILabel alloc] initWithFrame:CGRectMake(0, viewH*0.5, viewW, 15)];
                lb.textAlignment = NSTextAlignmentCenter;
                lb.text = @"暂无可下载阅读的书籍哦！";
                lb.font = [UIFont systemFontOfSize:13];
                [self.view addSubview:lb];
            }
        }
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return down.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
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
    NSDictionary *dic = down[indexPath.row];
    [cell.btnDown addTarget:self action:@selector(dowmLoadBook) forControlEvents:UIControlEventTouchUpInside];
    cell.bookname.text = [dic objectForKey:@"down_name"];
    return cell;
    
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

     [tableView deselectRowAtIndexPath:indexPath animated:YES];
     NSDictionary *dict = down[indexPath.row];
     [[CommonFunctions sharedlnstance] getBookContext:dict[@"id"] requestBlock:^(NSObject *requestData, BOOL IsError) {
  
        if (!IsError) {
            
            
            NSDictionary *dic = (NSDictionary *)requestData;
            
                BViewController *vc = [[BViewController alloc] init];
                vc.context = dic[@"down_context"];
                vc.titless = dic[@"down_name"];
                [self.navigationController pushViewController:vc animated:YES];
            
        }
    }];
    [[CommonFunctions sharedlnstance] addbook:dict[@"id"] suerid:[Globle shareInstance].user_id  requestBlock:^(NSObject *requestData, BOOL IsError) {
   
        if (!IsError) {
            
            
        }
    }];

    
    
    
}


-(void)dowmLoadBook
{
    [activityIndicator startAnimating];
    //  NSString *googleURL = @"http://www.weather.com.cn/data/cityinfo/101280101.html";
    //NSString *googleURL = @"uploadFiles/updoc/file001.doc";//在这里修改你的服务器地址
    NSString *googleURL =  [IMAGEURL stringByAppendingString:@"uploadFiles/updoc/file020.doc"];

    NSURL *url = [NSURL URLWithString:googleURL];
    request = [ASIHTTPRequest requestWithURL:url];
    [request addRequestHeader:@"User-Agent" value:@"ASIHTTPRequest"];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    //[request startAsynchronous];
    [request setDelegate:self];
    [request startAsynchronous];
    [activityIndicator startAnimating];
    //[self sendMseeageTest];
    
    // Do any additional setup after loading the view, typically from a nib.
    
}
//json解析
-(void)requestFinished:(ASIHTTPRequest  *)request
{
    //NSLog(@"11");
    [activityIndicator stopAnimating];
    // NSString *responseString =[request responseString];
    NSData *responseData =[request responseData];
    NSString *outString = [[NSString alloc] initWithData:responseData encoding: NSUTF8StringEncoding];
    NSMutableDictionary *jsonoObj = [outString JSONValue];
    NSMutableDictionary *jsonoSubObj = [jsonoObj objectForKey:@"doc"];
    NSString *majiaaa=[[NSString alloc] initWithFormat:@"%@",[jsonoSubObj objectForKey:@"booknumber"] ];
    bookNumber=[majiaaa intValue];
 
    
    bookList=[jsonoSubObj objectForKey:@"title"];
    

    [self jsonAction];
}



//下载书籍
-(void)jsonAction
{
    if (!networkQueue) {
        networkQueue = [[ASINetworkQueue alloc] init];
    }
    failed = NO;
    [networkQueue reset];
    //[networkQueue setDownloadProgressDelegate:_downloadProgress];
    [networkQueue setRequestDidFinishSelector:@selector(DownLoadComplete:)];
    [networkQueue setRequestDidFailSelector:@selector(DownLoadFailed:)];
    //[networkQueue setShowAccurateProgress:[accurateProgress isOn]];
    [networkQueue setDelegate:self];
    
    //在doc文件下创建保存书籍文件夹，文件夹名为书籍名拼音
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSLog(@"documentsDirectory%@",documentsDirectory);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *testDirectory = [documentsDirectory stringByAppendingPathComponent:@"xunqin"];
    
    // 创建目录
    [fileManager createDirectoryAtPath:testDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    
    //下载书籍请求
    int downloadNumber=bookNumber-localBookNumber;
    if (downloadNumber>0) {
        for (int i=localBookNumber; i<=bookNumber; i++) {
            NSString *urlPath=[NSString stringWithFormat:@"%@%d%@",
                               @"http://192.168.0.85/downbook/book/",i,@".txt"];
            NSString *localPath=[NSString stringWithFormat:@"%d%@",
                                 i,@".txt"];
            NSString *userinfo=[NSString stringWithFormat:@"%@%d",
                                @"request",i];
            request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:urlPath]];
            [request setDownloadDestinationPath:[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/xunqin"] stringByAppendingPathComponent:localPath]];
           
            [request setUserInfo:[NSDictionary dictionaryWithObject:userinfo forKey:@"book"]];
            [networkQueue addOperation:request];
        }
    }
    localBookNumber=bookNumber;
    [self saveNSUserDefaults];
    [networkQueue go];
}


- (void)DownLoadComplete:(ASIHTTPRequest *)request
{
    NSLog(@"download complete");
}

- (void)DownLoadFailed:(ASIHTTPRequest *)request
{
    if (!failed) {
        NSLog(@"download failed");
        failed = YES;
    }
}
//用于建立本地的章节识别标识符
#pragma localdata save
-(void)saveNSUserDefaults
{
    
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    [userDefault setInteger:localBookNumber forKey:@"Chapter_Number"];
    [userDefault setObject:bookList forKey:@"Chapter_List"];
    [userDefault synchronize];
}

#pragma localdata load

-(void)readNSUserDefaults
{
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    localBookNumber =[userDefault integerForKey:@"Chapter_Number"];
    bookList =[userDefault objectForKey:@"Chapter_List"];
    
}


@end

