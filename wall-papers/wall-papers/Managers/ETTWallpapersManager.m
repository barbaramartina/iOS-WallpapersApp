//
//  ETTWallpapersManager.m
//  wall-papers
//
//  Created by Barbara Rodeker on 1/14/14.
//
//  Licensed to the Apache Software Foundation (ASF) under one
//  or more contributor license agreements.  See the NOTICE file
//  distributed with this work for additional information
//  regarding copyright ownership.  The ASF licenses this file
//  to you under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance
//  with the License.  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing,
//  software distributed under the License is distributed on an
//  "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
//  KIND, either express or implied.  See the License for the
//  specific language governing permissions and limitations
//  under the License.
//

#import "ETTWallpapersManager.h"
#import "ETTWallpaper.h"

#pragma mark static variables

static ETTWallpapersManager *_instance = nil;
static NSString *const kWallpapersPlist = @"wallpapers";

#pragma mark ------

@interface ETTWallpapersManager()

@property (nonatomic, strong) NSArray *appWallpapers;

@end

#pragma mark ------

@implementation ETTWallpapersManager

+ (ETTWallpapersManager *)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[[self class] alloc] init];
    });
    return _instance;
}

- (id)init {
    if ((self = [super init])) {
        [self loadWallpapers];
    }
    NSAssert(self != nil, @"Error initializing self");
    return self;
}

- (NSArray *)wallpapers {
    NSAssert(_appWallpapers, @"Wallpapers have not been loaded");
    return self.appWallpapers;
}

- (NSArray *)wallpapersWithName:(NSString *)name {
    NSArray *filteredArray = [self.appWallpapers filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"name contains[c] %@",name]];
    return filteredArray;
}

- (NSArray *)wallpapersForCategoryWithName:(NSString *)categoryName {
    NSArray *filteredArray = [self.appWallpapers filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        NSArray *matchCategory = [((ETTWallpaper *)evaluatedObject).categories filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF contains[c] %@",categoryName]];
        
        return ( [matchCategory count] > 0 );
    }]];
    return filteredArray;
}

- (NSArray *)wallpapersForTagWithName:(NSString *)tagName {
    NSArray *filteredArray = [self.appWallpapers filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        NSArray *matchCategory = [((ETTWallpaper *)evaluatedObject).tags filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF contains[c] %@",tagName]];
        
        return ( [matchCategory count] > 0 );
    }]];
    return filteredArray;
}

#pragma mark Private

- (void)loadWallpapers {
    NSString *wallpapersPath = [[NSBundle mainBundle] pathForResource:kWallpapersPlist ofType:@"plist"];
    NSArray *wallpapersData = [NSArray arrayWithContentsOfFile:wallpapersPath];
    NSMutableArray *wallpapersMutable = [NSMutableArray arrayWithCapacity:[wallpapersData count]];
    
    for (NSDictionary *data in wallpapersData) {
        ETTWallpaper *wallpaper = [[ETTWallpaper alloc] initWithDictionary:data];
        [wallpapersMutable addObject:wallpaper];
    }
    
    self.appWallpapers = [NSArray arrayWithArray:wallpapersMutable];
}

@end
