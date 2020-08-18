//
//  WeatherViewModel.h
//  OpenWeather
//
//  Created by Oskar Figiel on 15/08/2020.
//

#import "TodayWeatherService.h"
#import <UIKit/UIKit.h>
#import "WeatherViewModelDelegate.h"

@interface WeatherViewModel : NSObject

- (instancetype)init;
- (void)fetchData: (void (^)(Weather* weather))callback;

@property (nonatomic, weak) id <WeatherViewModelDelegate> delegate;
@property (nonatomic, readonly) NSString *feelsLikeText;
@property (nonatomic, readonly) NSString *minTemperatureText;
@property (nonatomic, readonly) NSString *maxTemperatureText;
@property (nonatomic, readonly) NSString *currentTemperatureText;
@property (nonatomic, readonly) UIImage *weatherImage;
@property (nonatomic) int numberOfSections;
@property (nonatomic) int numberOfRows;


@end
