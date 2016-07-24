//
//  B2BUser.m
//  B2B Motion
//
//  Created by Andrey Morozov on 20.07.2016.
//  Copyright © 2016 Andrey Morozov. All rights reserved.
//

#import "B2BUser.h"

@implementation B2BUser

+ (B2BUser *)sharedInstance {
    static B2BUser *sharedUser = nil;
    static dispatch_once_t once;
    dispatch_once(&once,^{
        sharedUser = [[B2BUser alloc] init];
    });
    
    return sharedUser;
}

- (void)setToken:(NSString *)token {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:token forKey:@"token"];
    [userDefaults synchronize];
}

- (NSString *)token {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    return [userDefaults stringForKey:@"token"];
}

@end
