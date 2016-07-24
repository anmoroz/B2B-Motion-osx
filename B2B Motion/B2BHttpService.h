//
//  B2BHttpService.h
//  B2B Motion
//
//  Created by Andrey Morozov on 20.07.2016.
//  Copyright © 2016 Andrey Morozov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface B2BHttpService : NSObject

@property (readonly, nonatomic, strong) NSURL *baseURL;
@property (nonatomic, strong) NSURLSession *session;

+(id)sharedInstance;
- (NSURLSessionDataTask *)GET:(NSString *)urlString
                   parameters:(id)parameters
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end
