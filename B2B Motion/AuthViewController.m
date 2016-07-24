//
//  AuthViewController.m
//  B2B Motion
//
//  Created by Andrey Morozov on 19.07.2016.
//  Copyright © 2016 Andrey Morozov. All rights reserved.
//

#import "AuthViewController.h"
#import "UserService.h"
#import "AppDelegate.h"

@interface AuthViewController ()

@end

@implementation AuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

- (IBAction)liginAction:(id)sender
{
    UserService *user = [[UserService alloc] init];
    NSApplication *app = [NSApplication sharedApplication];
    AppDelegate *appDelegate = [app delegate];
    
    [user signinWithPhone:[self.authPhone stringValue] Password:[self.authPassword stringValue]
          success:^(NSURLSessionDataTask *task) {
              dispatch_async(dispatch_get_main_queue(), ^{
                  [appDelegate showCatalogView:self];
              });
          }
          authError:^(NSURLSessionDataTask * _Nullable authError) {
              [self.authBox setFillColor:[NSColor colorWithCalibratedRed:1.0 green:0.0 blue:0.0 alpha:0.2]];
          }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
              NSAlert *alert = [[NSAlert alloc] init];
              [alert setMessageText:@"Ошибка"];
              [alert setInformativeText:@"Извините, сервис временно недоступен"];
              [alert addButtonWithTitle:@"OK"];
              [alert setAlertStyle:NSWarningAlertStyle];
              [alert beginSheetModalForWindow:appDelegate.window completionHandler:^(NSModalResponse returnCode) {}];
          }
     ];
    
}



@end
