// Copyright 2000-2005 Omni Development, Inc.  All rights reserved.
//
// This software may only be used and reproduced according to the
// terms in the file OmniSourceLicense.html, which should be
// distributed with this project and can also be found at
// <http://www.omnigroup.com/developer/sourcecode/sourcelicense/>.
//
// $Header: svn+ssh://source.omnigroup.com/Source/svn/Omni/tags/SourceRelease_2005-11-18/OmniGroup/Frameworks/OmniAppKit/Widgets.subproj/OASplitView.h 68913 2005-10-03 19:36:19Z kc $

#import <AppKit/NSSplitView.h>

@interface OASplitView : NSSplitView
{
    NSString *positionAutosaveName;
}

- (void)setPositionAutosaveName:(NSString *)name;
- (NSString *)positionAutosaveName;

@end


@interface NSObject (OASplitViewExtendedDelegate)
- (void)splitViewDoubleClick:(OASplitView *)sender; // Called when the divider is double-clicked.
@end
