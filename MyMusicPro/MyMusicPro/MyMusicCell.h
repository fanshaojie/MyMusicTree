//
//  MyMusicCell.h
//  MyMusicPro
//
//  Created by 少杰范 on 15/8/19.
//  Copyright (c) 2015年 少杰范. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicEntity.h"

@protocol TableCellProtocol <NSObject>

-(void)OptionBtnClicked:(id)sender;

@end

@interface MyMusicCell : UITableViewCell
{
    CGFloat _cntHeight;
    UILabel *_lblMusicName;
    UILabel *_lblSinger;
    UIImageView *_ivIcon;
    UIButton *_btnOption;
    MusicEntity *_entity;
    
}

@property (nonatomic,retain)  id<TableCellProtocol> delegate;
@property (readonly,assign) CGFloat cntHeight;
@property (nonatomic,retain) MusicEntity *musicEntity;
@end
