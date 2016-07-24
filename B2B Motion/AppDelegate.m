//
//  AppDelegate.m
//  B2B Motion
//
//  Created by Andrey Morozov on 14.07.2016.
//  Copyright © 2016 Andrey Morozov. All rights reserved.
//

#import "AppDelegate.h"
#include "CatalogViewController.h"
#include "AuthViewController.h"

@interface AppDelegate ()


@end

@implementation AppDelegate

- (void)setMainViewTo:(NSViewController *)controller
{
    //Remove existing subviews
    while ([[self.window.contentView subviews] count] > 0)
    {
        [self.window.contentView.subviews[0] removeFromSuperview];
    }
    NSView * view = [controller view];
    [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.window.contentView addSubview:view];
    
    NSDictionary * viewsDictionary = NSDictionaryOfVariableBindings(view);
    
    [self.window.contentView addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|"
                                                                                     options:0
                                                                                     metrics:nil
                                                                                       views:viewsDictionary]];
    
    [self.window.contentView addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|"
                                                                                     options:0
                                                                                     metrics:nil
                                                                                       views:viewsDictionary]];
    self.currentViewController = controller;
}

- (IBAction)showAuthView:(id)sender
{
    AuthViewController * controller = [[AuthViewController alloc] init];
    [self setMainViewTo:controller];
    
    // Center position
    CGFloat xPos = NSWidth([[self.window screen] frame])/2 - NSWidth([self.window frame])/2;
    CGFloat yPos = NSHeight([[self.window screen] frame])/2 - NSHeight([self.window frame])/2;
    [self.window setFrame:NSMakeRect(xPos, yPos, NSWidth([self.window frame]), NSHeight([self.window frame])) display:YES];
}

- (IBAction)showCatalogView:(id)sender
{
    CatalogViewController * controller = [[CatalogViewController alloc] init];
    [self setMainViewTo:controller];
}


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [self showAuthView:self];
    //[self showCatalogView:self];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
