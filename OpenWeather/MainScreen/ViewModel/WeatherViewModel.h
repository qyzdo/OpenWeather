//
//  WeatherViewModel.h
//  OpenWeather
//
//  Created by Oskar Figiel on 15/08/2020.
//

#import "WeatherService.h"
#import <UIKit/UIKit.h>
#import "WeatherViewModelDelegate.h"

@interface WeatherViewModel : NSObject

- (instancetype)initWithLocation: (NSString*)lat : (NSString*)lon;
- (void)setupTableCell: (NSInteger)indexPath;


@property (nonatomic, weak) id <WeatherViewModelDelegate> delegate;
@property (nonatomic) Weather* weather;
@property (nonatomic, readonly) NSString *feelsLikeText;
@property (nonatomic, readonly) NSString *minTemperatureText;
@property (nonatomic, readonly) NSString *maxTemperatureText;
@property (nonatomic, readonly) NSString *currentTemperatureText;
@property (nonatomic, readonly) NSString *dayNameTableCellText;
@property (nonatomic, readonly) NSString *minTemperatureTableCellText;
@property (nonatomic, readonly) NSString *maxTemperatureTableCellText;
@property (nonatomic, readonly) UIImage *weatherImage;
@property (nonatomic, readonly) UIImage *weatherTableCellImage;

@property (nonatomic, readonly) UIImage *weatherColectionCellImage;


@property (nonatomic) NSUInteger tableNumberOfSections;
@property (nonatomic) NSUInteger collectionNumberOfRows;



@end
