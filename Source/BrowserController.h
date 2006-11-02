//
//  BrowserController.h
//  punakea
//
//  Created by Johannes Hoffart on 04.07.06.
//  Copyright 2006 nudge:nudge. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "BrowserViewController.h"
#import "PAQuery.h"
#import "PATagCloud.h"

@interface BrowserController : NSWindowController 
{
	BrowserViewController				*browserViewController;
}

- (BrowserViewController*)browserViewController;

@end
