//
//  NextDaysService.m
//  OpenWeather
//
//  Created by Oskar Figiel on 17/08/2020.
//

#import "WeatherForecastService.h"

@implementation WeatherForecastService

- (void)getWeatherForecast:(void (^)(Forecast *))callback {
    WeatherDataManager*api = [WeatherDataManager new];
        NSMutableString *urlString = [NSMutableString new];
        [urlString appendString:@"https://openweathermap.org/data/2.5/forecast/hourly?q=London&appid="];
        [urlString appendString:APIKey];
        
        NSURL *url = [NSURL URLWithString:urlString];
    
    [api getWeather:url completion:^(NSString *jsonString) {
        NSError *error = nil;
        Forecast *weather = [Forecast fromJSON:jsonString encoding:NSUTF8StringEncoding error:&error];
        callback(weather);
    }];
}

@end
