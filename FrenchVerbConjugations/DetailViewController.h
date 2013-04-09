//
//  DetailViewController.h
//  FrenchVerbConjugations
//
//  Created by Sean Coetzee on 2013/03/14.
//  Copyright (c) 2013 Epinion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) NSDictionary *verbList;
@property (strong, nonatomic) NSArray *verbListKeys;
@property (nonatomic) NSInteger currentIndex;

- (IBAction)nextWord:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *labelConjugations;
@property (weak, nonatomic) IBOutlet UILabel *labelTranslation;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end
