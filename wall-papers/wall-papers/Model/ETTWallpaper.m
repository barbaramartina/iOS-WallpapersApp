//
//  ETTWallpaper.m
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

#import "ETTWallpaper.h"

@interface ETTWallpaper()

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, strong) NSString *imageType;
@property (nonatomic, strong) NSArray *categories;
@property (nonatomic, strong) NSArray *tags;
@property (nonatomic, strong) UIImage *image;

@end

@implementation ETTWallpaper

- (id)initWithDictionary:(NSDictionary *)values {
    if ((self = [super init])) {
        self.name = [values objectForKey:@"name"];
        self.imageName = [values objectForKey:@"image-name"];
        self.imageType = [values objectForKey:@"image-type"];
        self.tags = [values objectForKey:@"categories"];
        self.categories = [values objectForKey:@"search-tags"];
        
        [self loadImage];
    }
    return self;
}

- (void)loadImage {
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:self.imageName ofType:self.imageType];
    self.image = [UIImage imageWithContentsOfFile:imagePath];
}

@end
