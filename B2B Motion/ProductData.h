//
//  ProductData.h
//  B2B Motion
//
//  Created by Andrey Morozov on 14.07.2016.
//  Copyright © 2016 Andrey Morozov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductData : NSObject

@property (strong) NSString *article;
@property (strong) NSString *name;
@property (assign) float price;

- (id)initWithTitle:(NSString*)name price:(float)price;

@end
