//
//  UserService.h
//  B2B Motion
//
//  Created by Andrey Morozov on 19.07.2016.
//  Copyright © 2016 Andrey Morozov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserService : NSObject

- (NSURLSessionDataTask *)signinWithPhone:(NSString *)phone Password:(NSString *)password
                                  success:(void ( ^ ) ( NSURLSessionDataTask *task ))success
                                authError:(void (^)(NSURLSessionDataTask *))authError
                                  failure:(void ( ^ ) ( NSURLSessionDataTask *task , NSError *error ))failure;

@end
