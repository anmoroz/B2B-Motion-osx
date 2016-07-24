//
//  B2BHttpClient.h
//  B2B Motion
//
//  Created by Andrey Morozov on 23.07.2016.
//  Copyright © 2016 Andrey Morozov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface B2BHttpClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

@end
