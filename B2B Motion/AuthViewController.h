//
//  AuthViewController.h
//  B2B Motion
//
//  Created by Andrey Morozov on 19.07.2016.
//  Copyright © 2016 Andrey Morozov. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AuthViewController : NSViewController

@property (weak) IBOutlet NSSecureTextField *authPassword;
@property (weak) IBOutlet NSTextField *authPhone;
@property (weak) IBOutlet NSButton *authButton;
@property (weak) IBOutlet NSBox *authBox;

- (IBAction)liginAction:(id)sender;

@end
