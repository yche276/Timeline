//
//  ViewController.m
//
//
//  Created by Victor Chen on 5/9/15.
//  Copyright (c) 2015 Mt Zendo Inc. All rights reserved.
//

#import "ViewController.h"

#import "DateCollectionViewCell.h"
#import "TimelineCollectionViewCell.h"
#import "NumberCollectionViewCell.h"

#import "TimelineCollectionViewLayout.h"
#import "DigitalMt.h"


static NSString *_timelineCellIdentifier = @"TIMELINE_CELL";
static NSString *_dateCellIdentifier = @"DATE_CELL";
static NSString *_numberCellllIdentifier = @"NUMBER_CELL";
@interface ViewController () {
   
}
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet TimelineCollectionViewLayout *layout;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    self.collectionView.pagingEnabled = YES;
    self.collectionView.backgroundColor = mzcolor(239, 237, 237, 1.0f);

    
    [self.collectionView registerClass:[TimelineCollectionViewCell class] forCellWithReuseIdentifier:_timelineCellIdentifier];
    [self.collectionView registerClass:[DateCollectionViewCell class] forCellWithReuseIdentifier:_dateCellIdentifier];
    [self.collectionView registerClass:[NumberCollectionViewCell class] forCellWithReuseIdentifier:_numberCellllIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Prepare for Segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
 
}
 */

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 15*3;//must mutiple by 3(3 items in each row), for example 15 days, there must be 45 items in total
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger row = indexPath.row/self.layout.numberOfColumns;
    NSInteger column = indexPath.row%self.layout.numberOfColumns;
    
    //NO for date type, YES for timeline tile
    UICollectionViewCell *cell = nil;
    
    if(row%2 == 0){// date--number--timeline_object
        if (column == 2) {
            cell = (TimelineCollectionViewCell *)[self.collectionView dequeueReusableCellWithReuseIdentifier:_timelineCellIdentifier forIndexPath:indexPath];
            TimelineCollectionViewCell *timelineCell = (TimelineCollectionViewCell *)cell;
            timelineCell.textLabel.textColor = mzcolor(52, 49, 52, 1.0f);
            [timelineCell.profilePhotoView setProfilePhoto:[UIImage imageNamed:@"Bear"]];
        
        }
        else if (column == 1) {//number
            cell = (NumberCollectionViewCell *)[self.collectionView dequeueReusableCellWithReuseIdentifier:_numberCellllIdentifier forIndexPath:indexPath];
            cell.backgroundColor = [UIColor clearColor];
            
            NumberCollectionViewCell *numberCell = (NumberCollectionViewCell *) cell;
            numberCell.numView.titleLabel.text = [NSString stringWithFormat:@"%ld", row+1];
            
            
        }
        else if (column == 0) {
            cell = (DateCollectionViewCell *)[self.collectionView dequeueReusableCellWithReuseIdentifier:_dateCellIdentifier forIndexPath:indexPath];
        
        
            NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setLocale:usLocale];
            [formatter setDateStyle:NSDateFormatterFullStyle];
        
            NSDate *dt = [NSDate dateWithTimeInterval:row*24*60*60 sinceDate:[NSDate date]];
            DateCollectionViewCell *dateCell = (DateCollectionViewCell *)cell;
        
    
            [formatter setDateFormat:@"EE"];
            dateCell.weekdayLabel.text = [formatter stringFromDate:dt];
            dateCell.weekdayLabel.textColor = mzcolor(214, 206, 207, 1.0f);
            [formatter setDateFormat:@"MMM"];
            dateCell.monthLabel.text = [formatter stringFromDate:dt];
            dateCell.monthLabel.textColor = mzcolor(214, 206, 207, 1.0f);
        
            [formatter setDateFormat:@"dd"];
            dateCell.dayLabel.text = [NSString stringWithFormat:@"%@    ", [formatter stringFromDate:dt]];
            //[formatter stringFromDate:dt];
            dateCell.dayLabel.textColor = mzcolor(52, 49, 52, 1.0f);
        
            dateCell.backgroundColor = [UIColor clearColor];
        
        }
    }
    else {// timeline_object--number--date
        if (column == 0) {
            cell = (TimelineCollectionViewCell *)[self.collectionView dequeueReusableCellWithReuseIdentifier:_timelineCellIdentifier forIndexPath:indexPath];
            TimelineCollectionViewCell *timelineCell = (TimelineCollectionViewCell *)cell;
            timelineCell.textLabel.textColor = mzcolor(52, 49, 52, 1.0f);
            [timelineCell.profilePhotoView setProfilePhoto:[UIImage imageNamed:@"Bear"]];
            
        }
        else if (column == 1) {//number
            cell = (NumberCollectionViewCell *)[self.collectionView dequeueReusableCellWithReuseIdentifier:_numberCellllIdentifier forIndexPath:indexPath];
            cell.backgroundColor = [UIColor clearColor];
            NumberCollectionViewCell *numberCell = (NumberCollectionViewCell *) cell;
            numberCell.numView.titleLabel.text = [NSString stringWithFormat:@"%ld", row+1];
        }
        else if (column == 2) {
            cell = (DateCollectionViewCell *)[self.collectionView dequeueReusableCellWithReuseIdentifier:_dateCellIdentifier forIndexPath:indexPath];
            
            
            NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setLocale:usLocale];
            [formatter setDateStyle:NSDateFormatterFullStyle];
            
            NSDate *dt = [NSDate dateWithTimeInterval:row*24*60*60 sinceDate:[NSDate date]];
            DateCollectionViewCell *dateCell = (DateCollectionViewCell *)cell;
            
            
            [formatter setDateFormat:@"EE"];
            dateCell.weekdayLabel.text = [formatter stringFromDate:dt];
            dateCell.weekdayLabel.textColor = mzcolor(214, 206, 207, 1.0f);
            [formatter setDateFormat:@"MMM"];
            dateCell.monthLabel.text = [formatter stringFromDate:dt];
            dateCell.monthLabel.textColor = mzcolor(214, 206, 207, 1.0f);
            
            [formatter setDateFormat:@"dd"];
            dateCell.dayLabel.text = [NSString stringWithFormat:@"%@    ", [formatter stringFromDate:dt]];
            //[formatter stringFromDate:dt];
            dateCell.dayLabel.textColor = mzcolor(52, 49, 52, 1.0f);
            
            dateCell.backgroundColor = [UIColor clearColor];
            
        }
    }
    
    return cell;
    
}

#pragma mark - UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row/self.layout.numberOfColumns;
    NSLog(@"clicked on Row:%ld", (long)row);
}



@end
