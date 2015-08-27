//
//  NetHelper.h
//  Wallet
//
//  Created by 少杰范 on 15/6/19.
//  Copyright (c) 2015年 少杰范. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetHelper : NSObject

+(NSData*)doPostJsonDataBy:(NSString*)url jsonData:(NSDictionary*)data;
+(NSData*)doGetBy:(NSString*)url postData:(NSDictionary*)data;

@end
