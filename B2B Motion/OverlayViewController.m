//
//  OverlayViewController.m
//  B2B Motion
//
//  Created by Andrey Morozov on 18.07.2016.
//  Copyright © 2016 Andrey Morozov. All rights reserved.
//

#import "OverlayViewController.h"

@interface OverlayViewController ()

@property (weak) IBOutlet NSProgressIndicator *progressIndicator;

@end

@implementation OverlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.progressIndicator startAnimation:self];
}

@end
