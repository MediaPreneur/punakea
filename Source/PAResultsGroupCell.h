//
//  PAResultsGroupCell.h
//  punakea
//
//  Created by Daniel on 05.04.06.
//  Copyright 2006 nudge:nudge. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NNTagging/PAQueryBundle.h"

#import "PAImageButton.h"
#import "PASegmentedImageControl.h"
#import "PAResultsOutlineView.h"


@interface PAResultsGroupCell : NSTextFieldCell {

	PAImageButton				*triangle;
	PASegmentedImageControl		*segmentedControl;
	
	PAQueryBundle				*bundle;
	
	BOOL						hasMultipleDisplayModes;

}

- (NSString *)naturalLanguageGroupValue;
- (BOOL)hasMultipleDisplayModes;

@end
