//
//  NetHelper.m
//  Wallet
//
//  Created by 少杰范 on 15/6/19.
//  Copyright (c) 2015年 少杰范. All rights reserved.
//

#import "NetHelper.h"

@implementation NetHelper

+(NSData *)doPostJsonDataBy:(NSString *)url jsonData:(NSDictionary *)data{
    NSURL *_url = [[NSURL alloc]initWithString:url];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:_url];
    request.HTTPMethod = @"POST";
    request.timeoutInterval = 10;
    NSError *error = nil;
    if (data!=nil) {
        NSData *requestData = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:&error];
        if(requestData != nil)
        {
            [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            request.HTTPBody = requestData;
        }
    }
    
    NSURLResponse *response;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if (error != nil || error != NULL) {
        return nil;
    }
    else
    {
        return responseData;
    }
    
    
}

+(NSData *)doGetBy:(NSString *)url postData:(NSDictionary *)data{
    
    NSMutableString *tmpStr= [[NSMutableString alloc]initWithString:url];
    if (data != nil && data!= NULL && data.count>0) {
        for (int i = 0; i<data.count; i++) {
            if (i==0) {
                [tmpStr appendFormat:@"?%@=%@",data.allKeys[i],data.allValues[i]];
            }
            else
            {
                [tmpStr appendFormat:@"&%@=%@",data.allKeys[i],data.allValues[i]];
            }
            
        }
    }
   NSString *urlStr = [tmpStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *_url = [[NSURL alloc]initWithString:urlStr];
    
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:_url];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (error !=nil || error!= NULL) {
        return nil;
    }
    else
    {
        return responseData;
    }
}
@end
