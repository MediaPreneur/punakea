// Copyright 2003-2005 Omni Development, Inc.  All rights reserved.
//
// This software may only be used and reproduced according to the
// terms in the file OmniSourceLicense.html, which should be
// distributed with this project and can also be found at
// <http://www.omnigroup.com/developer/sourcecode/sourcelicense/>.
//
// $Header: svn+ssh://source.omnigroup.com/Source/svn/Omni/tags/SourceRelease_2005-11-18/OmniGroup/Frameworks/OmniAppKit/ColorSync/NSImage-ColorSyncExtensions.h 68913 2005-10-03 19:36:19Z kc $

#import <AppKit/NSImage.h>

@class OAColorProfile;

@interface NSImage (ColorSyncExtensions)

- (BOOL)containsProfile;
- (void)convertFromProfile:(OAColorProfile *)inProfile toProfile:(OAColorProfile *)outProfile;

@end
