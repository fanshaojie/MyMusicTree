//
//  MyMusicCell.m
//  MyMusicPro
//
//  Created by 少杰范 on 15/8/19.
//  Copyright (c) 2015年 少杰范. All rights reserved.
//

#import "MyMusicCell.h"
#import "UIImageView+WebCache.h"
@implementation MyMusicCell

@synthesize cntHeight = _cntHeight;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        _ivIcon = [[UIImageView alloc]initWithFrame:CGRectMake(8, 3, CGRectGetHeight(self.contentView.frame)-6,  CGRectGetHeight(self.contentView.frame)-6)];
        [self.contentView addSubview:_ivIcon];
        
        _lblMusicName = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_ivIcon.frame)+3, CGRectGetMinY(_ivIcon.frame), CGRectGetWidth(self.contentView.frame)/2, CGRectGetHeight(_ivIcon.frame)/2)];
        _lblMusicName.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_lblMusicName];
        
        _lblSinger = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_ivIcon.frame)+3, CGRectGetMidY(_ivIcon.frame), CGRectGetWidth(self.contentView.frame)/2, CGRectGetHeight(_ivIcon.frame)/2)];
        _lblSinger.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_lblSinger];
        
        _btnOption = [UIButton buttonWithType:UIButtonTypeSystem];
        [_btnOption addTarget:self action:@selector(btnOptionClicked:) forControlEvents:UIControlEventTouchUpInside  ];
        _btnOption.frame = CGRectMake(CGRectGetMaxX(self.contentView.frame)-30, CGRectGetHeight(self.contentView.frame)/2-15, 30, 30);
        [self.contentView addSubview:_btnOption];
    }
    return self;
    
}
-(void)btnOptionClicked:(id)sender{
    if (self.delegate != nil) {
        [self.delegate OptionBtnClicked:self];
    }
}

-(void)setMusicEntity:(MusicEntity *)musicEntity{
    _entity = musicEntity;
    _lblMusicName.text = _entity.name;
    _lblSinger.text = _entity.singer;
    [_ivIcon sd_setImageWithURL:[NSURL URLWithString:_entity.picUrl ] placeholderImage:[UIImage imageNamed:@"user_b"]];
}

@end
