//
//  PAQuery.m
//  punakea
//
//  Created by Daniel on 21.05.06.
//  Copyright 2006 __MyCompanyName__. All rights reserved.
//

#import "PAQuery.h"

NSString * const PAQueryDidStartGatheringNotification = @"PAQueryDidStartGatheringNotification";
NSString * const PAQueryGatheringProgressNotification = @"PAQueryGatheringProgressNotification";
NSString * const PAQueryDidUpdateNotification = @"PAQueryDidUpdateNotification";
NSString * const PAQueryDidFinishGatheringNotification = @"PAQueryDidFinishGatheringNotification";

//NSString * const PAQueryGroupingAttributesDidChange = @"PAQueryGroupingAttributesDidChange";

@interface PAQuery (PrivateAPI)

- (void)tagsHaveChanged:(NSNotification *)note;
- (void)updateQueryFromTags;
- (NSString*)queryStringForTags:(NSArray*)tags;

- (NSPredicate *)predicate;
- (void)setPredicate:(NSPredicate *)aPredicate;

@end 

@implementation PAQuery

#pragma mark Init + Dealloc
- (id)init
{
	return [self initWithTags:[[PASelectedTags alloc] init]];
}

- (id)initWithTags:(PASelectedTags*)otherTags
{
	if (self = [super init])
	{
		[self setDelegate:self];
	
		mdquery = [[NSMetadataQuery alloc] init];
		[mdquery setDelegate:self];
		[mdquery setNotificationBatchingInterval:0.3];
		
		NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
		[nc addObserver:self
		       selector:@selector(metadataQueryNote:)
			       name:nil
				 object:mdquery];
		
		[self setTags:otherTags];
	}
	return self;
}

- (void)dealloc
{
	if ([self isStarted]) [self stopQuery];	
	if(mdquery) [mdquery release];
	if(bundlingAttributes) [bundlingAttributes release];
	if(predicate) [predicate release];
	[super dealloc];
}

#pragma mark Synchronous Searching
- (NSArray*)filesForTag:(PASimpleTag*)tag
{
	NSString *searchString = [self queryStringForTags:[NSArray arrayWithObjects:tag,nil]];
	MDQueryRef *query = MDQueryCreate(NULL,searchString,NULL,NULL);
	MDQueryExecute(query,kMDQuerySynchronous);
	CFIndex resultCount = MDQueryGetResultCount(query);
	
	NSMutableArray *results = [NSMutableArray array];
	
	for (int i=0;i<resultCount;i++)
	{
		MDItemRef *mditem = MDQueryGetResultAtIndex(query,i);
		NSString *fileName = MDItemCopyAttribute(mditem,@"kMDItemPath");
		[results addObject:fileName];
	}

	return results;
}

#pragma mark Actions
- (BOOL)startQuery
{
	// TODO: Smart caching!
	
	// Finally, post notification
	[[NSNotificationCenter defaultCenter] postNotificationName:PAQueryDidStartGatheringNotification
														object:self];
	return [mdquery startQuery];
}

- (void)stopQuery
{
	// TODO
	
	// Finally, post notification
	[[NSNotificationCenter defaultCenter] postNotificationName:PAQueryDidUpdateNotification
														object:self];
}

- (void)disableUpdates
{
	[mdquery disableUpdates];
}

- (void)enableUpdates
{
	[mdquery enableUpdates];
}

/**
	Synchronizes results of MetadataQuery
*/
- (void)synchronizeResults
{
	if(flatResults) [flatResults release];
	if(results) [results release];
	
	flatResults = [self bundleResults:[mdquery results] byAttributes:nil objectWrapping:YES];
	results = [self bundleResults:[mdquery results] byAttributes:bundlingAttributes objectWrapping:YES];	
	
	/*NSEnumerator *enumerator = [results objectEnumerator];
	id object;
	while(object = [enumerator nextObject])
	{
		NSLog([object stringValue]);
	}*/
}


/**
	Bundles a flat list of results into a hierarchical structure
	defined by the first item of bundlingAttributes
*/
- (NSArray *)bundleResults:(NSArray *)theResults
              byAttributes:(NSArray *)attributes
			objectWrapping:(BOOL)wrapping
{
	NSMutableDictionary *bundleDict = [NSMutableDictionary dictionary];
	
	NSMutableArray *bundledResults = [[NSMutableArray alloc] init];
	
	NSString *bundlingAttribute = nil;
	if(attributes)
	{
		bundlingAttribute = [attributes objectAtIndex:0];
	}

	NSEnumerator *resultsEnumerator = [theResults objectEnumerator];
	//NSMetadataItem *mdItem;
	id theItem;
	while(theItem = [resultsEnumerator nextObject])
	{	
		PAQueryBundle *bundle;
		
		if(bundlingAttribute)
		{
			NSString *bundleValue;
			
			if(wrapping)
			{
				// theItem is a NSMetadataItem
				id valueToBeReplaced = [theItem valueForAttribute:bundlingAttribute];
				bundleValue = [delegate metadataQuery:self
						 replacementValueForAttribute:bundlingAttribute
						                        value:valueToBeReplaced];
			} else {
				// theItem is a PAQueryItem
				bundleValue = [theItem valueForAttribute:bundlingAttribute];
			}
		
			bundle = [bundleDict objectForKey:bundleValue];
			if(!bundle)
			{
				bundle = [[PAQueryBundle alloc] init];
				[bundle setValue:bundleValue];
				[bundle setBundlingAttribute:bundlingAttribute];
				[bundleDict setObject:bundle forKey:bundleValue];
			}			
		}
		
		// TODO: DEFINE MACRO FOR REPLACEMENTVALUEFORATTRIBUTE!
		PAQueryItem *item;
		if(wrapping)
		{
			// Wrap theItem (a NSMetadataItem) into PAQueryItem
			NSMetadataItem *mdItem = theItem;
			id value;
			item = [[PAQueryItem alloc] init];
			[item setValue:[mdItem valueForAttribute:(id)kMDItemDisplayName] forAttribute:@"value"];
			[item setValue:[mdItem valueForAttribute:(id)kMDItemDisplayName] forAttribute:(id)kMDItemDisplayName];
			[item setValue:[mdItem valueForAttribute:(id)kMDItemPath] forAttribute:(id)kMDItemPath];
			[item setValue:[mdItem valueForAttribute:(id)kMDItemContentType] forAttribute:(id)kMDItemContentType];
			
			// AUDIO
			value = [mdItem valueForAttribute:(id)kMDItemAlbum];
			if(value) [item setValue:value forAttribute:(id)kMDItemAlbum];
			value = [delegate metadataQuery:self
			   replacementValueForAttribute:(id)kMDItemAuthors
									  value:[mdItem valueForAttribute:(id)kMDItemAuthors]];
			if(value) [item setValue:value forAttribute:(id)kMDItemAuthors];
			
			value = [delegate metadataQuery:self
			   replacementValueForAttribute:@"kMDItemContentTypeTree"
									  value:[mdItem valueForAttribute:@"kMDItemContentTypeTree"]];
			[item setValue:value forAttribute:@"kMDItemContentTypeTree"];
			// TODO more attributes of item, use replacementValueForAttribute for each value!!
		} else {
			item = theItem;
		}
		
		if(bundlingAttribute)
		{
			[bundle addResultItem:item];
		} else {
			[bundledResults addObject:item];
		}
	}
	
	if(bundlingAttribute)
	{
		NSEnumerator *bundleEnumerator = [bundleDict objectEnumerator];
		PAQueryBundle *bundle;
		while(bundle = [bundleEnumerator nextObject])
		{
			// Bundle at next level if needed
			NSMutableArray *nextBundlingAttributes = [attributes mutableCopy];
			[nextBundlingAttributes removeObjectAtIndex:0];
			
			if([nextBundlingAttributes count] > 0)
			{
				NSArray *subResults = [self bundleResults:[bundle results]
											 byAttributes:nextBundlingAttributes
										   objectWrapping:wrapping];
				[bundle setResults:subResults];
			}
		
			[bundledResults addObject:bundle];
			
			[nextBundlingAttributes release];
		}
	}
	
	return bundledResults;
}

-   (void)filterResults:(BOOL)flag
			usingValues:(NSArray *)filterValues
   forBundlingAttribute:(NSString *)attribute
  newBundlingAttributes:(NSArray *)newAttributes
{	
	if(!flag)
	{
		[filteredResults release];
		filteredResults = nil;
		[flatFilteredResults release];
		flatFilteredResults = nil;
		return;
	}

	[flatFilteredResults release];
	flatFilteredResults = nil;
	flatFilteredResults = [[NSMutableArray alloc] init];

	NSEnumerator *enumerator = [flatResults objectEnumerator];
	PAQueryItem *item;
	while(item = [enumerator nextObject])
	{		
		id valueForAttribute = [item valueForAttribute:attribute];
		
		if([valueForAttribute isKindOfClass:[NSString class]])
		{
			if([filterValues containsObject:valueForAttribute])
			{
				[flatFilteredResults addObject:item];
			}
		} else {
			NSLog(@"couldn't properly filter results");
		}
	}
	
	[filteredResults release];
	filteredResults = nil;
	filteredResults = [self bundleResults:flatFilteredResults byAttributes:newAttributes objectWrapping:NO];
	
	/*NSEnumerator *enume = [filteredResults objectEnumerator];
	PAQueryBundle *b;
	while(b = [enume nextObject])
	{
		NSLog([b value]);
	}*/
}

- (void)updateQueryFromTags
{
	NSMutableString *queryString = [self queryStringForTags:[tags selectedTags]];
	
	if (![queryString isEqualToString:@""])
	{
		[self setPredicate:[NSPredicate predicateWithFormat:queryString]];
	}
	
	if (![self isStarted])
	{
		[self startQuery];
	}
}

- (NSString*)queryStringForTags:(NSArray*)tags
{
	NSMutableString *queryString = [NSMutableString stringWithString:@""];
	
	NSEnumerator *e = [tags objectEnumerator];
	PATag *tag;
	
	if (tag = [e nextObject]) 
	{
		NSString *anotherTagQuery = [NSString stringWithFormat:@"(%@)",[tag query]];
		[queryString appendString:anotherTagQuery];
	}
	
	while (tag = [e nextObject]) 
	{
		NSString *anotherTagQuery = [NSString stringWithFormat:@" && (%@)",[tag query]];
		[queryString appendString:anotherTagQuery];
	}
	
	return queryString;
}


#pragma mark Notifications
/**
	Wrap, process and forward notifications of NSMetadataQuery
*/
- (void)metadataQueryNote:(NSNotification *)note
{
	NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
	
	/*if([[note name] isEqualTo:NSMetadataQueryDidStartGatheringNotification])
	{
		//TODO implement result wrapping
		//[results removeAllObjects];
		[nc postNotificationName:PAQueryDidStartGatheringNotification object:self];
	}
	
	if([[note name] isEqualTo:NSMetadataQueryGatheringProgressNotification])
	{
		[self synchronizeResults];
		[nc postNotificationName:PAQueryGatheringProgressNotification object:self];
	}
		
	if([[note name] isEqualTo:NSMetadataQueryDidUpdateNotification])
	{
		[self synchronizeResults];
		[nc postNotificationName:PAQueryDidUpdateNotification object:self];
	}*/
		
	if([[note name] isEqualTo:NSMetadataQueryDidFinishGatheringNotification])
	{
		[self synchronizeResults];
		[nc postNotificationName:PAQueryDidFinishGatheringNotification object:self];
	}
}

#pragma mark Accessors
- (id)delegate
{
	return delegate;
}

- (void)setDelegate:(id)aDelegate
{
	delegate = aDelegate;
}

- (NSPredicate *)predicate
{
	return predicate;
}

- (void)setPredicate:(NSPredicate *)aPredicate
{
	predicate = aPredicate;
	[mdquery setPredicate:aPredicate];
}

- (NSArray *)bundlingAttributes
{
	return bundlingAttributes;
}

- (void)setBundlingAttributes:(NSArray *)attributes
{
	if(bundlingAttributes) [bundlingAttributes release];
	bundlingAttributes = [attributes retain];
	
	// Post notification
	//[[NSNotificationCenter defaultCenter] postNotificationName:PAQueryGroupingAttributesDidChange
	//													object:self];
}

- (NSArray *)sortDescriptors
{
	return [mdquery sortDescriptors];
}


- (void)setSortDescriptors:(NSArray *)descriptors
{
	[mdquery setSortDescriptors:descriptors];
}

- (PASelectedTags*)tags
{
	return tags;
}

- (void)setTags:(PASelectedTags*)otherTags
{
	[otherTags retain];
	[tags release];
	tags = otherTags;
	
	[self updateQueryFromTags];
}

- (BOOL)isStarted
{
	return [mdquery isStarted];
}

- (BOOL)isGathering
{
	return [mdquery isGathering];
}

- (BOOL)isStopped
{
	return [mdquery isStopped];
}

- (unsigned)resultCount
{
	return filteredResults ? [filteredResults count] : [results count];
}

- (id)resultAtIndex:(unsigned)index
{
	return filteredResults ? [filteredResults objectAtIndex:index] : [results objectAtIndex:index];
}

- (NSArray *)results
{
	return filteredResults ? filteredResults : results;
}

- (NSArray *)flatResults
{
	return flatFilteredResults ? flatFilteredResults : flatResults;
}


@end
