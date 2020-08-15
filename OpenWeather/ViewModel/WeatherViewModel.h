//
//  WeatherViewModel.h
//  OpenWeather
//
//  Created by Oskar Figiel on 15/08/2020.
//

#import "Weather.h"

@interface WeatherViewModel : NSObject

- (instancetype)initWithWeather:(Weather *)weather;

@property (nonatomic, readonly) Weather *weather;

@property (nonatomic, readonly) NSString *temperatureText;
@property (nonatomic, readonly) NSString *feelsLikeText;

@end
