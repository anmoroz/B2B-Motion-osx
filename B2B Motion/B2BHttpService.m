//
//  B2BHttpService.m
//  B2B Motion
//
//  Created by Andrey Morozov on 20.07.2016.
//  Copyright © 2016 Andrey Morozov. All rights reserved.
//

#import "B2BHttpService.h"
#import "B2BConstants.h"
//#import "B2BHttpUtil.h"

@implementation B2BHttpService

+(B2BHttpService *)sharedInstance {
    static B2BHttpService *sharedHttpService = nil;
    static dispatch_once_t once;
    dispatch_once(&once,^{
        sharedHttpService = [[B2BHttpService alloc] init];
    });
    return sharedHttpService;
}

-(id)init {
    self = [super init];
    
    NSMutableDictionary *sessionHeaders = [NSMutableDictionary dictionaryWithDictionary:@{@"Authorization": @"Bearer 0zsC-iqEpltPMC0hp--tC3G5jp449qWl"}];
    
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    sessionConfiguration.HTTPAdditionalHeaders = sessionHeaders;
    self.session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    
    return self;
}

-(NSURLSessionDataTask *)GET:(NSString *)urlString
                  parameters:(id)parameters
                     success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                     failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSURLSessionDataTask *dataTask = [self dataTaskWithHTTPMethod: @"GET"
                                                        urlString: urlString
                                                       parameters: parameters
                                                          success: success
                                                          failure: failure];
    [dataTask resume];
    
    NSLog(@"GET resume");
    
    return dataTask;
}


-(NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method
                                      urlString:(NSString *)urlString
                                     parameters:(id)parameters
                                        success:(void (^)(NSURLSessionDataTask *, id))success
                                        failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{

    //NSURL *url = [[NSURL URLWithString:urlString relativeToURL:[NSURL URLWithString:BASE_API_URL]] absoluteString];
    //NSMutableURLRequest *request = [[B2BHttpUtil sharedInstance] requestWithMethod:method URLString:url parameters:parameters];
    
    NSString *dataUrl = [NSString stringWithFormat:@"%@%@", BASE_API_URL, urlString];
    NSURL *url = [NSURL URLWithString:dataUrl];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    
    
    [request setHTTPMethod:method];
    
    
    NSURLSessionDataTask *dataTask = [self.session
                                      dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *responseObject, NSError *error)
    {
        if (error) {
            if (failure) {
                failure(dataTask, error);
            }
        } else {
            if (success) {
                success(dataTask, responseObject);
            }
        }
    }];
    
    return dataTask;
    

    /*__block NSURLSessionDataTask *dataTask = nil;
    

    dataTask = [self dataTaskWithRequest:request  completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
        
        NSLog(@"responseObject 2 %@", responseObject);
        
        
        if (error) {
            if (failure) {
                failure(dataTask, error);
            }
        } else {
            if (success) {
                success(dataTask, responseObject);
            }
        }
    }];*/
    
    //return dataTask;
}

-(NSURLSessionDataTask *)dataTaskWithRequest:(NSURLRequest *)request
                           completionHandler:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completionHandler
{
    __block NSURLSessionDataTask *dataTask = nil;
    //dispatch_async(dispatch_get_main_queue(), ^{
        dataTask = [self.session dataTaskWithRequest:request];
    //});
    
    //[self addDelegateForDataTask:dataTask completionHandler:completionHandler];
    
    return dataTask;
}

@end
