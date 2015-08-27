//
//  RunningViewController.m
//  MyMusicPro
//
//  Created by 少杰范 on 15/8/20.
//  Copyright (c) 2015年 少杰范. All rights reserved.
//

#import "RunningViewController.h"
#import "UIImageView+WebCache.h"
@interface RunningViewController (){
    ViewVideoPlayer *vvPlayer;
    NSDictionary *lyricDic;
    UITableView *_tableLyric;
    NSTimer *_timer;
    
}
@end

@implementation RunningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initView{
    [PlayManager getIntance].delegate = self;
    _tableLyric = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame),CGRectGetHeight(self.view.frame)-64-60 )];
    _tableLyric.delegate =self;
    _tableLyric.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableLyric.dataSource = self;
    [self.view addSubview:_tableLyric];
    
    vvPlayer = [[ViewVideoPlayer alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_tableLyric.frame),CGRectGetWidth(self.view.frame), 80)];
    vvPlayer.backgroundColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.5];
    [self.view addSubview:vvPlayer];
    [self initSongInfoWithTable:false];

    [vvPlayer changeViewWithState:[PlayManager getIntance].playState];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(timerTick:) userInfo:nil repeats:YES];
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [PlayManager getIntance].delegate = nil;
}

-(void)timerTick:(id)sender{
    //改变进度和已播放时长
    CMTime ctime = [PlayManager getIntance].avPlayer.currentTime;
    float ds = CMTimeGetSeconds(ctime);
    NSString *ctimeStr = [[PlayManager getIntance]formatTimeBySecond:ds];
    MusicEntity *cme = [[PlayManager getIntance]getMusicByIndex:[PlayManager getIntance].currentMusicIndex];
    
    NSString *ttimeStr= [[PlayManager getIntance]formatTimeBySecond:cme.duration.integerValue/1000];
    [vvPlayer updateViewInfoWithCurrTime:ctimeStr sliderValue:ds*1000/cme.duration.floatValue totalTime:ttimeStr];
    
    //更新正在播放的歌词
    for (int i = 0; i<cme.lyricArr.count; i++) {
        NSDictionary *itemDic = [cme.lyricArr objectAtIndex:i];
        NSString *timeKey = [itemDic allKeys].firstObject;
        if ( [timeKey  rangeOfString:ctimeStr].location != NSNotFound) {

            [_tableLyric selectRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0] animated:true scrollPosition:UITableViewScrollPositionMiddle];
            break;
        }
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellName = @"songCell";
    UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
        cell.backgroundColor = [UIColor clearColor];
    }
    MusicEntity *me = [[PlayManager getIntance]getMusicByIndex:[PlayManager getIntance].currentMusicIndex];
    cell.textLabel.text = [[me.lyricArr objectAtIndex:indexPath.row] allValues].firstObject;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.highlightedTextColor = [UIColor greenColor];
    cell.textLabel.numberOfLines = 0;
    return cell;
}

-(void)changeSongTo:(MusicEntity *)entity{
    [self initSongInfoWithTable:YES];
}

-(void)playerStateChangedTo:(PlayerState)state{
    [vvPlayer changeViewWithState:state];
}

-(void)initSongInfoWithTable:(BOOL)relo{
    MusicEntity *me = [[PlayManager getIntance]getMusicByIndex:[PlayManager getIntance].currentMusicIndex];
    self.title  = me.name;
    if (_tableLyric) {
        UIImageView *ivBg= [[UIImageView alloc]init];
        ivBg.frame = _tableLyric.frame;
        ivBg.contentMode = UIViewContentModeScaleToFill;
        [ivBg sd_setImageWithURL:[NSURL URLWithString:me.picUrl]];
        _tableLyric.backgroundView =ivBg;
    }
    if (relo && _tableLyric) {
        [_tableLyric reloadData];
    }
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    MusicEntity *me = [[PlayManager getIntance]getMusicByIndex:[PlayManager getIntance].currentMusicIndex];
    return me.lyricArr.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}



@end
