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
static NSString *_dateCellRightSideIdentifier = @"DATE_RIGHT_SIDE_CELL";

static NSString *_numberCellllIdentifier = @"NUMBER_CELL";








@interface ViewController () {
    
    
   
}
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet TimelineCollectionViewLayout *layout;
@property (strong, nonatomic) NSMutableArray *items;


//Action Methods
-(IBAction)onAddBtn:(id)sender;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"Timeline";
    
    self.items = [NSMutableArray arrayWithObjects:@"AAA", nil];

    UIBarButtonItem *addBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(onAddBtn:)];
    addBarItem.tintColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem = addBarItem;
    
//    self.collectionView.pagingEnabled = YES;
    self.collectionView.backgroundColor = mzcolor(239, 237, 237, 1.0f);

    
    [self.collectionView registerClass:[TimelineCollectionViewCell class] forCellWithReuseIdentifier:_timelineCellIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([TimelineCollectionViewCell class]) bundle:[NSBundle mainBundle]]
          forCellWithReuseIdentifier:_timelineCellIdentifier];

    
    [self.collectionView registerClass:[DateCollectionViewCell class] forCellWithReuseIdentifier:_dateCellIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([DateCollectionViewCell class]) bundle:[NSBundle mainBundle]]
          forCellWithReuseIdentifier:_dateCellIdentifier];
    
//    [self.collectionView registerClass:[DateRightSideCollectionViewCell class] forCellWithReuseIdentifier:_dateCellRightSideIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:@"DateCollectionViewCell-RightSide" bundle:[NSBundle mainBundle]]
          forCellWithReuseIdentifier:_dateCellRightSideIdentifier];
    
    
    [self.collectionView registerClass:[NumberCollectionViewCell class] forCellWithReuseIdentifier:_numberCellllIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([NumberCollectionViewCell class]) bundle:[NSBundle mainBundle]]
          forCellWithReuseIdentifier:_numberCellllIdentifier];
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
    
    return self.items.count*3;//must mutiple by 3(3 items in each row), for example 15 days, there must be 45 items in total
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
        
            dateCell.typeSwitch = YES;
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
            cell = (DateCollectionViewCell *)[self.collectionView dequeueReusableCellWithReuseIdentifier:_dateCellRightSideIdentifier forIndexPath:indexPath];
            
            
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
            
            dateCell.typeSwitch = NO;
            
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


#pragma mark - Action Methods
-(IBAction)onAddBtn:(id)sender{
    
    //    [self.collectionView reloadData];NSInteger section = [self numberOfSectionsInCollectionView:collectionView] - 1;
    
    
    NSIndexPath *indexPath0 = [NSIndexPath indexPathForItem:self.items.count*3 inSection:0];
    NSIndexPath *indexPath1 = [NSIndexPath indexPathForItem:1+self.items.count*3  inSection:0];
    NSIndexPath *indexPath2 = [NSIndexPath indexPathForItem:2+self.items.count*3 inSection:0];
    
    [self.items addObject:@"aaa"];
    self.collectionView.contentSize = CGSizeMake(self.collectionView.contentSize.width,
                                                 self.collectionView.contentSize.height+(self.layout.itemSize.height*0.5));
    
//    CGRect targetRect = CGRectMake(0,  self.collectionView.contentSize.height, 100, 10);
//    
//    [self.collectionView scrollRectToVisible:targetRect animated:YES];
    
//    CGPoint bottomOffset = CGPointMake(0, self.collectionView.contentSize.height-self.collectionView.bounds.size.height);
//    [self.collectionView setContentOffset:bottomOffset animated:NO];
    
    
     [self.collectionView insertItemsAtIndexPaths:@[indexPath0, indexPath1, indexPath2]];
    
    
    NSInteger item = [self collectionView:self.collectionView numberOfItemsInSection:0] - 1;
    NSIndexPath *lastIndexPath = [NSIndexPath indexPathForItem:item inSection:0];
    [self.collectionView scrollToItemAtIndexPath:lastIndexPath atScrollPosition:UICollectionViewScrollPositionBottom animated:YES];
}


@end
