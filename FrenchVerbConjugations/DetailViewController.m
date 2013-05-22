//
//  DetailViewController.m
//  FrenchVerbConjugations
//
//  Created by Sean Coetzee on 2013/03/14.
//  Copyright (c) 2013 Blacklemon. All rights reserved.
//

#import "DetailViewController.h"
#import "WordCell.h"

@interface DetailViewController ()
@end

@implementation DetailViewController

@synthesize verbList;
@synthesize verbListKeys;


#pragma mark - Managing the detail item

- (void)setVerbList:(NSDictionary*)newVerbList {
    if (verbList != newVerbList) {
        verbList = newVerbList;
        verbListKeys = [self shuffle:[newVerbList allKeys]];
    
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.collectionView registerClass:[WordCell class] forCellWithReuseIdentifier:@"Cell"];
}

- (void) loadView
{
    self.view = [[UIView alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Create a flow layout for the collection view that scrolls
    // horizontally and has no space between items
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fr_bg.png"]];
    self.imageView.frame = self.view.frame;
    self.imageView.alpha = 0.2;
    [self.view addSubview:self.imageView];
    
    // Set up the collection view with no scrollbars, paging enabled
    // and the delegate and data source set to this view controller
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:flowLayout];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.collectionView];

    CGFloat w = self.view.frame.size.width;
    CGFloat h = self.view.frame.size.height;
    
    CGRect frame = CGRectMake(0, h - 120, w, 120);
    self.pageControl = [[UIPageControl alloc] initWithFrame:frame];
    self.pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    self.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    
    // Add a target that will be invoked when the page control is
    // changed by tapping on it
    [self.pageControl addTarget:self action:@selector(pageControlChanged:) forControlEvents:UIControlEventValueChanged];
    
    // Set the number of pages to the number of pages in the paged interface
    // and let the height flex so that it sits nicely in its frame
    self.pageControl.numberOfPages = 3;
    self.pageControl.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.pageControl];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = self.collectionView.frame.size.width;
    int currentPage = self.collectionView.contentOffset.x / pageWidth;
    if(currentPage == verbListKeys.count - 1) {
        self.pageControl.currentPage = 2;
    }
    else if(currentPage == 0) {
        self.pageControl.currentPage = 0;
    }
    else {
        self.pageControl.currentPage = 1;
    }
}

- (void)pageControlChanged:(id)sender
{
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)shuffle:(NSArray *)input
{
    NSMutableArray *keys = [[NSMutableArray alloc] initWithArray:input];
    
    for (int i=0; i<keys.count; i++) {
        int e = keys.count - i;
        int n = (random() % e) + i;
        
        [keys exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
    
    return keys;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return verbListKeys.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // Dequeue a prototype cell and set the label to indicate the page
    NSString *key = [verbListKeys objectAtIndex:indexPath.row];
    WordCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSArray *p = [[verbList objectForKey:key] componentsSeparatedByString:@"|"];
    
    cell.labelWord.text = key;
    cell.labelTranslation.text = [[p objectAtIndex:0] stringByReplacingOccurrencesOfString:@"~" withString:@"\n"];
    
    cell.labelDetails.text = @"";
    if(p.count > 1) {
        cell.labelDetails.text = [[p objectAtIndex:1] stringByReplacingOccurrencesOfString:@"~" withString:@"\n"];
    }
    
    cell.labelDetailTranslation.text = @"";
    if(p.count > 2) {
        cell.labelDetailTranslation.text = [[p objectAtIndex:2] stringByReplacingOccurrencesOfString:@"~" withString:@"\n"];
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return collectionView.bounds.size;
}

@end
