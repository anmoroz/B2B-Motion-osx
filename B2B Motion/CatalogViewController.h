//
//  CatalogViewController.h
//  B2B Motion
//
//  Created by Andrey Morozov on 14.07.2016.
//  Copyright © 2016 Andrey Morozov. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface CatalogViewController : NSViewController <NSTableViewDataSource, NSTableViewDelegate> {
    
}

@property (nonatomic, weak) IBOutlet NSTableView *productTableView;
@property (strong) NSMutableArray *products;

- (void)loadProducts;

@end
