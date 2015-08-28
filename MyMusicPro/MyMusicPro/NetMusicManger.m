//
//  NetMusicManger.m
//  MyMusicPro
//
//  Created by 少杰范 on 15/8/19.
//  Copyright (c) 2015年 少杰范. All rights reserved.
//

#import "NetMusicManger.h"
#import "MusicEntity.h"
@implementation NetMusicManger


-(NSDictionary*)getNetMusic{
    
    NSData *backData = nil;
    //对数据进行本地化处理
    //**************************************
    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    NSString *fileName = [path stringByAppendingPathComponent:@"netMusic.plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isFileExist = [fileManager fileExistsAtPath:fileName];
    if (isFileExist) {
        backData =  [NSData dataWithContentsOfFile:fileName];
    }
    else{
        NSString *mUrl = @"http://project.lanou3g.com/teacher/UIAPI/MusicInfoList.plist";
        backData = [NetHelper doGetBy:mUrl postData:nil];
        if (backData == nil) {
            return nil;
        }
       BOOL isSuccess = [backData writeToFile:fileName atomically:YES];
    }
    //**************************************
    NSError *error = nil;
    NSMutableDictionary *resultDic = [[NSMutableDictionary alloc]init];
    NSArray *array = [NSPropertyListSerialization propertyListWithData:backData options:0 format:NULL error:&error];
    for (NSDictionary *tmpDic in array) {
        MusicEntity *me = [[MusicEntity alloc]init];
        me.mp3Url = [tmpDic objectForKey:@"mp3Url"];
        me.micId = [tmpDic objectForKey:@"id"];
        me.album = [tmpDic objectForKey:@"album"];
        me.picUrl  = [tmpDic objectForKey:@"picUrl"];
        me.blurPicUrl = [tmpDic objectForKey:@"blurPicUrl"];
        me.artists_name = [tmpDic objectForKey:@"artists_name"];
        me.name = [tmpDic objectForKey:@"name"];
        NSString *tmpStr = [tmpDic objectForKey:@"lyric"];
        me.lyricArr = [self analysisLyric:tmpStr];
        me.singer = [tmpDic objectForKey:@"singer"];
        me.duration = [tmpDic objectForKey:@"duration"];
        [resultDic  setObject:me forKey:me.micId];
    }
    return resultDic;
}

-(NSArray*)analysisLyric:(NSString*)lyric{
    NSMutableArray  *resultArr = [[NSMutableArray alloc]init];
    NSArray *rowArr = [lyric componentsSeparatedByString:@"\n"];
    for (NSString *tmpStr in rowArr) {
        if (tmpStr == nil ||[tmpStr isEqualToString:@"" ] || [[tmpStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""] ) {
            continue;
        }
        NSArray *tmpArr = [tmpStr componentsSeparatedByString:@"]"];
        if (tmpArr.count <2) {
            continue;
        }
        else
        {
            NSString *timeKey = [[tmpArr objectAtIndex:0] stringByReplacingOccurrencesOfString:@"[" withString:@""];
            NSString *lvalue = [tmpArr objectAtIndex:1];
            if ([lvalue isEqualToString:@""] || [[lvalue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet ]] isEqualToString:@""]) {
                continue;
            }
            NSDictionary *keyValueDic = @{timeKey:lvalue};
            [resultArr addObject:keyValueDic];
        }
    }
    return resultArr;
}

-(void)testGit{
    
}
@end
