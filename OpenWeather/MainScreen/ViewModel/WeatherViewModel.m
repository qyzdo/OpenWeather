//
//  WeatherViewModel.m
//  OpenWeather
//
//  Created by Oskar Figiel on 15/08/2020.
//

#import "WeatherViewModel.h"

@implementation WeatherViewModel

- (void)setupCellNumber:(NSInteger)indexPath {
    NSInteger integer = self.weather.daily[indexPath].dt;
    NSDate *lastUpdate = [[NSDate alloc] initWithTimeIntervalSince1970:integer];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE"];
    
    self->_dayNameCellText = [dateFormatter stringFromDate:lastUpdate];
    
    NSString *imageIcon = self.weather.daily[indexPath].weather.firstObject.icon;
    UIImage *imageView = [UIImage imageNamed:imageIcon];
    self->_weatherCellImage = imageView;
    
    NSNumber *minTempNumber = [NSNumber numberWithInt:self.weather.daily[indexPath].temp.min];
    self->_minTemperatureCellText = [NSString stringWithFormat:@"%@°C", [minTempNumber stringValue]];
    
    NSNumber *maxTempNumber = [NSNumber numberWithInt: self.weather.daily[indexPath].temp.max];
    self->_maxTemperatureCellText = [NSString stringWithFormat:@"%@°C", [maxTempNumber stringValue]];
}

- (instancetype)initWithLocation:(NSString *)lat :(NSString *)lon {
    self = [super init];
    if(!self) return nil;
    
    self.numberOfRows = 0;
    self.numberOfSections = 1;
    
    WeatherService *service = [WeatherService new];
    [service getTodayWeather:(lat) :(lon) completion:^(Weather *weather) {
        self.weather = weather;
        int feelsLikeNumberInt = (int)weather.current.feelsLike;
        NSNumber *feelsLikeNumber = [NSNumber numberWithInt:feelsLikeNumberInt];
        self->_feelsLikeText = [NSString stringWithFormat:@"Feels like temperature: %@°C", [feelsLikeNumber stringValue]];
        
        int minTempNumberInt = (int)weather.daily.firstObject.temp.min;
        NSNumber *minTempNumber = [NSNumber numberWithInt:minTempNumberInt];
        self->_minTemperatureText = [NSString stringWithFormat:@"Min: %@°C", [minTempNumber stringValue]];
        
        int maxTempNumberInt = (int)weather.daily.firstObject.temp.max;
        NSNumber *maxTempNumber = [NSNumber numberWithInt:maxTempNumberInt];
        self->_maxTemperatureText = [NSString stringWithFormat:@"Max: %@°C", [maxTempNumber stringValue]];
        
        int currentTempNumberInt = (int)weather.current.temp;
        NSNumber *currentTempNumber = [NSNumber numberWithInt:currentTempNumberInt];
        self->_currentTemperatureText = [NSString stringWithFormat:@"%@°C", [currentTempNumber stringValue]];
        
        NSString *imageIcon = weather.current.weather.firstObject.icon;
        UIImage *imageView = [UIImage imageNamed:imageIcon];
        self->_weatherImage = imageView;
        
        self.numberOfRows = weather.daily.count;
        
        [self.delegate didFinishFetchingData:self];
    }];
    
    return self;
}

@end
