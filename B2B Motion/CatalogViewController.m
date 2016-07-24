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

@end

@implementation CatalogViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.filter = [NSMutableDictionary dictionary];
    
    self.catalogPageNumber = 1;
    [self.prewPageButton setHidden:YES];
    
    [self.progressIndicator startAnimation:self];
    [self fetchData];
}

-(void)fetchData;
{
    [self showProgressIndicator];

    if (self.catalogPageNumber > 1) {
        [self.filter setObject:[NSNumber numberWithInteger:self.catalogPageNumber] forKey:@"page"];
    }
    
    [ProductService fetchList:self.filter
                                    block:^(NSHTTPURLResponse *response, NSMutableArray *products, NSError *error)
     {
         if (!error) {
             if ([response respondsToSelector:@selector(allHeaderFields)]) {
                 NSDictionary *dictionary = [response allHeaderFields];
                 self.catalogTotalPage = [[dictionary valueForKey:@"X-Pagination-Page-Count"] integerValue];
             }

             self.products = products;
             
             
             NSLog(@"catalogPageNumber %ld", self.catalogPageNumber);
             
             [self.productTableView reloadData];
             [self hideProgressIndicator];
             [self.searchToolBar setHidden:NO];
             
             if (self.catalogPageNumber > 1) {
                 [self.prewPageButton setHidden:NO];
             } else {
                 [self.prewPageButton setHidden:YES];
             }
             if (self.catalogPageNumber == self.catalogTotalPage) {
                 [self.nextPageButton setHidden:YES];
             } else {
                 [self.nextPageButton setHidden:NO];
             }
             
         } else {
             NSLog(@"error %@", error);
         }
     }];
}

- (IBAction)searchAction:(id)sender
{
    NSArray *key = @[@"filters[keyword]"];
    NSArray *data = [[NSArray alloc] initWithObjects:[self.productSearchField stringValue], nil];
    self.filter = [[NSMutableDictionary alloc]initWithObjects:data forKeys:key];
    [self fetchData];
}

- (IBAction)nextPage:(id)sender;
{
    ++self.catalogPageNumber;
    if (self.catalogTotalPage <= self.catalogPageNumber) {
        self.catalogPageNumber = 1;
    }
    [self fetchData];
    
}

- (IBAction)prevPage:(id)sender;
{
    --self.catalogPageNumber;
    [self fetchData];
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
