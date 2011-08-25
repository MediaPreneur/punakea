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

#import "PATokenFieldCell.h"
#import "PATokenAttachmentCell.h"


@implementation PATokenFieldCell

- (id)setUpTokenAttachmentCell:(NSTokenAttachmentCell *)aCell forRepresentedObject:(id)anObj 
{
	PATokenAttachmentCell *attachmentCell = [[PATokenAttachmentCell alloc] initTextCell:[aCell stringValue]];
	
	// Get colors from delegate
	if ([[self delegate] respondsToSelector:@selector(tokenFieldCell:tokenForegroundColorForRepresentedObject:)])
	{
		NSColor *color = [[self delegate] tokenFieldCell:self tokenForegroundColorForRepresentedObject:anObj];
		[attachmentCell setTokenForegroundColor:color];
	}
	
	if ([[self delegate] respondsToSelector:@selector(tokenFieldCell:tokenBackgroundColorForRepresentedObject:)])
	{
		NSColor *color = [[self delegate] tokenFieldCell:self tokenBackgroundColorForRepresentedObject:anObj];
		[attachmentCell setTokenBackgroundColor:color];
	}
	
	[attachmentCell setRepresentedObject:anObj];
	[attachmentCell setAttachment:[aCell attachment]];
	[attachmentCell setControlSize:[self controlSize]];
	[attachmentCell setTextColor:[NSColor blackColor]];
	[attachmentCell setFont:[self font]];
	
	return [attachmentCell autorelease];
}

@end
