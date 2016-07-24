//
//  B2BHttpUtil.m
//  B2B Motion
//
//  Created by Andrey Morozov on 20.07.2016.
//  Copyright © 2016 Andrey Morozov. All rights reserved.
//

#import "B2BHttpUtil.h"

static NSString * const charactersToBeEscapedInQueryString = @":/?&=;+!@#$()',*";

static NSString * escapedQueryStringKeyFromStringWithEncoding(NSString *string, NSStringEncoding encoding) {
    static NSString * const charactersToLeaveUnescapedInQueryStringPairKey = @"[].";
    
    return (__bridge_transfer  NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)string, (__bridge CFStringRef)charactersToLeaveUnescapedInQueryStringPairKey, (__bridge CFStringRef)charactersToBeEscapedInQueryString, CFStringConvertNSStringEncodingToEncoding(encoding));
}

static NSString * AFPercentEscapedQueryStringValueFromStringWithEncoding(NSString *string, NSStringEncoding encoding) {
    return (__bridge_transfer  NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)string, NULL, (__bridge CFStringRef)charactersToBeEscapedInQueryString, CFStringConvertNSStringEncodingToEncoding(encoding));
}


@implementation B2BHttpUtil

+(B2BHttpUtil *)sharedInstance {
    static B2BHttpUtil *sharedUser = nil;
    static dispatch_once_t once;
    dispatch_once(&once,^{
        sharedUser = [[B2BHttpUtil alloc] init];
    });
    return sharedUser;
}


-(NSMutableURLRequest *)requestWithMethod:(NSString *)method
                                URLString:(NSString *)URLString
                               parameters:(NSDictionary *)parameters
{
    NSString *urlString = [self generateURL:URLString params:parameters httpMedthod:method];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:method];
    
    /*if ([method isEqualToString:@"POST"]) {
        NSMutableData *postBody = [NSMutableData data];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        if (parameters) {
            NSEnumerator *keys = [parameters keyEnumerator];
            int i;
            NSUInteger count = [parameters count] - 1;
            for (i = 0; i < [parameters count]; i++) {
                NSString *key = [keys nextObject];
                NSString *bodyString = [NSString stringWithFormat:@"%@=%@%@",key,[parameters objectForKey:key],(i<count ?  @"&" : @"")];
                [postBody appendData:[bodyString dataUsingEncoding:NSUTF8StringEncoding]];
            }
        }
        
        [request setHTTPBody:postBody];
    } else if([method isEqualToString:@"GET"]) {
        
    }*/
    return request;
}

-(NSString *)generateURL:(NSString *)baseURL params:(NSDictionary *)params httpMedthod:(NSString *)medthod
{
    if ([medthod isEqualToString:@"POST"]) {
        return baseURL;
    }
    NSURL *parsedURL = [NSURL URLWithString:baseURL];
    NSString *queryPrefix = parsedURL.query ? @"&" : @"?";
    NSString *query = [self stringFromDictionary:params];
    
    return [NSString stringWithFormat:@"%@%@%@", baseURL, queryPrefix, query];
}

-(NSString *)stringFromDictionary:(NSDictionary *)dict
{
    NSMutableArray *pairs = [NSMutableArray array];
    for (id key in [dict keyEnumerator]) {
        id value = [dict valueForKey:key];
        
        NSString *keyString = escapedQueryStringKeyFromStringWithEncoding([key description],NSUTF8StringEncoding);
        NSString *valueString = AFPercentEscapedQueryStringValueFromStringWithEncoding([value description],NSUTF8StringEncoding);
        [pairs addObject:[NSString stringWithFormat:@"%@=%@", keyString,valueString]];
    }
    
    return [pairs componentsJoinedByString:@"&"];
}

@end
