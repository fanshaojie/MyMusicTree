//
//  ViewVideoPlayer.m
//  MyMusicPro
//
//  Created by 少杰范 on 15/8/21.
//  Copyright (c) 2015年 少杰范. All rights reserved.
//

#import "ViewVideoPlayer.h"

@implementation ViewVideoPlayer
#define kIconSize 45
#define kIconSize2 25
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}


-(void)initView{
    _btnStart  = [UIButton buttonWithType:UIButtonTypeSystem];
    [_btnStart setTitle:@"" forState:UIControlStateNormal];
    [_btnStart addTarget:self action:@selector(btnStartClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_btnStart setBackgroundImage:[UIImage imageNamed:@"play"]  forState:UIControlStateNormal];
    _btnStart.frame = CGRectMake((CGRectGetWidth(self.frame)-kIconSize)/2 , CGRectGetHeight(self.frame)-kIconSize-5,kIconSize,kIconSize);
    [self addSubview:_btnStart];
    
    _btnPre = [UIButton buttonWithType:UIButtonTypeSystem];
    [_btnPre setTitle:@"" forState:UIControlStateNormal];
    [_btnPre setBackgroundImage:[UIImage imageNamed:@"pre"] forState:UIControlStateNormal];
    [_btnPre addTarget:self action:@selector(btnPreClicked:) forControlEvents:UIControlEventTouchUpInside];
    _btnPre.frame = CGRectMake(CGRectGetMinX(_btnStart.frame) - kIconSize2 -15, CGRectGetMinY(_btnStart.frame)+(kIconSize -kIconSize2)/2, kIconSize2, kIconSize2);
    [self addSubview:_btnPre];
    
    _btnNext =[UIButton buttonWithType:UIButtonTypeSystem];
    [_btnNext setTitle:@"" forState:UIControlStateNormal];
    [_btnNext setBackgroundImage:[UIImage imageNamed:@"next"] forState:UIControlStateNormal];
    [_btnNext addTarget:self action:@selector(btnNextClicked:) forControlEvents:UIControlEventTouchUpInside];
    _btnNext.frame = CGRectMake(CGRectGetMaxX(_btnStart.frame)+15, CGRectGetMinY(_btnStart.frame)+(kIconSize -kIconSize2)/2, kIconSize2, kIconSize2);
    [self addSubview:_btnNext];
    
    _lblTime = [[UILabel alloc]initWithFrame:CGRectMake(10,15, 40, 18)];
    _lblTime.textAlignment = NSTextAlignmentRight;
    _lblTime.font = [UIFont systemFontOfSize:14];
    _lblTime.text = @"00:00";
    [self addSubview:_lblTime];
    
    _sliProgress = [[UISlider alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_lblTime.frame)+5,15, CGRectGetWidth(self.frame) -110, 20)];
    [_sliProgress addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_sliProgress];
    
    _lblTotalTime =[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_sliProgress.frame)+5, 15, 40, 18)];
    _lblTotalTime.textAlignment = NSTextAlignmentLeft;
    _lblTotalTime.font = [UIFont systemFontOfSize:14];
    _lblTotalTime.text =@"04:35";
    [self addSubview:_lblTotalTime];
    
}

-(void)sliderValueChanged:(id)sender{
    [[PlayManager getIntance]changeProgressTo:_sliProgress.value];
}


-(void)updateViewInfoWithCurrTime:(NSString *)ctime sliderValue:(float)value totalTime:(NSString *)ttime{
    _lblTime.text = ctime;
    _sliProgress.value = value;
    _lblTotalTime.text = ttime;
}


-(void)resetView:(NSString*)ttime{
    _lblTime.text = @"00:00";
    _sliProgress.value = 0.0;
    _lblTotalTime.text = ttime;
}

-(void)changeViewWithState:(PlayerState)state{
    if (state == Running) {
        [_btnStart setBackgroundImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
    }
    else{
        [_btnStart setBackgroundImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    }
}

-(void)btnStartClicked:(id)sender{
    if ([PlayManager getIntance].playState ==  Running) {
        [[PlayManager getIntance]toPause];
        [_btnStart setBackgroundImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    }
    else{
        [[PlayManager getIntance]toStart];
        [_btnStart setBackgroundImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
    }
}

-(void)btnPreClicked:(id)sender{
    [[PlayManager getIntance]toPre];
    [_btnStart setBackgroundImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
}

-(void)btnNextClicked:(id)sender{
    [[PlayManager getIntance]toNext];
    [_btnStart setBackgroundImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
}

@end
