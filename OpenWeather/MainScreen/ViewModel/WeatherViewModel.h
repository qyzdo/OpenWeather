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
- (void)setupCellNumber: (NSInteger)indexPath;


@property (nonatomic, weak) id <WeatherViewModelDelegate> delegate;
@property (nonatomic) Weather* weather;
@property (nonatomic, readonly) NSString *feelsLikeText;
@property (nonatomic, readonly) NSString *minTemperatureText;
@property (nonatomic, readonly) NSString *maxTemperatureText;
@property (nonatomic, readonly) NSString *currentTemperatureText;
@property (nonatomic, readonly) NSString *dayNameCellText;
@property (nonatomic, readonly) NSString *minTemperatureCellText;
@property (nonatomic, readonly) NSString *maxTemperatureCellText;
@property (nonatomic, readonly) UIImage *weatherImage;
@property (nonatomic, readonly) UIImage *weatherCellImage;

@property (nonatomic) NSUInteger numberOfSections;
@property (nonatomic) NSUInteger numberOfRows;



@end
