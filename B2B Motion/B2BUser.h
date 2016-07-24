//
//  B2BUser.h
//  B2B Motion
//
//  Created by Andrey Morozov on 20.07.2016.
//  Copyright © 2016 Andrey Morozov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface B2BUser : NSObject

@property(nonatomic,strong)NSString *token;

+ (id)sharedInstance;

@end
