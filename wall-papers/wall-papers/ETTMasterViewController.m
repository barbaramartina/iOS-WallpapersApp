//
//  ETTMasterViewController.m
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

#import "ETTMasterViewController.h"

#import "ETTDetailViewController.h"
#import "ETTWallpapersManager.h"
#import "ETTWallpaper.h"

#pragma mark ------

@interface ETTMasterViewController()

@property (nonatomic, strong) NSArray *wallpapers;
@property (nonatomic, strong) NSArray *searchOptions;
@property (nonatomic, strong) NSArray *sections;

@end

#pragma mark ------


@implementation ETTMasterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.detailViewController = (ETTDetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    self.wallpapers = [ETTWallpapersManager sharedInstance].wallpapers;
    self.searchOptions = @[@"Explore by Category",@"Explore by Tag"];
    self.sections = @[self.searchOptions,self.wallpapers];
    
    [self.navigationController.navigationBar setTintColor:[UIColor grayColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Georgia"
                                                                                                          size:14.0f],
                                                                      NSForegroundColorAttributeName:[UIColor grayColor]}];
    
    self.tableView.backgroundColor = [UIColor grayColor];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.sections[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor grayColor];

    if (indexPath.section == 1) {
        ETTWallpaper *wp = self.wallpapers[indexPath.row];
        cell.textLabel.text = wp.name;
    } else {
        cell.textLabel.text = self.sections[0][indexPath.row];
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0)
        return @"Explore";
    return @"Wallpapers";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    id object = self.sections[indexPath.section][indexPath.row];
    self.detailViewController.detailItem = object;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        id object = self.sections[indexPath.section][indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

@end
