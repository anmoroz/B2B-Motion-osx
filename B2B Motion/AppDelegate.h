//
//  AppDelegate.h
//  B2B Motion
//
//  Created by Andrey Morozov on 14.07.2016.
//  Copyright © 2016 Andrey Morozov. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (strong) NSViewController* currentViewController;

- (IBAction)showAuthView:(id)sender;
- (IBAction)showCatalogView:(id)sender;

@end

