#import "PAFileBox.h"

@implementation PAFileBox

- (void)awakeFromNib
{
	dropManager = [[PADropManager alloc] init];
	
	[self registerForDraggedTypes:[dropManager handledPboardTypes]];
	highlight = NO;
}

- (void)dealloc
{
    [self unregisterDraggedTypes];
	[dropManager release];
    [super dealloc];
}

#pragma mark accessors

- (void)setFiles:(NSMutableArray*)fileArray
{
	[fileArray retain];
	[files release];
	files = fileArray;
}

- (NSMutableArray*)files
{
	return files;
}

- (void)setFileIcon:(NSImage*)newIcon 
{
	[newIcon setSize:NSMakeSize(64,64)];
	[self setImage:newIcon];
}

- (NSImage*)fileIcon
{
	return [self image];
}

#pragma mark drap & drop stuff
//code of cocoadevcentral tutorial

- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender
{
	[[self window] mouseEvent];
	
	return NSDragOperationCopy;
	
	/*
	
    if ((NSDragOperationGeneric & [sender draggingSourceOperationMask]) 
		== NSDragOperationGeneric)
    {
        //this means that the sender is offering the type of operation we want
        //return that we want the NSDragOperationGeneric operation that they 
		//are offering
		highlight = YES;
		[self setNeedsDisplay:YES];
        return NSDragOperationGeneric;
    }
    else
    {
        //since they aren't offering the type of operation we want, we have 
		//to tell them we aren't interested
        return NSDragOperationNone;
    }
	 */
}

- (void)draggingExited:(id <NSDraggingInfo>)sender
{
	[[self window] mouseEvent];
}

- (void)draggingEnded:(id <NSDraggingInfo>)sender
{
	//nothin
}

- (BOOL)prepareForDragOperation:(id <NSDraggingInfo>)sender
{
    return YES;
}

- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender
{
	NSArray *files = [dropManager handleDrop:[sender draggingPasteboard]];
	[self setFiles:files];
	
	/* TODO file icons on sidebar? i don't think that is needed
	if ([files count] == 1)
	{
		[self setFileIcon:[[files objectAtIndex:0] icon]];
	}
	else
	{
		[self setFileIcon:[[NSWorkspace sharedWorkspace] iconForFileType:NSPlainFileType]];
	}
			
	[self setNeedsDisplay:YES];
	 */
	
    return YES;
}

/**
executes some interface stuff
 */
- (void)concludeDragOperation:(id <NSDraggingInfo>)sender
{	
	highlight = NO;
    [self setNeedsDisplay:YES];
}

@end
