//
//  B2BProduct.h
//  B2B Motion
//
//  Created by Andrey Morozov on 15.07.2016.
//  Copyright © 2016 Andrey Morozov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface B2BProduct : NSObject

@property (strong) NSString *article;
@property (strong) NSString *name;
@property (strong) NSString *unitName;
@property (assign) float price;
@property (assign) float amount;

@property (strong) NSImage *thumbImage;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

- (void)setThumbImageByUrl:(NSString*)urlString;

@end
