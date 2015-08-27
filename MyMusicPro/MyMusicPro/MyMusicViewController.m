//
//  MyMusicViewController.m
//  MyMusicPro
//
//  Created by 少杰范 on 15/8/19.
//  Copyright (c) 2015年 少杰范. All rights reserved.
//

#import "MyMusicViewController.h"
#import "MyMusicCell.h"
#import "NetMusicManger.h"
#import "PlayManager.h"
#import "RunningViewController.h"
#define SHOW_PAGE_COUNT 18
@interface MyMusicViewController (){
    NSInteger _showNum;
    SDRefreshHeaderView *refreshHeader;
    SDRefreshFooterView *loadMoreFooter;
}
@end

@implementation MyMusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self initData];
}

-(void)initView{
    self.title = @"曲库";
    refreshHeader = [SDRefreshHeaderView refreshView];
    [refreshHeader addTarget:self refreshAction:@selector(resetData)];
    [refreshHeader addToScrollView:self.tableView];
    
    loadMoreFooter = [SDRefreshFooterView refreshView];
    [loadMoreFooter addTarget:self refreshAction:@selector(loadMoreContent)];
    [loadMoreFooter addToScrollView:self.tableView];
}

-(void)initData{
    _showNum = SHOW_PAGE_COUNT;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NetMusicManger *netManager = [[NetMusicManger alloc]init];
        [PlayManager getIntance].musicDic = [netManager getNetMusic];
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([PlayManager getIntance].musicDic == nil) {
                return;
            }
            if (_showNum >[PlayManager getIntance].musicDic.count) {
                _showNum = [PlayManager getIntance].musicDic.count;
            }
            [self.tableView reloadData];
        });
    });
}



-(void)resetData{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NetMusicManger *netManager = [[NetMusicManger alloc]init];
        [PlayManager getIntance].musicDic = [netManager getNetMusic];
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([PlayManager getIntance].musicDic == nil) {
                return;
            }
            if (_showNum >[PlayManager getIntance].musicDic.count) {
                _showNum = [PlayManager getIntance].musicDic.count;
            }
            
            [self.tableView reloadData];
            [refreshHeader endRefreshing];
        });
    });
}


-(void)loadMoreContent
{
    //加载更多
    if ([PlayManager getIntance].musicDic == nil) {
        return;
    }
    _showNum += SHOW_PAGE_COUNT;
    if (_showNum >[PlayManager getIntance].musicDic.count) {
        _showNum = [PlayManager getIntance].musicDic.count;
    }
    
    [self.tableView reloadData];
    [loadMoreFooter endRefreshing];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"myMusicCell";
    MyMusicCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil ) {
        cell = [[MyMusicCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.musicEntity = [[PlayManager getIntance].musicDic objectForKey:[PlayManager getIntance].musicDic.allKeys[indexPath.row]];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //xuanzhong
    [PlayManager getIntance].currentMusicIndex = indexPath.row;
    RunningViewController *rvc = [[RunningViewController alloc]init];
    [self.navigationController pushViewController:rvc animated:true];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//
//}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //返回每个section行数
    return _showNum;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
