//
//  ETTTagsManager.m
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

#import "ETTTagsManager.h"

#pragma mark static variables

static ETTTagsManager *_instance = nil;
static NSString *const kTagsPlist = @"categories";

#pragma mark ------

@interface ETTTagsManager()

@property (nonatomic, strong) NSArray *tags;

@end

#pragma mark ------

@implementation ETTTagsManager

+ (ETTTagsManager *)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[[self class] alloc] init];
    });
    return _instance;
}

- (id)init {
    if ((self = [super init])) {
        [self loadTags];
    }
    return self;
}

- (NSArray *)tags {
    return self.tags;
}

#pragma mark Private

- (void)loadTags{
    NSString *tagsPath = [[NSBundle mainBundle] pathForResource:kTagsPlist ofType:@"plist"];
    self.tags = [NSArray arrayWithContentsOfFile:tagsPath];
}

@end
