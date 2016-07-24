//
//  UserService.m
//  B2B Motion
//
//  Created by Andrey Morozov on 19.07.2016.
//  Copyright © 2016 Andrey Morozov. All rights reserved.
//

#import "UserService.h"
#import "B2BConstants.h"
#import "B2BUser.h"

@implementation UserService

- (NSURLSessionDataTask *)signinWithPhone:(NSString *)phone
                                 Password:(NSString *)password
                                  success:(void (^)(NSURLSessionDataTask *))success
                                authError:(void (^)(NSURLSessionDataTask *))authError
                                  failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError *))failure
{
    NSString *dataUrl = [NSString stringWithFormat:@"%@%@", BASE_API_URL, @"user/login"];
    NSURL *url = [NSURL URLWithString:dataUrl];
    
    
    NSString *noteDataString = [NSString stringWithFormat:@"phone=%@&password=%@", phone, password];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPBody = [noteDataString dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPMethod = @"POST";
    
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig];
    
    NSURLSessionDataTask *task = [session
                      dataTaskWithRequest:request
                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
              if (!error) {
                  NSError* error = nil;
                  id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                  
                  if (success) {
                      NSLog(@"result: %@", result);

                      NSNumber *errorCode = (NSNumber*)[result objectForKey:@"errorCode"];
                      
                      NSLog(@"errorCode: %@", errorCode);
                      
                      NSInteger status = [errorCode integerValue];
                      if (status == 0) {
                          B2BUser *user =[B2BUser sharedInstance];
                          NSString *token = [NSString stringWithFormat:@"%@ %@", @"Bearer", [result valueForKey: @"token"]];
                          [user setToken:token];
                          
                          success(task);
                      } else{
                          authError(task);
                      }
                  }
              } else {
                  NSLog(@"Error parsing JSON. %@", error);
                  failure(task, error);
              }
          }
    ];
    
    [task resume];
    
    return task;
}

@end
