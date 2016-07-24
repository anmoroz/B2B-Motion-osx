//
//  ProductService.h
//  B2B Motion
//
//  Created by Andrey Morozov on 15.07.2016.
//  Copyright © 2016 Andrey Morozov. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Foundation/Foundation.h>

@interface ProductService : NSObject

+ (NSURLSessionDataTask *)fetchList:(NSMutableDictionary *)filter
                              block:(void (^)(NSHTTPURLResponse *response, NSMutableArray *products, NSError *error))block;

+ (NSURLSessionDataTask *)getOneProducts:(NSString *)productId
                                   block:(void (^)(NSObject *product, NSError *error))block;

@end
