//
//  ViewOptionItem.h
//  MyMusicPro
//
//  Created by 少杰范 on 15/8/20.
//  Copyright (c) 2015年 少杰范. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewOptionItem : UIControl{
    UILabel *_lblTitle;
    UIImageView *_ivIcon;
}


-(instancetype)initWithFrame:(CGRect)frame andTitle:(NSString*)title andIcon:(UIImage*)image;


@end
