//
//  ViewController_2.m
//  GCDDemo
//
//  Created by WangQiao on 17/3/1.
//  Copyright © 2017年 WangQiao. All rights reserved.
//

/*
 * GCDGroup 用法: 如果想在GCDQueue中所有的任务完成后再做某种操作,在串行队列中,可以把该操作放到最后一个任务执行完后再继续,下面 NSLog 输出的循序不定,
 * 优先级的设定,也不能保证它一定是第一个或者最后一个执行,只是执行的先后概率比普通的队列大些.
 * 因为在并行队列上执行完成后,最后到main队列上执行一个操作, 保证[[GCDQueue mainQueue] notify的方法最后执行.
 */

#import "ViewController_2.h"
#import "GCD.h"

@interface ViewController_2 ()

@end

@implementation ViewController_2

- (void)viewDidLoad {

    [super viewDidLoad];
    
    /*
     AB 队列执行完成 C才开始执行
     */
    GCDGroup *group = [[GCDGroup alloc] init];
    [[GCDQueue globalQueue] execute:^{
        
        NSLog(@"A任务");
        
    } inGroup:group];
    
    [[GCDQueue globalQueue] execute:^{
        
        NSLog(@"B任务");
        
    } inGroup:group];
    
   [[GCDQueue globalQueue] notify:^{
       
       NSLog(@"C任务");
       
   } inGroup:group];
}

@end



