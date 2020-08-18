//
//  TodayWeatherService.m
//  OpenWeather
//
//  Created by Oskar Figiel on 17/08/2020.
//

#import "TodayWeatherService.h"

@implementation TodayWeatherService

- (void)getTodayWeather:(void (^)(Weather *weather))callback {
    
    WeatherDataManager*api = [WeatherDataManager new];
        NSMutableString *urlString = [NSMutableString new];
        [urlString appendString:@"https://openweathermap.org/data/2.5/weather?q=London&appid="];
        [urlString appendString:APIKey];
        
        NSURL *url = [NSURL URLWithString:urlString];
    
    [api getWeather:url completion:^(NSString *jsonString) {
        NSError *error = nil;
        Weather *weather = [Weather fromJSON:jsonString encoding:NSUTF8StringEncoding error:&error];
        callback(weather);
    }];
}

@end
