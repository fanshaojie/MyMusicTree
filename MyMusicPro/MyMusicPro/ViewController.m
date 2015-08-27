//
//  ViewController.m
//  MyMusicPro
//
//  Created by 少杰范 on 15/8/19.
//  Copyright (c) 2015年 少杰范. All rights reserved.
//

#import "ViewController.h"
#import "MyMusicViewController.h"
#import "NetMusicViewController.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    MyMusicViewController *myMusicCtrl = [[MyMusicViewController alloc]init];
    myMusicCtrl.tabBarItem.title = @"曲库";
    myMusicCtrl.tabBarItem.image =[UIImage imageNamed:@"icloud_b"];
    
    NetMusicViewController *netMusicCtrl = [[NetMusicViewController alloc]init];
    netMusicCtrl.tabBarItem.title =@"我的";
    netMusicCtrl.tabBarItem.image = [UIImage imageNamed:@"user_b"];

    [self addChildViewController:[[UINavigationController alloc]initWithRootViewController:myMusicCtrl]];
    [self addChildViewController:[[UINavigationController alloc]initWithRootViewController:netMusicCtrl]];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
