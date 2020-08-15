//
//  Weather.h
//  OpenWeather
//
//  Created by Oskar Figiel on 15/08/2020.
//

#import <Foundation/Foundation.h>

@class Weather;
@class WeatherClouds;
@class WeatherCoord;
@class WeatherMain;
@class WeatherSys;
@class WeatherElement;
@class WeatherWind;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Object interfaces

@interface Weather : NSObject
@property (nonatomic, strong) WeatherCoord *coord;
@property (nonatomic, copy)   NSArray<WeatherElement *> *weather;
@property (nonatomic, copy)   NSString *base;
@property (nonatomic, strong) WeatherMain *main;
@property (nonatomic, assign) NSInteger visibility;
@property (nonatomic, strong) WeatherWind *wind;
@property (nonatomic, strong) WeatherClouds *clouds;
@property (nonatomic, assign) NSInteger dt;
@property (nonatomic, strong) WeatherSys *sys;
@property (nonatomic, assign) NSInteger timezone;
@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, copy)   NSString *name;
@property (nonatomic, assign) NSInteger cod;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

@interface WeatherClouds : NSObject
@property (nonatomic, assign) NSInteger all;
@end

@interface WeatherCoord : NSObject
@property (nonatomic, assign) double lon;
@property (nonatomic, assign) double lat;
@end

@interface WeatherMain : NSObject
@property (nonatomic, assign) double temp;
@property (nonatomic, assign) double feelsLike;
@property (nonatomic, assign) double tempMin;
@property (nonatomic, assign) NSInteger tempMax;
@property (nonatomic, assign) NSInteger pressure;
@property (nonatomic, assign) NSInteger humidity;
@end

@interface WeatherSys : NSObject
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, copy)   NSString *country;
@property (nonatomic, assign) NSInteger sunrise;
@property (nonatomic, assign) NSInteger sunset;
@end

@interface WeatherElement : NSObject
@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, copy)   NSString *main;
@property (nonatomic, copy)   NSString *theDescription;
@property (nonatomic, copy)   NSString *icon;
@end

@interface WeatherWind : NSObject
@property (nonatomic, assign) double speed;
@property (nonatomic, assign) NSInteger deg;
@end

NS_ASSUME_NONNULL_END
