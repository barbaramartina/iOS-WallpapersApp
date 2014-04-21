//
//  ETTDetailViewController.m
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

#import "ETTDetailViewController.h"

#import "ETTWallpaper.h"

#pragma mark ------

@interface ETTDetailViewController ()

@property (strong, nonatomic) UIPopoverController *masterPopoverController;

- (void)configureView;

@end

#pragma mark ------

@implementation ETTDetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;

        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView {
    if ([self.detailItem class]  == [ETTWallpaper class]) {
        ETTWallpaper *wp = (ETTWallpaper *)self.detailItem;
        self.detailDescriptionLabel.text = wp.name;
        self.detailImage.image = wp.image;
        self.detailView.hidden = NO;
        self.exploreView.hidden = YES;
    } else {
        self.detailView.hidden = YES;
        self.exploreView.hidden = NO;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureView];
    
    self.save.layer.borderWidth = 0.7;
    self.save.layer.cornerRadius = 4.0f;
    self.save.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    [self.navigationController.navigationBar setTintColor:[UIColor grayColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Georgia"
                                                                                                          size:14.0f],
                                                                      NSForegroundColorAttributeName:[UIColor grayColor]}];
    
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Choose another", @"Choose");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

@end
