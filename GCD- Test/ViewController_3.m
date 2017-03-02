//
//  ViewController_3.m
//  GCDDemo
//
//  Created by WangQiao on 17/3/1.
//  Copyright © 2017年 WangQiao. All rights reserved.
//

#import "ViewController_3.h"
#import "GCD.h"

@interface ViewController_3 ()

@end

@implementation ViewController_3

- (void)viewDidLoad {
    
    [super viewDidLoad];

        // 信号量
        /*
         信号(signal) 和 等待(wait) 是成对出现的
    
         */
    
        GCDSemaphore *semaphore = [GCDSemaphore new];
    
        [GCDQueue excuteInGlobalQueue:^{
    
            NSLog(@"我1先来的,我要先执行了,因为后面的人要等待");
            [semaphore wait];
    
            //  要想向我一样等待,就在这里带着,do what you want to  do
            NSLog(@"我是最后一个,我等了好一会,现在才轮到我,还好大概跟2差不多执行完");
        }];
    
        [GCDQueue executeInGlobalQueue:^{
    
            // 在发信号之前,先执行你想做的
            NSLog(@"我2就是等在他后面的人,等了很久,大概8秒吧,等我执行了完任务,就给你发个信号,你马上就能执行了");
            
            [semaphore signal];
    
        } afterDelaySecs:8.f];
}

@end
