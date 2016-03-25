
#import "CommentsCell.h"
#import "ImgScrollView.h"
#import "TapImageView.h"
#import "UIImageView+MJWebCache.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

@implementation CommentsCell
{
   NSMutableArray *_urls;

   NSMutableArray *URLArray;
    
   UIView *CommentsView;//回复内容

    NSMutableArray *arrUrlDic;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        _urls = [NSMutableArray array];
        URLArray = [NSMutableArray array];
        arrUrlDic = [NSMutableArray array];
        _Urls = [NSMutableArray array];
        _Avatar = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 40, 40)];
        _Avatar.layer.masksToBounds = YES;
        _Avatar.layer.cornerRadius = 21;
        [self addSubview:_Avatar];
        
        _NameLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, 120, 20)];
        _NameLabel.font = [UIFont systemFontOfSize:14];
        _NameLabel.textColor = rgb_color(43, 255, 131, 1.0);
        [self addSubview:_NameLabel];
        
        _msiid = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, 120, 20)];
        _msiid.font = [UIFont systemFontOfSize:14];
        _msiid.textColor = rgb_color(43, 255, 131, 0);
        [self addSubview:_msiid];
        
        
        
        _str = [[UILabel alloc] initWithFrame:CGRectMake(50, 20, 120, 20)];
        _str.font = [UIFont systemFontOfSize:12];
        _str.textColor = [UIColor grayColor];
        [_str setHidden:YES];
        [self addSubview:_str];
        
        

        _TimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 20, 120, 20)];
        _TimeLabel.font = [UIFont systemFontOfSize:12];
        _TimeLabel.textColor = [UIColor grayColor];
        [self addSubview:_TimeLabel];
        
        _jubao= [[UIButton alloc] initWithFrame:CGRectMake(winsize.width - 60, 10, 50, 30)];
        [_jubao setTitle:@"举报" forState:UIControlStateNormal];
        _jubao.font = [UIFont systemFontOfSize:13];
        [_jubao setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:_jubao];
        
        _ContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 40 ,winsize.width - 55, 13)];
        [_ContentLabel setNumberOfLines:0];
        _ContentLabel.font = [UIFont systemFontOfSize:13];
        _ContentLabel.lineBreakMode = NSLineBreakByCharWrapping;
        [self addSubview:_ContentLabel];
        
        _ContentView = [[UIView alloc] initWithFrame:CGRectMake(50,55, winsize.width - 55, 0)];
       
        [self addSubview:_ContentView];
        
        _BtnView = [[UIView alloc]initWithFrame:CGRectMake(0, 60, winsize.width, 30)];
        [self addSubview:_BtnView];
        
        
        _Reason = [UIButton buttonWithTitleImage:@"" Title:@"" Frame:CGRectMake(40, 0, 30, 30)];
        [_Reason setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _Reason.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 15);
        _Reason.tag = 0;
        [_BtnView addSubview:_Reason];
        
        
        _line = [[UIView alloc] initWithFrame:CGRectMake(0, 29, winsize.width, 1)];
        _line.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [_BtnView addSubview:_line];
        
        _PointChan = [UIButton buttonWithTitleImage:@"forward" Title:@"" Frame:CGRectMake(self.frame.size.width-100, 0, 45, 30)];
        [_PointChan setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _PointChan.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 15);
        _PointChan.tag = 0;
      
        [_BtnView addSubview:_PointChan];
        
        _Conmments = [UIButton buttonWithTitleImage:@"comment_normal" Title:@"" Frame:CGRectMake(self.frame.size.width-50, 0, 50, 30)];
        [_Conmments setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _Conmments.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 15);
        [_BtnView addSubview:_Conmments];
        

        CommentsView = [[UIView alloc] initWithFrame:CGRectMake(0,_BtnView.frame.origin.y + _BtnView.frame.size.height + 10,winsize.width  - 55, 50)];//评论
        [_BtnView addSubview:CommentsView];

      
    }
    return self;
}


- (CGFloat)heightContentBackgroundView:(NSString *)content
{
    CGFloat height = [self heigtOfLabelForFromString:content fontSizeandLabelWidth:self.frame.size.width- 55 andFontSize:13.0];
    ;
    
    return height;
}

- (CGFloat)heigtOfLabelForFromString:(NSString *)text fontSizeandLabelWidth:(CGFloat)width andFontSize:(CGFloat)fontSize
{
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(width, 20000)];
    return size.height;
}

-(void)layoutSubviews{
    
    
    //依次遍历self.view中的所有子视图
    for(id tmpView in [_ContentView subviews])
    {
        //找到要删除的子视图的对象
        if([tmpView isKindOfClass:[UIImageView class]])
        {
            UIImageView *imgView = (UIImageView *)tmpView;
            [imgView removeFromSuperview]; //删除子视图
        }
    }
    
    
    CGFloat height1 = [self heightContentBackgroundView:_ContentLabel.text];
    _ContentLabel.frame = CGRectMake(50, 40 ,winsize.width - 55, height1);
    [_Urls removeAllObjects];
    for (int i=0; i< _ImageURLArray.count; i++) {
        NSDictionary *d = _ImageURLArray[i];
        NSString *im =d[@"msg_id"];
        if ([im isEqualToString:_msid]) {
            [_Urls addObject:_ImageURLArray[i]];
        }
    }
    
    if(_Urls.count > 0){//发表的图片
        int count = _Urls.count > 9 ? 9 : (int)_Urls.count,heightCount = 0;
        
        if (count>0&&count <= 3) {
            heightCount = 1;
            
        }else if (count > 3 && count <= 6){
            heightCount = 2;
        }else if (count > 6 ){
            heightCount = 3;
        }
       
        float h = heightCount * 60;
        float x = 0,y=5,w = (_ContentView.frame.size.width-30)/3;
        
        [_urls removeAllObjects];
        
        for (int i = 0; i < count; i++) {
            
            UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, w, 50)];
            NSDictionary *dic = _Urls[i];
            image.tag = 100+i;
            NSString *imageurl =dic[@"image_url"];
            imageurl = [IMAGEURL stringByAppendingString:imageurl];
            // 下载图片
            [_urls addObject:imageurl];
            [image setImageURLStr: imageurl placeholder:[UIImage imageNamed:@"defaultcgy"]];
            

            // 事件监听
            image.tag = i;
            image.userInteractionEnabled = YES;
            [image addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
            
            // 内容模式
            image.clipsToBounds = YES;
            image.contentMode = UIViewContentModeScaleAspectFill;
        
            
            UILabel *l = [[UILabel alloc] init];
  
            [_ContentView addSubview:l];
            
            [_ContentView addSubview:image];
            
            x += w+5;
            if (i == 2 || i == 5) {
                y += 55;
                x=0;
            }
        }
        
        [arrUrlDic addObject:_urls];
        _ContentView.frame =CGRectMake(50, 55+height1-13,  winsize.width - 55, h);
        _BtnView.frame = CGRectMake(0, 55+h+height1-12, winsize.width, 30);
    }
    else
    {
        
        _BtnView.frame = CGRectMake(0, 55+height1, winsize.width, 30);
    }
}

-(void)ShowCommentsView:(UITapGestureRecognizer *)gesture{
    NSLog(@"123");
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)tapImage:(UITapGestureRecognizer *)tap
{
    UIView *images =(UIView *)tap.view.superview;
    int count = _urls.count;
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        
      UIImageView *image =  (UIImageView *)images.subviews[i];
        
        // 替换为中等尺寸图片
        NSString *url = [_urls[i] stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString:url]; // 图片路径
       // photo.srcImageView = self.view.subviews[i]; // 来源于哪个UIImageView
        [photos addObject:photo];
    }
    
//     2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = tap.view.tag; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];
}

- (void)setChecked:(BOOL)checked{
    if (checked) {
         [_Reason setBackgroundImage:[UIImage imageNamed:@"collect_pressed"] forState:UIControlStateNormal];
    }
    else
    {
         [_Reason setBackgroundImage:[UIImage imageNamed:@"collect_uppressed"] forState:UIControlStateNormal];
    }
   
   
}


@end
