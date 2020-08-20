//
//  WeatherViewModel.m
//  OpenWeather
//
//  Created by Oskar Figiel on 15/08/2020.
//

#import "WeatherViewModel.h"

@implementation WeatherViewModel

- (void)setupTableCell:(NSInteger)tableIndexPath {
    NSInteger integer = self.weather.daily[tableIndexPath].dt;
    NSDate *lastUpdate = [[NSDate alloc] initWithTimeIntervalSince1970:integer];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE"];
    
    self->_dayNameTableCellText = [dateFormatter stringFromDate:lastUpdate];
    
    NSString *imageIconName = self.weather.daily[tableIndexPath].weather.firstObject.icon;
    UIImage *imageView = [UIImage imageNamed:imageIconName];
    self->_weatherTableCellImage = imageView;
    
    NSNumber *minTempNumber = [NSNumber numberWithInt:self.weather.daily[tableIndexPath].temp.min];
    self->_minTemperatureTableCellText = [NSString stringWithFormat:@"%@°C", [minTempNumber stringValue]];
    
    NSNumber *maxTempNumber = [NSNumber numberWithInt: self.weather.daily[tableIndexPath].temp.max];
    self->_maxTemperatureTableCellText = [NSString stringWithFormat:@"%@°C", [maxTempNumber stringValue]];
}

- (instancetype)initWithLocation:(NSString *)lat :(NSString *)lon {
    self = [super init];
    if(!self) return nil;
    
    self.collectionNumberOfRows = 0;
    self.tableNumberOfSections = 1;
    
    WeatherService *service = [WeatherService new];
    [service getTodayWeather:(lat) :(lon) completion:^(Weather *weather) {
        self.weather = weather;
        
        NSNumber *feelsLikeNumber = [NSNumber numberWithInt:weather.current.feelsLike];
        self->_feelsLikeText = [NSString stringWithFormat:@"Feels like temperature: %@°C", [feelsLikeNumber stringValue]];
        
        NSNumber *minTempNumber = [NSNumber numberWithInt:weather.daily.firstObject.temp.min];
        self->_minTemperatureText = [NSString stringWithFormat:@"Min: %@°C", [minTempNumber stringValue]];
        
        NSNumber *maxTempNumber = [NSNumber numberWithInt:weather.daily.firstObject.temp.max];
        self->_maxTemperatureText = [NSString stringWithFormat:@"Max: %@°C", [maxTempNumber stringValue]];
        
        NSNumber *currentTempNumber = [NSNumber numberWithInt:weather.current.temp];
        self->_currentTemperatureText = [NSString stringWithFormat:@"%@°C", [currentTempNumber stringValue]];
        
        NSString *imageIconName = weather.current.weather.firstObject.icon;
        UIImage *imageView = [UIImage imageNamed:imageIconName];
        self->_weatherImage = imageView;
        
        self.collectionNumberOfRows = weather.daily.count;
        
        [self.delegate didFinishFetchingData:self];
    }];
    
    return self;
}

@end
