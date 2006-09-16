#import "SidebarController.h"

@interface SidebarController (PrivateAPI)

- (void)addTagToFileTags:(PATag*)tag;
- (void)updateTagsOnFile;

@end

@implementation SidebarController

- (id)initWithWindowNibName:(NSString*)nibName
{
	if (self = [super initWithWindowNibName:nibName])
	{
		tagger = [PATagger sharedInstance];
		tags = [tagger tags];
	}
	return self;
}

- (void)awakeFromNib 
{	
	//TODO can be done from IB ... do this!
	//init sorting
	NSSortDescriptor *popularDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"absoluteRating" ascending:NO] autorelease];
	NSArray *popularSortDescriptors = [NSArray arrayWithObject:popularDescriptor];
	[popularTags setSortDescriptors:popularSortDescriptors];
	
	//TODO asc or desc?!
	NSSortDescriptor *recentDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"lastUsed" ascending:YES] autorelease];
	NSArray *recentSortDescriptors = [NSArray arrayWithObject:recentDescriptor];
	[recentTags setSortDescriptors:recentSortDescriptors];
	
	//observe files on fileBox
	[fileBox addObserver:self forKeyPath:@"files" options:0 context:NULL];
	
	//drag & drop
	[popularTagsTable registerForDraggedTypes:[NSArray arrayWithObjects:NSFilenamesPboardType, nil]];
	popularTagTableController = [[PASidebarTableViewDropController alloc] initWithTags:popularTags];
	[popularTagsTable setDataSource:popularTagTableController];
	
	[recentTagsTable registerForDraggedTypes:[NSArray arrayWithObjects:NSFilenamesPboardType, nil]];
	recentTagTableController = [[PASidebarTableViewDropController alloc] initWithTags:recentTags];
	[recentTagsTable setDataSource:recentTagTableController];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
					  ofObject:(id)object 
                        change:(NSDictionary *)change
                       context:(void *)context
{
	if ([keyPath isEqual:@"files"]) 
		[self newFilesHaveBeenDropped];
}

#pragma mark tag field delegates
/**
action called on dropping files to FileBox
 */
- (void)newFilesHaveBeenDropped
{	
	// if the tagger is already open, add more files
	if (taggerController)
	{
		[taggerController showWindow:nil];
		NSWindow *taggerWindow = [taggerController window];
		[taggerWindow makeKeyAndOrderFront:nil];
		[[NSApplication sharedApplication] activateIgnoringOtherApps:YES];
		
		NSArray *filesToBeAdded = [fileBox files];
		NSArray *filesOnController = [taggerController files];
		NSMutableArray *result = [NSMutableArray array];
		
		NSEnumerator *e = [filesToBeAdded objectEnumerator];
		PAFile *file;
		
		while (file = [e nextObject])
		{
			if (![filesOnController containsObject:file])
			{
				[result addObject:file];
			}
		}
		
		[taggerController addFiles:result];
	}
	// otherwise create new tagger window
	else 
	{
		taggerController = [[TaggerController alloc] initWithWindowNibName:@"Tagger"];
		[[NSApplication sharedApplication] activateIgnoringOtherApps:YES];
		NSWindow *taggerWindow = [taggerController window];
		[taggerWindow makeKeyAndOrderFront:nil];
		[taggerController addFiles:[fileBox files]];
	}
}

@end
