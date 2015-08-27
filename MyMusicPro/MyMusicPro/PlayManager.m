//
//  PlayManager.m
//  MyMusicPro
//
//  Created by 少杰范 on 15/8/24.
//  Copyright (c) 2015年 少杰范. All rights reserved.
//

#import "PlayManager.h"
static PlayManager *pm;
@implementation PlayManager
+(PlayManager *)getIntance{
    
    static dispatch_once_t onceT;
    dispatch_once(&onceT, ^{
        pm = [[PlayManager alloc ]init];
    });
    return pm;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.currentMusicIndex = -1;
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(currentMusicPlayCompleted:) name:@"AVPlayerItemDidPlayToEndTimeNotification" object:nil];
    }
    return self;
}


-(void)currentMusicPlayCompleted:(id)sender{
    [self toNext];
}

-(void)toStart{
    if (self.currentMusicIndex == -1) {
        return;
    }
    [[self musicPlayer]play];
    self.playState = Running;
}

-(void)toPause{
    if (self.currentMusicIndex == -1) {
        return;
    }
    [[self musicPlayer] pause];
    self.playState = Stop;
}

-(void)toNext{
    if (self.currentMusicIndex == -1) {
        return;
    }
    if (self.currentMusicIndex == self.musicDic.count -1) {
        return ;
    }
    else{
        self.currentMusicIndex +=1;
    }
}

-(AVPlayerItem*)getAVPlayerItem{
    MusicEntity *mec = [self getMusicByIndex:self.currentMusicIndex];
    AVPlayerItem *avItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString: mec.mp3Url] ];
    return avItem;
}

-(void)toPre{
    if (self.currentMusicIndex == -1) {
        return;
    }
    if (self.currentMusicIndex == 0) {
        return;
    }
    else
    {
        self.currentMusicIndex -= 1;
    }
}

-(void)setPlayState:(PlayerState)playState{
    if (_playState == playState) {
        return;
    }
    _playState = playState;
    if (self.delegate && [self.delegate respondsToSelector:@selector(playerStateChangedTo:)]) {
        [self.delegate playerStateChangedTo:_playState];
    }
}

-(void)initData{
}

-(NSString *)formatTimeBySecond:(NSInteger)second{
    if (second<0) {
        return @"00:00";
    }
    
    return  [NSString stringWithFormat:@"%02ld:%02ld",second/60 ,second%60];
}

-(void)resetSongTotalTime{
    
    [[self musicPlayer] replaceCurrentItemWithPlayerItem:[self getAVPlayerItem]];
    [[self musicPlayer] play];
    self.playState = Running;
    if(self.delegate && [self.delegate respondsToSelector:@selector(changeSongTo:)])
    {
        [self.delegate changeSongTo:[self getMusicByIndex:self.currentMusicIndex]];
    }
}

-(void)changeProgressTo:(float)value{
     MusicEntity *mec = [self getMusicByIndex:self.currentMusicIndex];
    [self.avPlayer seekToTime:CMTimeMake(value*mec.duration.floatValue/1000, 1)];
}

-(void)setCurrentMusicIndex:(NSInteger)currentMusicIndex{
    if (_currentMusicIndex == currentMusicIndex) {
        return;
    }
    _currentMusicIndex = currentMusicIndex;
    [self resetSongTotalTime];
}


-(AVPlayer*)musicPlayer{
    if (_avPlayer == nil) {
        _avPlayer = [[AVPlayer alloc]init];
        _avPlayer.volume = 0.5;
    }
    return _avPlayer;
}


-(void)changeVolumeTo:(float)value{
    [self musicPlayer].volume = value;
}


-(MusicEntity *)getMusicByIndex:(NSInteger)index{
    if (index <0) {
        return nil;
    }
    NSString *mkey = [self.musicDic.allKeys objectAtIndex:index];
    return [self.musicDic objectForKey:mkey];
}


@end
