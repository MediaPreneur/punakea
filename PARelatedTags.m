//
//  PARelatedTags.m
//  punakea
//
//  Created by Johannes Hoffart on 17.02.06.
//  Copyright 2006 __MyCompanyName__. All rights reserved.
//

#import "PARelatedTags.h"

@implementation PARelatedTags

- (id)initWithQuery:(NSMetadataQuery*)aQuery {
	self = [super init];
	if (self) {
		tags = [[NSMutableArray alloc] init];
		query = aQuery;
		[query retain];
		
		//register with notificationcenter - listen for changes in the query results -- activeFiles is the query
		nf = [NSNotificationCenter defaultCenter];
		[nf addObserver:self selector:@selector(queryNote:) name:nil object:query];
		//TODO add system Tags ... how?
	}
	return self;
}

- (void)dealloc {
	[nf removeObserver:self];
	[tags release];
	[query release];
	[super dealloc];
}

//act on query notifications -- relatedTags need to be kept in sync with files
- (void)queryNote:(NSNotification*)note {
	if ([[note name] isEqualToString:NSMetadataQueryDidFinishGatheringNotification] 
		|| [[note name] isEqualToString:NSMetadataQueryGatheringProgressNotification]
		|| [[note name] isEqualToString:NSMetadataQueryDidUpdateNotification]) {
		updateRelatedTags:;
	}
}

- (void)updateRelatedTags {
	//disable updates, parse files, continue -- TODO make more efficient, performance will SUCK
	[tags removeAllObjects];
	
	[query disableUpdates];
	
	int i = [query resultCount];
	while (i--) {
		//get keywords for result
		NSArray *keywords = [[PATaggerInterface sharedInstance] getTagsForFile:[query resultAtIndex:i]];
		
		int j = [keywords count];
		while (j--) {
			if (![tags containsObject:[keywords objectAtIndex:j]]) {
				[tags addObject:[keywords objectAtIndex:i]];
			}
		}
	}
	[query enableUpdates];
}

@end
