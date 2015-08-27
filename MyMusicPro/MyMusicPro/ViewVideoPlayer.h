//
//  ViewVideoPlayer.h
//  MyMusicPro
//
//  Created by 少杰范 on 15/8/21.
//  Copyright (c) 2015年 少杰范. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicEntity.h"
#import "EnumManager.h"
#import "PlayManager.h"


@interface ViewVideoPlayer :UIView
{
    UIButton *_btnStart;
    UIButton *_btnPre;
    UIButton *_btnNext;
    UISlider *_sliProgress;
    UILabel *_lblTime;
    UILabel *_lblTotalTime;
 
}

-(void)updateViewInfoWithCurrTime:(NSString*)ctime sliderValue:(float)value totalTime:(NSString*)ttime;


-(void)resetView;

-(void)changeViewWithState:(PlayerState)state;
@end
