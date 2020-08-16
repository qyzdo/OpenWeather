//
//  WeatherViewModel.h
//  OpenWeather
//
//  Created by Oskar Figiel on 15/08/2020.
//

#import "Weather.h"
#import "WeatherDataManager.h"
#import <UIKit/UIKit.h>
#import "WeatherViewModelDelegate.h"

@interface WeatherViewModel : NSObject

- (instancetype)init;
- (void)fetchData: (void (^)(Weather* weather))callback;

@property (nonatomic, weak) id <WeatherViewModelDelegate> delegate;
@property (nonatomic, readonly) NSString *temperatureText;
@property (nonatomic, readonly) NSString *feelsLikeText;
@property (nonatomic, readonly) NSString *minTemperatureText;
@property (nonatomic, readonly) NSString *maxTemperatureText;
@property (nonatomic, readonly) UIImage *weatherImage;


@end