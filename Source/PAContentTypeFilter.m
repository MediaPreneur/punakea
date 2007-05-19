//
//  PAContentTypeFilter.m
//  NNTagging
//
//  Created by Johannes Hoffart on 19.04.07.
//  Copyright 2007 __MyCompanyName__. All rights reserved.
//

#import "PAContentTypeFilter.h"

@implementation PAContentTypeFilter

#pragma mark init
- (id)initWithContentType:(NSString*)type
{
	if (self = [super init])
	{
		weight = 10;
		contentType = [type copy];
		
		tagCache = [PATagCache sharedInstance];
		
		selectedTags = [[NNSelectedTags alloc] init];
		query = [[NNQuery alloc] initWithTags:selectedTags];

		[[NSNotificationCenter defaultCenter] addObserver:self 
												 selector:@selector(queryNote:) 
													 name:NNQueryGatheringProgressNotification 
												   object:query];
		
		[[NSNotificationCenter defaultCenter] addObserver:self 
												 selector:@selector(queryNote:) 
													 name:NNQueryDidFinishGatheringNotification 
												   object:query];
		
		filterLock = [[NSLock alloc] init];
		
		// TODO move this to NNQueryFilters ?
		
		// load groupings
		NSString *path = [[NSBundle mainBundle] pathForResource:@"MDSimpleGrouping" ofType:@"plist"];
		simpleGrouping = [[NSDictionary alloc] initWithContentsOfFile:path];
		
		// add filters for every resource type
		NSArray *contentValues = [simpleGrouping allKeysForObject:contentType];
		
		NSEnumerator *e = [contentValues objectEnumerator];
		NSString *aContentType;
		
		while (aContentType = [e nextObject])
		{
			[query addFilter:[NNQueryFilter queryFilterWithAttribute:(NSString*)kMDItemContentType value:aContentType]];
		}
	}
	return self;
}

- (void)dealloc
{
	[simpleGrouping release];
	[filterLock release];
	[query release];
	[selectedTags release];
	[contentType release];
	[super dealloc];
}

#pragma mark accessors
- (NSString*)contentType
{
	return contentType;
}

#pragma mark function
- (void)run
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	[stateLock lockWhenCondition:NNThreadStopped];
	[stateLock unlockWithCondition:NNThreadRunning];
	
	// start filtering until thread gets canceled	
	while ([stateLock condition] == NNThreadRunning)
	{
		id object = [inQueue dequeueWithTimeout:0.5];
		
		if ([stateLock condition] == NNThreadCanceled)
		{
			break;
		}
		else if (object)
		{
			[self filterObject:object];
		}
	}
	
	[stateLock lock];
	[stateLock unlockWithCondition:NNThreadStopped];
	
	[pool release];
}

- (void)filterObject:(id)object
{
	// look if cache can satisfy request
	PACacheResult result = [tagCache checkFiletype:[self contentType] forTag:object];
	
	if (result & PACacheIsValid)
	{
		if (result & PACacheSatisfiesRequest)
		{
			// cache was valid and object is good to go			
			[self objectFiltered:object];
		}
	}
	else
	{
		// if this is reached, the cache needs to be updated
		// take care of this in the queryNote:
		
		// only one query can be active at a time at the moment
		[selectedTags setSelectedTags:[NSArray arrayWithObject:object]];
		[query startQuery];
		CFRunLoopRun();
	}
}

- (void)queryNote:(NSNotification*)notification
{
	// filtered tag is in selected Tags
	id object = [[[query tags] selectedTags] objectAtIndex:0];
	
	if ([[notification name] isEqualTo:NNQueryDidFinishGatheringNotification])
	{		
		CFRunLoopStop(CFRunLoopGetCurrent ());
		[query stopQuery];
		
		if ([[query flatResults] count] > 0)
		{
			// update cache
			[tagCache updateCacheForTag:object
							setFiletype:[self contentType]
								toValue:YES];
			
			[self objectFiltered:object];
		}
		else
		{
			// update cache
			[tagCache updateCacheForTag:object
							setFiletype:[self contentType]
								toValue:NO];
		}
	}
	else if ([[notification name] isEqualTo:NNQueryGatheringProgressNotification])
	{
		if ([[query flatResults] count] > 0)
		{
			CFRunLoopStop(CFRunLoopGetCurrent ());
			[query stopQuery];
			
			// update cache
			[tagCache updateCacheForTag:object
							setFiletype:[self contentType]
								toValue:YES];
			
			[self objectFiltered:object];
		}
		else
		{
			// update cache
			[tagCache updateCacheForTag:object
							setFiletype:[self contentType]
								toValue:NO];
		}
	}
}

- (NSString*)description
{
	return [NSString stringWithFormat:@"PAContentTypeFilter: %@",contentType];
}

@end
