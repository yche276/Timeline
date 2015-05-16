//
//  DetailViewController.m
//  Timeline
//
//  Created by VIctor Chen on 5/14/15.
//  Copyright (c) 2015 Mt Zendo Inc. All rights reserved.
//

#import "DetailViewController.h"

#define kColorValues                                    @"values"
static NSString *_cellIdentifier = @"CELL";

#import "TripDetailCollectionViewCell.h"
#import "TopMomentsCollectionViewCell.h"
#import "PhotoCollectionViewCell.h"
#import "ToDoCollectionViewCell.h"
#import "PlacesCollectionViewCell.h"
#import "WeatherCollectionViewCell.h"
#import "MapCollectionViewCell.h"
#import "NoteCollectionViewCell.h"

//#define kColorValues                                    @"values"
//static NSString *_cellIdentifier = @"CELL";

static NSString *_tripDetailCellIdentifier = @"TRIPDETAIL_CELL";
static NSString *_topMomentsCellIdentifier = @"TOPMOMENTS_CELL";
static NSString *_photoCellIdentifier = @"PHOTO_CELL";
static NSString *_todoCellIdentifier = @"TODO_CELL";
static NSString *_placesCellIdentifier = @"PLACES_CELL";
static NSString *_weatherCellIdentifier = @"WEATHER_CELL";
static NSString *_mapCellIdentifier = @"MAP_CELL";
static NSString *_noteCellIdentifier = @"NOTE_CELL";


@interface DetailViewController () {
    NSIndexPath *_currentVisibleItem;
}

@end

@implementation DetailViewController

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
    NSArray* currentVisibleItems = self.collectionView.indexPathsForVisibleItems;
    _currentVisibleItem = [currentVisibleItems objectAtIndex:0];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    
    [self.collectionView.collectionViewLayout invalidateLayout];
    //    [self.collectionView reloadData];
    [self.collectionView scrollToItemAtIndexPath:_currentVisibleItem atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Detail";
    
//    self.collectionView.backgroundColor = [UIColor clearColor];
//    
//    [self.collectionView registerClass:[TripDetailCollectionViewCell class] forCellWithReuseIdentifier:_tripDetailCellIdentifier];
//    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([TripDetailCollectionViewCell class]) bundle:[NSBundle mainBundle]]
//          forCellWithReuseIdentifier:_tripDetailCellIdentifier];
    
    
    self.collectionView.backgroundColor = [UIColor clearColor];
    
    [self.collectionView registerClass:[TripDetailCollectionViewCell class] forCellWithReuseIdentifier:_tripDetailCellIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([TripDetailCollectionViewCell class]) bundle:[NSBundle mainBundle]]
          forCellWithReuseIdentifier:_tripDetailCellIdentifier];
    
    [self.collectionView registerClass:[TopMomentsCollectionViewCell class] forCellWithReuseIdentifier:_topMomentsCellIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([TopMomentsCollectionViewCell class]) bundle:[NSBundle mainBundle]]
          forCellWithReuseIdentifier:_topMomentsCellIdentifier];
    
    [self.collectionView registerClass:[PhotoCollectionViewCell class] forCellWithReuseIdentifier:_photoCellIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([PhotoCollectionViewCell class]) bundle:[NSBundle mainBundle]]
          forCellWithReuseIdentifier:_photoCellIdentifier];
    
    [self.collectionView registerClass:[ToDoCollectionViewCell class] forCellWithReuseIdentifier:_todoCellIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ToDoCollectionViewCell class]) bundle:[NSBundle mainBundle]]
          forCellWithReuseIdentifier:_todoCellIdentifier];
    
    [self.collectionView registerClass:[PlacesCollectionViewCell class] forCellWithReuseIdentifier:_placesCellIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([PlacesCollectionViewCell class]) bundle:[NSBundle mainBundle]]
          forCellWithReuseIdentifier:_placesCellIdentifier];
    
    [self.collectionView registerClass:[WeatherCollectionViewCell class] forCellWithReuseIdentifier:_weatherCellIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([WeatherCollectionViewCell class]) bundle:[NSBundle mainBundle]]
          forCellWithReuseIdentifier:_weatherCellIdentifier];
    
    [self.collectionView registerClass:[MapCollectionViewCell class] forCellWithReuseIdentifier:_mapCellIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MapCollectionViewCell class]) bundle:[NSBundle mainBundle]]
          forCellWithReuseIdentifier:_mapCellIdentifier];
    
    [self.collectionView registerClass:[NoteCollectionViewCell class] forCellWithReuseIdentifier:_noteCellIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([NoteCollectionViewCell class]) bundle:[NSBundle mainBundle]]
          forCellWithReuseIdentifier:_noteCellIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger items = 1;
    switch (section) {
        case 1://top mements, photos
            items = 2;
            break;
        case 2:// to-do. places, weather
            items = 3;
            break;
        default:
            break;
    }
    return items;//title and maps section only 1 item
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 4;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *returnCell = nil;
    
    switch (indexPath.section) {
        case 0:
        {
            TripDetailCollectionViewCell *cell = (TripDetailCollectionViewCell *)[self.collectionView dequeueReusableCellWithReuseIdentifier:_tripDetailCellIdentifier
                                                                                                                                forIndexPath:indexPath];
            cell.backgroundColor = [UIColor whiteColor];
            cell.titleLabel.text = NSLocalizedString(@"Detail", @"");
            cell.titleLabel.textColor = [UIColor darkGrayColor];
            
            returnCell = cell;
        }
            break;
        case 1:
        {
            if (indexPath.row == 0) {
                TopMomentsCollectionViewCell *cell = (TopMomentsCollectionViewCell *)[self.collectionView dequeueReusableCellWithReuseIdentifier:_topMomentsCellIdentifier
                                                                                                                                    forIndexPath:indexPath];
                cell.backgroundColor = [UIColor colorWithRed:(float)225/255 green:(float)100/255 blue:(float)95/255 alpha:1.0f];
                cell.titleLabel.text = NSLocalizedString(@"Top Moments", @"");
                cell.titleLabel.textColor = [UIColor whiteColor];
                
                returnCell = cell;
            }
            else if (indexPath.row == 1){
                PhotoCollectionViewCell *cell = (PhotoCollectionViewCell *)[self.collectionView dequeueReusableCellWithReuseIdentifier:_photoCellIdentifier
                                                                                                                          forIndexPath:indexPath];
                cell.backgroundColor = [UIColor colorWithRed:(float)58/255 green:(float)75/255 blue:(float)90/255 alpha:1.0f];
                cell.titleLabel.text = NSLocalizedString(@"Photos", @"");
                cell.titleLabel.textColor = [UIColor whiteColor];
                
                returnCell = cell;
            }
        }
            break;
        case 2:
        {
            if (indexPath.row == 0) {
                ToDoCollectionViewCell *cell = (ToDoCollectionViewCell *)[self.collectionView dequeueReusableCellWithReuseIdentifier:_todoCellIdentifier
                                                                                                                        forIndexPath:indexPath];
                
                cell.backgroundColor = [UIColor colorWithRed:(float)56/255 green:(float)63/255 blue:(float)70/255 alpha:1.0f];
                cell.titleLabel.text = NSLocalizedString(@"To-Do", @"");
                cell.titleLabel.textColor = [UIColor whiteColor];
                
                
                returnCell = cell;
            }
            else if (indexPath.row == 1){
                PlacesCollectionViewCell * cell = (PlacesCollectionViewCell *)[self.collectionView dequeueReusableCellWithReuseIdentifier:_placesCellIdentifier
                                                                                                                             forIndexPath:indexPath];
                cell.backgroundColor = [UIColor colorWithRed:(float)87/255 green:(float)193/255 blue:(float)188/255 alpha:1.0f];
                cell.titleLabel.text = NSLocalizedString(@"Places", @"");
                cell.titleLabel.textColor = [UIColor whiteColor];
                
                returnCell = cell;
            }
            else if (indexPath.row == 2){
                WeatherCollectionViewCell *cell = (WeatherCollectionViewCell *)[self.collectionView dequeueReusableCellWithReuseIdentifier:_weatherCellIdentifier
                                                                                                                              forIndexPath:indexPath];
                cell.backgroundColor = [UIColor whiteColor];
                cell.titleLabel.text = NSLocalizedString(@"Weather", @"");
                cell.titleLabel.textColor = [UIColor darkGrayColor];
                
                returnCell = cell;
            }
        }
            break;
        case 3:
        {
            MapCollectionViewCell *cell = (MapCollectionViewCell *)[self.collectionView dequeueReusableCellWithReuseIdentifier:_mapCellIdentifier
                                                                                                                  forIndexPath:indexPath];
            cell.backgroundColor = [UIColor colorWithRed:(float)177/255 green:(float)201/255 blue:(float)92/255 alpha:1.0f];
            cell.titleLabel.text = NSLocalizedString(@"Map", @"");
            cell.titleLabel.textColor = [UIColor whiteColor];
            
            
            returnCell = cell;
        }
            break;
        default:
            break;
    }
    
    
    //    NSString *strPathResPlist = [[NSBundle mainBundle] pathForResource:@"PredefinedColors" ofType:@"plist"];
    //    NSArray *colors = [NSArray arrayWithContentsOfFile:strPathResPlist];
    //
    //    NSInteger colIndex = arc4random()%colors.count;
    //    if (colIndex >=  colors.count) {
    //        colIndex = colors.count-1;
    //    }
    //    NSArray *defaultColor = [[colors objectAtIndex:colIndex] objectForKey:kColorValues];
    //    float r = [[defaultColor objectAtIndex:0] floatValue];
    //    float g = [[defaultColor objectAtIndex:1] floatValue];
    //    float b = [[defaultColor objectAtIndex:2] floatValue];
    //
    //    cell.backgroundColor = [UIColor colorWithRed:(float)r/255 green:(float)g/255 blue:(float)b/255 alpha:1.0f];
    
    
    //    cell.titleLabel.text = [NSString stringWithFormat:@"section = %ld, row = %ld", (long)indexPath.section, (long)indexPath.row];
    return returnCell;
}

#pragma mark - UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end
