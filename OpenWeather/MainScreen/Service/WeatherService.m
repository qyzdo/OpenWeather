//
//  TodayWeatherService.m
//  OpenWeather
//
//  Created by Oskar Figiel on 17/08/2020.
//

#import "WeatherService.h"

@implementation WeatherService

- (void)getTodayWeather:(NSString *)lat :(NSString *)lon completion:(void (^)(Weather *))callback {
    
    WeatherDataManager*api = [WeatherDataManager new];
    NSMutableString *urlString = [NSMutableString new];
    [urlString appendString:@"https://api.openweathermap.org/data/2.5/onecall?lat="];
    [urlString appendString:lat];
    [urlString appendString:@"&lon="];
    [urlString appendString:lon];
    [urlString appendString:@"&units=metric&appid="];
    [urlString appendString:APIKey];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    [api getWeather:url completion:^(NSString *jsonString) {
        NSError *error = nil;
        Weather *weather = [Weather fromJSON:jsonString encoding:NSUTF8StringEncoding error:&error];
        callback(weather);
    }];
}

@end
