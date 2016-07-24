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

@property (strong) NSMutableArray *products;
@property (strong) NSMutableDictionary *filter;

@property NSInteger catalogPageNumber;
@property NSInteger catalogTotalPage;
@property (weak) IBOutlet NSButton *prewPageButton;
@property (weak) IBOutlet NSButton *nextPageButton;


@property (weak) IBOutlet NSProgressIndicator *progressIndicator;
@property (weak) IBOutlet NSView *searchToolBar;
@property (nonatomic, weak) IBOutlet NSTableView *productTableView;
@property (weak) IBOutlet NSSearchField *productSearchField;

- (IBAction)nextPage:(id)sender;
- (IBAction)prevPage:(id)sender;
- (IBAction)searchAction:(id)sender;
- (void)fetchData;

@end
