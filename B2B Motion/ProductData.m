//
//  ProductData.m
//  B2B Motion
//
//  Created by Andrey Morozov on 14.07.2016.
//  Copyright © 2016 Andrey Morozov. All rights reserved.
//

#import "ProductData.h"

@implementation ProductData

- (id)initWithTitle:(NSString*)name price:(float)price {
    if ((self = [super init])) {
        //self.article = article;
        self.name = name;
        self.price = price;
    }
    return self;
}

@end
