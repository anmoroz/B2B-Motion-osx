//
//  B2BHttpUtil.h
//  B2B Motion
//
//  Created by Andrey Morozov on 20.07.2016.
//  Copyright © 2016 Andrey Morozov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface B2BHttpUtil : NSObject

+(id)sharedInstance;

-(NSMutableURLRequest *)requestWithMethod:(NSString *)method
                                URLString:(NSString *)URLString
                               parameters:(NSDictionary *)parameters;
@end
