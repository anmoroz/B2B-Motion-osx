//
//  ProductService.m
//  B2B Motion
//
//  Created by Andrey Morozov on 15.07.2016.
//  Copyright © 2016 Andrey Morozov. All rights reserved.
//

#import "ProductService.h"
#import "B2BProduct.h"
#import "B2BConstants.h"
#import "B2BUser.h"
#import "B2BHttpClient.h"


@implementation ProductService

+ (NSURLSessionDataTask *)getOneProducts:(NSString *)productId
                                   block:(void (^)(NSObject *product, NSError *error))block
{
    return [[B2BHttpClient sharedClient] GET:[NSString stringWithFormat:@"product/%@", productId]
                                  parameters:nil
                                    progress:nil
                                     success:^(NSURLSessionDataTask * __unused task, id JSON)
            {
                B2BProduct *product = [[B2BProduct alloc] initWithAttributes:JSON];
                if (block) {
                    block(product, nil);
                }
            } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
                
                NSLog(@"failure %@", error);
                
                if (block) {
                    block(nil, error);
                }
            }];
}

+ (NSURLSessionDataTask *)fetchList:(NSMutableDictionary *)filter
                              block:(void (^)(NSHTTPURLResponse *response, NSMutableArray *products, NSError *error))block
{
    [filter setObject:[NSNumber numberWithInt:PRODUCTS_PER_PAGE] forKey:@"per-page"];
    
    return [[B2BHttpClient sharedClient] GET:@"product"
                                  parameters:filter
                                    progress:nil
                                     success:^(NSURLSessionDataTask * __unused task, id JSON)
            {
                NSMutableArray *mutableProducts = [NSMutableArray array];
                
                for (NSDictionary *attributes in JSON) {
                    B2BProduct *product = [[B2BProduct alloc] initWithAttributes:attributes];
                    [mutableProducts addObject:product];
                }
                
                if (block) {
                    
                    block((NSHTTPURLResponse*)task.response, mutableProducts, nil);
                }
            } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
                if (block) {
                    block((NSHTTPURLResponse*)task.response, [NSMutableArray array], error);
                }
            }];
}

@end
