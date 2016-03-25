//
//  YGBookshelfCtr.m
//  HomeAdorn
//
//  Created by wangxiaoer on 7/20/15.
//  Copyright (c) 2015 IWork. All rights reserved.
//

#import "YGBookshelfCtr.h"
#define Identifier @"MyBookShelfCell"
#import "DownloadBookViewController.h"
#import "BookTableViewCell.h"
#import "Globle.h"
#import "BViewController.h"
@interface YGBookshelfCtr ()<UITableViewDelegate,UITableViewDataSource>

{
    UITableView *book;
    int jsonFlag;//解析是否完成标识符
    int bookNumber;//数据库章节数标识符
    int localBookNumber;//本地章节数标识符
    NSMutableArray *bookList;//文章章节名
    NSMutableArray *down;

}
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSArray *dataArr;

@end

@implementation YGBookshelfCtr

-(void)InitNavigation{
    [super InitNavigation];
    [NavLeftBtn setImage:[UIImage imageNamed:@"cgyback"] forState:UIControlStateNormal];
    [NavLeftBtn handleControlEvent:UIControlEventTouchDown withBlock:^(id sender) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [NavLeftBtn  setFrame:CGRectMake(0, 0, 25, 25)];
    
    
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self loadData];
    down = [NSMutableArray array];
    book = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, viewW, viewH-64)];
    book.delegate = self;
    book.dataSource = self;
   [self setExtraCellLineHidden:book];
    [self.view addSubview:book];
    
    
}

//-(void)viewDidAppear:(BOOL)animated
//{
//    [self loadData];
//}
-(void)loadData
{
    [down removeAllObjects];
    [[CommonFunctions sharedlnstance] getmydownBook:[Globle shareInstance].user_id  requestBlock:^(NSObject *requestData, BOOL IsError) {

        
        if (!IsError) {
            NSDictionary *dic = (NSDictionary *)requestData;
            down  = (NSArray *) [dic objectForKey:@"record"];
            
            if (down.count>0) {
                [book reloadData];
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
//    
    

    
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
    
    NSString *urlPath=[NSString stringWithFormat:@"http://112.74.84.69:8080/imgfile/uploadFiles/updoc/file015.doc"];
    NSString *localPath=[NSString stringWithFormat:@"file015.doc"];
    NSString *userinfo=[NSString stringWithFormat:@"%@%d",
                        @"request",[Globle shareInstance].user_id];
    request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:urlPath]];
    [request setDownloadDestinationPath:[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/xunqin"] stringByAppendingPathComponent:localPath]];
    
    [request setUserInfo:[NSDictionary dictionaryWithObject:userinfo forKey:@"book"]];
    [networkQueue addOperation:request];
    
    localBookNumber=bookNumber;
    //    [self saveNSUserDefaults];
    [networkQueue go];
}
//用于建立本地的章节识别标识符
#pragma localdata save
//用于建立本地的章节识别标识符
#pragma localdata save
//-(void)saveNSUserDefaults
//{
//
//    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
//    [userDefaults setInteger:localBookNumber forKey:@"Chapter_Number"];
//    [userDefaults setObject:bookList forKey:@"Chapter_List"];
//    [userDefaults synchronize];
//}
//
//#pragma localdata load
//
//-(void)readNSUserDefaults
//{
//    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
//    localBookNumber =[userDefaults integerForKey:@"Chapter_Number"];
//    bookList =[userDefaults objectForKey:@"Chapter_List"];
//
//}



@end



/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

