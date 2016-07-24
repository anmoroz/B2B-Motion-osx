//
//  B2BHttpClient.m
//  B2B Motion
//
//  Created by Andrey Morozov on 23.07.2016.
//  Copyright © 2016 Andrey Morozov. All rights reserved.
//

#import "B2BHttpClient.h"
#import "B2BConstants.h"
#import "B2BUser.h"

@implementation B2BHttpClient

+ (instancetype)sharedClient {
    static B2BHttpClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *token = [[B2BUser sharedInstance] token];
        NSMutableDictionary *sessionHeaders = [NSMutableDictionary dictionaryWithDictionary:@{ @"Authorization": token }];
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        sessionConfiguration.HTTPAdditionalHeaders = sessionHeaders;
        
        _sharedClient = [[B2BHttpClient alloc] initWithBaseURL: [NSURL URLWithString: BASE_API_URL] sessionConfiguration: sessionConfiguration];
    });
    
    return _sharedClient;
}

@end
