//
//  PlayManager.h
//  MyMusicPro
//
//  Created by 少杰范 on 15/8/24.
//  Copyright (c) 2015年 少杰范. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MusicEntity.h"
#import "EnumManager.h"
#import <AVFoundation/AVFoundation.h>
@protocol PlayerStateProtocol <NSObject>

@optional
-(void)playerStateChangedTo:(PlayerState)state;
-(void)changeSongTo:(MusicEntity*)entity;
@end

@interface PlayManager : NSObject{
}

+(PlayManager *)getIntance;

-(void)toStart;

-(void)toPause;

-(void)toNext;

-(void)toPre;

-(void)changeVolumeTo:(NSInteger)value;

-(void)changeProgressTo:(float)value;

-(NSString*)formatTimeBySecond:(NSInteger)second;

-(MusicEntity*)getMusicByIndex:(NSInteger)index;

@property (nonatomic,weak) id<PlayerStateProtocol> delegate;
@property (nonatomic,assign) NSInteger currentMusicIndex;
@property (nonatomic,retain) NSDictionary *musicDic;
@property (nonatomic,readonly)  PlayerState  playState;
@property (nonatomic,assign)  PlayMode playMode;
@property (nonatomic,readonly) AVPlayer *avPlayer;

@end
