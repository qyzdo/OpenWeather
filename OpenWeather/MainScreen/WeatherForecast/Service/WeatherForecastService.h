//
//  NextDaysService.h
//  OpenWeather
//
//  Created by Oskar Figiel on 17/08/2020.
//
#import <Foundation/Foundation.h>
#import "WeatherForecastModel.h"
#import "WeatherDataManager.h"

@interface WeatherForecastService : NSObject

- (void)getWeatherForecast:(void (^)(Forecast *weather))callback;

@end
