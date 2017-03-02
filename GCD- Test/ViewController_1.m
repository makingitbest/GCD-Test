//
//  ViewController_1.m
//  GCDDemo
//
//  Created by WangQiao on 17/3/1.
//  Copyright © 2017年 WangQiao. All rights reserved.
//

#import "ViewController_1.h"
#import "GCD.h"

@interface ViewController_1 ()

@property (nonatomic, strong) UIImageView *imageView1;
@property (nonatomic, strong) UIImageView *imageView2;
@property (nonatomic, strong) GCDTimer    *timer;


@end

@implementation ViewController_1

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"GCDQueue";
 
    [GCDQueue excuteInGlobalQueue:^{ // 这里处理图片下载任务
        
        NSLog(@"下载图片");
        UIImage *image = [self imageWithStringUrl:@"http://img5.duitang.com/uploads/item/201406/19/20140619120221_WmYiV.jpeg"];
        
        [GCDQueue excuteInMainQueue:^{ // 处理UI刷新
            
            NSLog(@"刷新UI");
            self.imageView1                   = [[UIImageView alloc] initWithFrame:CGRectMake(50, 100, 150, 150)];
            self.imageView1.layer.borderWidth = 1;
            self.imageView1.layer.borderColor   = [UIColor greenColor].CGColor;
            self.imageView1.contentMode       = UIViewContentModeScaleAspectFill;
            self.imageView1.image             = image;
            self.imageView1.layer.masksToBounds = YES;
            [self.view addSubview:self.imageView1];
            
            NSLog(@"刷新UI后,但imageView2的图片下载,我延迟了");
            self.imageView2                     = [[UIImageView alloc] initWithFrame:CGRectMake(50, 280, 180, 180)];
            self.imageView2.contentMode         = UIViewContentModeScaleAspectFill;
            self.imageView2.layer.borderWidth   = 2;
            self.imageView2.layer.masksToBounds = YES;
            self.imageView2.layer.borderColor   = [UIColor yellowColor].CGColor;
            [self.view addSubview:self.imageView2];
        }];
    }];
    
    // 添加定时器
    self.timer = [[GCDTimer alloc] initInQueue:[GCDQueue mainQueue]];
    [self.timer event:^{
        
        NSLog(@"延迟加载,处理的事情");
        self.imageView2.image = [self imageWithStringUrl:@"http://img5.duitang.com/uploads/item/201406/19/20140619120221_WmYiV.jpeg"];
    
    } timeInterval:NSEC_PER_SEC * 20 delay:NSEC_PER_SEC * 20];  // 延迟20秒加载图片.每隔20秒刷新一下
    
    [self.timer start];
}

- (UIImage *)imageWithStringUrl:(NSString *)string {
    
    NSURL   *url    = [NSURL URLWithString:string];
    NSData  *data   = [NSData dataWithContentsOfURL:url];
    UIImage *image  = [UIImage imageWithData:data];
    return image;
}

@end
