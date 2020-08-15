//
//  WeatherViewModel.m
//  OpenWeather
//
//  Created by Oskar Figiel on 15/08/2020.
//

#import "WeatherViewModel.h"

@implementation WeatherViewModel

- (instancetype)initWithWeather:(Weather *)weather {
    self = [super init];
    if(!self) return nil;
    
    _weather = weather;
    
    NSNumber *tempNumber = [NSNumber numberWithDouble:self.weather.main.temp];
    _temperatureText = [NSString stringWithFormat:@"Temperature: %@", [tempNumber stringValue]];
    
    NSNumber *feelsLikeNumber = [NSNumber numberWithDouble:self.weather.main.feelsLike];
    _feelsLikeText = [NSString stringWithFormat:@"Feels like temperature: %@", [feelsLikeNumber stringValue]]; 
    
    return self;
}

@end
