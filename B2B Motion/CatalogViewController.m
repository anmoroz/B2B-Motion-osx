//
//  CatalogViewController.m
//  B2B Motion
//
//  Created by Andrey Morozov on 14.07.2016.
//  Copyright © 2016 Andrey Morozov. All rights reserved.
//

#import "CatalogViewController.h"
#import "B2BProduct.h"
#import "ProductService.h"

@interface CatalogViewController ()

@property (weak) IBOutlet NSProgressIndicator *progressIndicator;
@property (weak) IBOutlet NSView *searchToolBar;

@end

@implementation CatalogViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.progressIndicator startAnimation:self];
    [self loadProducts];
}

- (void) loadProducts {
    
    [self showProgressIndicator];
    
    [ProductService getProductsWithLimit:20 block:^(NSMutableArray *products, NSError *error) {
        NSLog(@"products %@", products);
        if (!error) {
            self.products = products;
            
            [self.productTableView reloadData];
            [self hideProgressIndicator];
            [self.searchToolBar setHidden:NO];
            
            //[self.tableView reloadData];
            
            //self.post = posts.firstObject;
            //[self savePost:self.post];
            
            //if (completionHandler) {
            //    completionHandler(self.post != nil ? NCUpdateResultNewData : NCUpdateResultNoData);
            //}
            
        } else {
            NSLog(@"error %@", error);
            //if (completionHandler) {
            //    completionHandler(NSUpdateResultFailed);
            //}
        }
    }];
}


- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    
    // Get a new ViewCell
    NSTableCellView *cellView = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
    
    B2BProduct *product = [self.products objectAtIndex:row];

    if( [tableColumn.identifier isEqualToString:@"ImageColumn"] ) {
        cellView.imageView.image = product.thumbImage;
        return cellView;
    }
    
    if( [tableColumn.identifier isEqualToString:@"NameColumn"] ) {
        cellView.textField.stringValue = product.name;
        return cellView;
    }
    
    if( [tableColumn.identifier isEqualToString:@"ArticleColumn"] ) {
        cellView.textField.stringValue = product.article;
        return cellView;
    }
    
    if( [tableColumn.identifier isEqualToString:@"AmountColumn"] ) {
        NSString *amountString = [NSString stringWithFormat:@"%.0f", product.amount];
        cellView.textField.stringValue = [NSString stringWithFormat:@"%@ %@", amountString, product.unitName];
        return cellView;
    }
    
    if( [tableColumn.identifier isEqualToString:@"PriceColumn"] ) {
        //cellView.textField.floatValue = product.price;
        cellView.textField.stringValue = [NSString stringWithFormat:@"%.2f", product.price];
        return cellView;
    }
    
    return cellView;
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    NSLog(@"Count products %lu", [self.products count]);
    return [self.products count];
}

- (void)showProgressIndicator {
    [self.progressIndicator setHidden:NO];
    [self.progressIndicator startAnimation:self];
}

- (void)hideProgressIndicator {
    [self.progressIndicator setHidden:YES];
    [self.progressIndicator stopAnimation:self];
}

@end
