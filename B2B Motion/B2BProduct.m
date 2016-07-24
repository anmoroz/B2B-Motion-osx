//
//  B2BProduct.m
//  B2B Motion
//
//  Created by Andrey Morozov on 15.07.2016.
//  Copyright © 2016 Andrey Morozov. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "B2BProduct.h"
#import "B2BConstants.h"

@implementation B2BProduct

- (void)setThumbImageByUrl:(NSString*)urlString
{
    
    NSURL *imageUrl = [NSURL URLWithString:urlString];
    NSData *imageData = [[NSData alloc] initWithContentsOfURL:imageUrl];
    
    self.thumbImage = [[NSImage alloc] initWithData:imageData];
}

- (instancetype)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.name = [attributes valueForKey: @"name"];
    
    NSString *price = [attributes valueForKeyPath: @"price.value"];
    self.price = [price floatValue];
    
    NSArray *stocks = [attributes valueForKey: @"stocks"];
    
    
    for (NSString *stockKey in stocks) {
        id value = [stocks valueForKey:stockKey];
        
        if ([value valueForKey: @"isVirtual"]) {
            self.amount = [[value valueForKey: @"amount"] floatValue];
            break;
        }
    }
    self.unitName = [attributes valueForKey: @"unitName"];
    
    self.article = [attributes valueForKey: @"article"];
    [self setThumbImageByUrl: [NSString stringWithFormat:@"%@%@", BASE_URL, [attributes valueForKeyPath: @"image.60"]]];
    
    
    return self;
}

@end
