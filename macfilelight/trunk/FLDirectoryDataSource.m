/* Copyright (C) 1996 Dave Vasilevsky
 * This file is licensed under the GNU General Public License,
 * see the file Copying.txt for details. */

#import "FLDirectoryDataSource.h"

@implementation FLDirectoryDataSource

- (id) init
{
    if (self = [super init]) {
        m_rootDir = nil;
    }    
    return self;
}

- (NSString *) rootPath
{
    return [m_rootDir path];
}

- (void) setRootPath: (NSString *) path
{
    if (m_rootDir) {
        [m_rootDir release];
    }
    m_rootDir = [[FLDirectory alloc] initWithPath: path];
}

- (FLFile *) realItemFor: (id)item
{
    return item ? item : m_rootDir;
}

- (id) target: (id)target child: (int)index ofItem: (id)item
{
    FLFile *file = [self realItemFor: item];
    return [[(FLDirectory *)file children] objectAtIndex: index];
}

- (int) target: (id)target numberOfChildrenOfItem: (id)item
{
    FLFile *file = [self realItemFor: item];
    return [file respondsToSelector: @selector(children)]
        ? [[(FLDirectory *)file children] count]
        : 0;
}

- (float) target: (id)target weightOfItem: (id)item
{
    FLFile *file = [self realItemFor: item];
    return (float)[file size];
}

@end
