//
//  TodayWeatherService.h
//  OpenWeather
//
//  Created by Oskar Figiel on 17/08/2020.
//

#import "WeatherDataManager.h"

@interface TodayWeatherService : NSObject

- (void)getTodayWeather: (void (^)(Weather *weather))callback;


@end
