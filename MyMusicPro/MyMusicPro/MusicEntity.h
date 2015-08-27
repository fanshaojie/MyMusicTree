//
//  MusicEntity.h
//  MyMusicPro
//
//  Created by 少杰范 on 15/8/19.
//  Copyright (c) 2015年 少杰范. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicEntity : NSObject

@property (nonatomic,strong) NSString *mp3Url;//音乐地址
@property (nonatomic,strong) NSString *micId;//音乐id
@property (nonatomic,strong) NSString *name;//歌曲名称
@property (nonatomic,strong) NSString *picUrl;//专辑图片
@property (nonatomic,strong) NSString *blurPicUrl;//模糊图片地址
@property (nonatomic,strong) NSString *album;//专辑名称
@property (nonatomic,strong) NSString *singer;//歌手
@property (nonatomic,strong) NSString *duration;//播放时长
@property (nonatomic,strong) NSString *artists_name;//艺术家名称
@property (nonatomic,strong) NSArray *lyricArr; //歌词
@end

