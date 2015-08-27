//
//  ViewOptionItem.m
//  MyMusicPro
//
//  Created by 少杰范 on 15/8/20.
//  Copyright (c) 2015年 少杰范. All rights reserved.
//

#import "ViewOptionItem.h"

@implementation ViewOptionItem

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame andTitle:(NSString *)title andIcon:(UIImage *)image{
    if (self = [super initWithFrame:frame]) {
        _lblTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(frame)*2/3, CGRectGetWidth(frame), CGRectGetHeight(frame))];
        _lblTitle.textAlignment = NSTextAlignmentCenter;
        _lblTitle.text = title;
        
        _ivIcon = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
        _ivIcon.image = image;
        _ivIcon.contentMode = UIViewContentModeScaleAspectFit;
    }
    return self;
}

@end
