//
//  ViewController.m
//  GCDDemo
//
//  Created by WangQiao on 17/3/1.
//  Copyright © 2017年 WangQiao. All rights reserved.
//

#import "RootViewController.h"
#import "ViewController_1.h"
#import "ViewController_2.h"
#import "ViewController_3.h"

@interface RootViewController ()

@property(nonatomic, strong) UIButton *button;

@end

@implementation RootViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    NSArray *array = @[@"GCDQueue", @"GCDGroup", @"信号量"];
    
    for (int i = 0 ; i < 3; i ++) {
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(50, 100 + 60 *i, 150, 45)];
        [button setTitle:array[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor greenColor] forState:UIControlStateHighlighted];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(buttonEnent:) forControlEvents:UIControlEventTouchUpInside];
        button.layer.borderWidth = 1.0f;
        button.tag      = 10 + i;
        [self.view addSubview:button];
    }
}

- (void)buttonEnent:(UIButton *)button {
    
    if (button.tag  == 10) {
    
        NSLog(@"GCDQueue");
        ViewController_1 *vc1 = [[ViewController_1 alloc] init];
        [self.navigationController pushViewController:vc1 animated:YES];
    
    } else if (button.tag == 11) {
    
        NSLog(@"GCDGroup");
        ViewController_2 *vc2 = [[ViewController_2 alloc] init];
        [self.navigationController pushViewController:vc2 animated:YES];
        
    } else if (button.tag == 12) {
    
        NSLog(@"signal");
        ViewController_3 *vc3 = [[ViewController_3 alloc] init];
        [self.navigationController pushViewController:vc3 animated:YES];
    }
}

@end
