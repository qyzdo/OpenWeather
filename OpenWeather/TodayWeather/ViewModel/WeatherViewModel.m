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
    
    int tempNumberInt = (int)self.weather.main.temp;
    NSNumber *tempNumber = [NSNumber numberWithInt:tempNumberInt];
    _temperatureText = [NSString stringWithFormat:@"Current temperature: %@°C", [tempNumber stringValue]];
    
    int feelsLikeNumberInt = (int)self.weather.main.feelsLike;
    NSNumber *feelsLikeNumber = [NSNumber numberWithInt:feelsLikeNumberInt];
    _feelsLikeText = [NSString stringWithFormat:@"Feels like temperature: %@°C", [feelsLikeNumber stringValue]];
    
    int minTempNumberInt = (int)self.weather.main.tempMin;
    NSNumber *minTempNumber = [NSNumber numberWithInt:minTempNumberInt];
    _minTemperatureText = [NSString stringWithFormat:@"Min: %@°C", [minTempNumber stringValue]];
    
    int maxTempNumberInt = (int)self.weather.main.tempMax;
    NSNumber *maxTempNumber = [NSNumber numberWithInt:maxTempNumberInt];
    _maxTemperatureText = [NSString stringWithFormat:@"Max: %@°C", [maxTempNumber stringValue]];
    
    if(self.weather.weather[0].identifier>=500) {
        UIImage *imageView = [UIImage imageNamed:@"10d"];
        _weatherImage = imageView;
    }
    
    NSLog(@"%ld", (long)self.weather.weather[0].identifier);
    return self;
}

@end
