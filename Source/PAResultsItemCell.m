// Copyright (c) 2006-2011 nudge:nudge (Johannes Hoffart & Daniel Bär). All rights reserved.
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "PAResultsItemCell.h"


@implementation PAResultsItemCell

#pragma mark Init + Dealloc
- (id)initTextCell:(NSString *)aText
{
	self = [super initTextCell:aText];
	if (self)
	{
		// Nothing
	}	
	return self;
}

- (void)dealloc
{
	[super dealloc];
}


#pragma mark Drawing
- (void)drawInteriorWithFrame:(NSRect)cellFrame inView:(NSView *)controlView
{	
	// Draw finder label
	NSUInteger label = [FVFinderLabel finderLabelForURL:[item url]];
	
	if (![self isHighlighted])
	{
		[FVFinderLabel drawFinderLabel:label inRect:cellFrame roundEnds:YES];
	} else {
		NSRect frame = NSMakeRect(cellFrame.origin.x + cellFrame.size.width - cellFrame.size.height - 2,
								  cellFrame.origin.y + 2,
								  cellFrame.size.height - 4,
								  cellFrame.size.height - 4);
		[FVFinderLabel drawFinderLabel:label inRect:frame roundEnds:YES];
	}
	
	// Draw icon
	NSRect iconFrame = cellFrame;
	iconFrame.origin.x += 5;
	iconFrame.origin.y += 1;
	iconFrame.size = NSMakeSize(16,16);
	
	// TODO taggableObject does not necessarily have a path
	NSImage *icon = [[PAThumbnailManager sharedInstance] iconForFile:[item path]
	                                                          inView:controlView
															   frame:iconFrame];
	[icon setSize:NSMakeSize(16,16)];
	[icon setFlipped:YES];
	[icon setCachedSeparately:YES];
	
	NSRect imageRect;
	imageRect.origin = NSZeroPoint;
	imageRect.size = [icon size];
	
	[icon drawAtPoint:iconFrame.origin fromRect:imageRect operation:NSCompositeSourceOver fraction:1.0];
	
	// Font attributes
	NSMutableDictionary *fontAttributes = [NSMutableDictionary dictionaryWithCapacity:3];
	
	NSColor *textColor = [NSColor blackColor];
	
	// isDescendantOf may fail
	@try
	{
		if([self isHighlighted] &&
		   [[[controlView window] firstResponder] isDescendantOf:[controlView superview]] &&
		   [[controlView window] isKeyWindow]) 
		{
			// This depends on whether it is used in an OutlineView or a TableView or somewhere else
			if([controlView isKindOfClass:[NSOutlineView class]])
			{
				if(![[(NSOutlineView *)controlView itemAtRow:[controlView editedRow]] isEqualTo:item])
					textColor = [NSColor whiteColor];
			}
		}
	}
	@catch(NSException *e) {}
	
	[fontAttributes setObject:textColor forKey:NSForegroundColorAttributeName];	
	[fontAttributes setObject:[NSFont systemFontOfSize:11] forKey:NSFontAttributeName];
	
	NSMutableParagraphStyle *paraStyle = [[[NSParagraphStyle defaultParagraphStyle] mutableCopy] autorelease];
	[paraStyle setLineBreakMode:NSLineBreakByTruncatingMiddle];
	[fontAttributes setObject:paraStyle forKey:NSParagraphStyleAttributeName];
	
	// Draw display name	
	NSString *value = [item displayName];
	
	[value	drawInRect:NSMakeRect(cellFrame.origin.x + 25,
								  cellFrame.origin.y + 2,
								  cellFrame.size.width - 190 - 25,
								  cellFrame.size.height - 2)
	    withAttributes:fontAttributes];
		
	// Begin drawing second column
	NSString *sortKey = [[[controlView delegate] sortDescriptor] key];
	
	// Set up date formatter
	NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];	
	[dateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
	[dateFormatter setTimeStyle:NSDateFormatterShortStyle];
	[dateFormatter setDateStyle:NSDateFormatterLongStyle];	
	
	if ([sortKey isEqualToString:@"displayName"] ||
		[sortKey isEqualToString:@"label"])
	{		
		//value = [dateFormatter friendlyStringFromDate:[item lastUsedDate]];
		value = [dateFormatter stringFromDate:[item lastUsedDate]];
	} 
	else if ([sortKey isEqualToString:@"creationDate"])
	{
		value = [dateFormatter stringFromDate:[item creationDate]];
	}
	else if ([sortKey isEqualToString:@"modificationDate"])
	{
		value = [dateFormatter stringFromDate:[item modificationDate]];
	}
	else if ([sortKey isEqualToString:@"kind"])
	{
		value = [item kind];
	}
	else if ([sortKey isEqualToString:@"size"])
	{
		NSNumberFormatter *numberFormatter = [[[NSNumberFormatter alloc] init] autorelease];
		[numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
		
		value = [numberFormatter stringFromFileSize:[item size]];
	}
	else {
		value = @"";
	}
	
	[value	drawInRect:NSMakeRect(cellFrame.origin.x + cellFrame.size.width - 170,
								  cellFrame.origin.y + 2,
								  160,
								  cellFrame.size.height - 2)
	   withAttributes:fontAttributes];
}


#pragma mark Renaming Stuff
- (void)editWithFrame:(NSRect)aRect inView:(NSView *)controlView editor:(NSText *)textObj delegate:(id)anObject event:(NSEvent *)theEvent
{
	NSLog(@"editWithFrame");
}

- (void)selectWithFrame:(NSRect)aRect inView:(NSView *)controlView editor:(NSText *)textObj delegate:(id)anObject start:(NSInteger)selStart length:(NSInteger)selLength
{	
	NSRect frame = aRect;
	frame.origin.x += 25;
	frame.origin.y += 1;
	frame.size.width -= 180 + 25; 
	frame.size.height -= 3;
	
	[super selectWithFrame:frame inView:controlView editor:textObj delegate:anObject start:selStart length:selLength];

	[textObj setFont:[NSFont systemFontOfSize:11]];
	[textObj setString:[item displayName]];
	
	[textObj selectAll:self];
}


#pragma mark Class Methods
+ (CGFloat)heightOfRow
{
	return 19.0;
}


#pragma mark Accessors
- (id)objectValue
{
	return item;
}

- (void)setObjectValue:(id <NSCopying>)object
{
	item = object;
}

@end
