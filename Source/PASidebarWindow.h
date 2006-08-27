//
//  PASidebar.h
//  punakea
//
//  Created by Johannes Hoffart on 26.06.06.
//  Copyright 2006 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

extern double const SHOW_DELAY;

/**
TODO delay
  TODO check if tracking rects are handled correctly
 TODO send all mouse events to window, let window decide what to do
 */
@interface PASidebarWindow : NSWindow {
	NSMutableDictionary *appearance;
	NSNotificationCenter *nc;
	
	BOOL expanded;
}

- (BOOL)isExpanded;
- (void)setExpanded:(BOOL)flag;

- (BOOL)isMoving;
- (void)setMoving:(BOOL)flag;

/** 
should be called after a mouse event inside the sidebar
- checks if it should be shown
*/
- (void)mouseEvent;
	
@end
