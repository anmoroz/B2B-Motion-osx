//
//  ProductDoc.h
//  B2B Motion
//
//  Created by Andrey Morozov on 14.07.2016.
//  Copyright © 2016 Andrey Morozov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ProductData;

@interface ProductDoc : NSObject

@property (strong) ProductData *data;
@property (strong) NSImage *thumbImage;

- (id)initWithTitle:(NSString*)name price:(float)price thumbImage:(NSImage *)thumbImage;

- (id)initByArray:(NSArray*)properties;

@end
