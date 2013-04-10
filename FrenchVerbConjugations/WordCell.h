//
//  WordCell.h
//  FrenchVerbConjugations
//
//  Created by Sean Coetzee on 2013/04/09.
//  Copyright (c) 2013 Epinion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WordCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UILabel *labelWord;
@property (strong, nonatomic) IBOutlet UILabel *labelTranslation;
@property (strong, nonatomic) IBOutlet UILabel *labelDetails;

@end
