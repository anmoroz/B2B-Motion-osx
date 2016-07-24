//
//  ProductDoc.m
//  B2B Motion
//
//  Created by Andrey Morozov on 14.07.2016.
//  Copyright © 2016 Andrey Morozov. All rights reserved.
//

#import "ProductDoc.h"
#import "ProductData.h"

@implementation ProductDoc

- (id)initByArray:(NSArray*)properties {
    
    return self;
}

- (id)initWithTitle:(NSString*)name price:(float)price thumbImage:(NSImage *)thumbImage {
    if ((self = [super init])) {
        self.data = [[ProductData alloc] initWithTitle:name price:price];
        self.thumbImage = thumbImage;
    }
    return self;
}

@end
