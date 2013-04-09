//
//  MasterViewController.m
//  FrenchVerbConjugations
//
//  Created by Sean Coetzee on 2013/03/14.
//  Copyright (c) 2013 Epinion. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"

#import "SearchViewController.h"

@implementation MasterViewController

@synthesize sectionKeys;
@synthesize sections;
@synthesize allValues;
@synthesize allKeys;

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *file = [[NSBundle mainBundle] pathForResource:@"sections" ofType:@"plist"];
    NSDictionary *sectionFile = [[NSDictionary alloc] initWithContentsOfFile: file];
    sectionKeys = [[sectionFile allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    NSMutableDictionary *mutD = [[NSMutableDictionary alloc] initWithCapacity:sectionKeys.count];
    allValues = [[NSMutableDictionary alloc] init];
    
    for (NSString *k in sectionKeys) {
        file = [[NSBundle mainBundle] pathForResource:[sectionFile objectForKey:k] ofType:@"plist"];
        NSDictionary *v = [[NSDictionary alloc] initWithContentsOfFile:file];
        [mutD addEntriesFromDictionary:[[NSDictionary alloc] initWithObjectsAndKeys:v, k, nil]];
        NSArray *keys = [v allKeys];
        [allValues addEntriesFromDictionary:[self loadValuesUsingKeys:keys withValues:v row:-1]];
    }
    sections = mutD;
    allKeys = [[allValues allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    
    NSLog(@"%i", allValues.count);
        
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(search:)];
    self.navigationItem.rightBarButtonItem = searchButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)search:(id)sender
{
    [self performSegueWithIdentifier: @"search" sender: self];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return sectionKeys.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [sectionKeys objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *key = [sectionKeys objectAtIndex:section];
    return [[sections objectForKey:key] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSString *key = [sectionKeys objectAtIndex:indexPath.section];
    NSArray *keys = [[[sections objectForKey:key] allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    cell.textLabel.text = [keys objectAtIndex:indexPath.row];
    
    return cell;
}

- (NSDictionary *)loadValuesForSegueUsingKeys:(NSArray *)keys withValues:(NSDictionary *)values {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    return [self loadValuesUsingKeys:keys withValues:values row:indexPath.row];
}

- (NSDictionary *)loadValuesUsingKeys:(NSArray *)keys withValues:(NSDictionary *)values row:(NSInteger)row {
    NSString *currentKey = @"All";
    if(row >= 0) {
        currentKey = [keys objectAtIndex:row];
    }
    
    NSDictionary *ret = nil;
    if ([@"*" isEqualToString:[values objectForKey:currentKey]]) {
        NSMutableDictionary *m = [[NSMutableDictionary alloc] init];
        for (int i = 0; i < keys.count; i++) {
            NSString *fn = [values objectForKey:[keys objectAtIndex:i]];
            if(![fn isEqualToString:@"*"]) {
                [m addEntriesFromDictionary:[self loadFile:fn]];
            }
        }
        ret = m;
    }
    else {
        ret = [self loadFile:[values objectForKey:currentKey]];
    }
    
    return ret;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSString *sectionKey = [sectionKeys objectAtIndex:indexPath.section];
        NSDictionary *values = [sections objectForKey:sectionKey];
        NSArray *keys = [[values allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
        NSDictionary *v = [self loadValuesUsingKeys:keys withValues:values row:indexPath.row];
        
        [[segue destinationViewController] setVerbList:v];
    }
    
    if ([[segue identifier] isEqualToString:@"search"]) {
        SearchViewController *c = [segue destinationViewController];
        c.masterController = self;
    }
}

- (NSDictionary *)loadFile:(NSString *)fileName
{
    NSString *file = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
    return [[NSDictionary alloc] initWithContentsOfFile:file];
}

- (NSDictionary *)searchAllValues:(NSString *)search
{
    NSMutableDictionary *ret = [[NSMutableDictionary alloc] init];
    
    for (NSString *k in allKeys) {
        NSString *v = [allValues objectForKey:k];
        if ([k rangeOfString:search].location != NSNotFound || [v rangeOfString:search].location != NSNotFound) {
            [ret setObject:v forKey:k];
        }
    }
    
    return ret;
}

@end
