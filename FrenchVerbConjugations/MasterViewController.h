//
//  MasterViewController.h
//  FrenchVerbConjugations
//
//  Created by Sean Coetzee on 2013/03/14.
//  Copyright (c) 2013 Blacklemon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MasterViewController : UITableViewController

-(NSDictionary *)searchAllValues:(NSString *)search;

@property (strong, nonatomic) NSDictionary *sections;
@property (strong, nonatomic) NSArray *sectionKeys;

@property (strong, nonatomic) NSMutableDictionary *allValues;
@property (strong, nonatomic) NSArray *allKeys;

@end
