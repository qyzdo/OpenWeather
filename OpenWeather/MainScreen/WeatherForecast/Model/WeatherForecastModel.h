//
//  ForecastModel.h
//  OpenWeather
//
//  Created by Oskar Figiel on 17/08/2020.
//

#import <Foundation/Foundation.h>

@class Forecast;
@class ForecastCity;
@class ForecastCoord;
@class ForecastList;
@class ForecastClouds;
@class ForecastMainClass;
@class ForecastRain;
@class ForecastSys;
@class ForecastPod;
@class ForecastWeather;
@class ForecastMainEnum;
@class ForecastWind;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Boxed enums

@interface ForecastPod : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (ForecastPod *)d;
+ (ForecastPod *)n;
@end

@interface ForecastMainEnum : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (ForecastMainEnum *)clear;
+ (ForecastMainEnum *)clouds;
+ (ForecastMainEnum *)rain;
@end

#pragma mark - Object interfaces

@interface Forecast : NSObject
@property (nonatomic, copy)   NSString *cod;
@property (nonatomic, assign) NSInteger message;
@property (nonatomic, assign) NSInteger cnt;
@property (nonatomic, copy)   NSArray<ForecastList *> *list;
@property (nonatomic, strong) ForecastCity *city;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
@end

@interface ForecastCity : NSObject
@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, copy)   NSString *name;
@property (nonatomic, strong) ForecastCoord *coord;
@property (nonatomic, copy)   NSString *country;
@property (nonatomic, assign) NSInteger timezone;
@property (nonatomic, assign) NSInteger sunrise;
@property (nonatomic, assign) NSInteger sunset;
@end

@interface ForecastCoord : NSObject
@property (nonatomic, assign) double lat;
@property (nonatomic, assign) double lon;
@end

@interface ForecastList : NSObject
@property (nonatomic, assign)           NSInteger dt;
@property (nonatomic, strong)           ForecastMainClass *main;
@property (nonatomic, copy)             NSArray<ForecastWeather *> *weather;
@property (nonatomic, strong)           ForecastClouds *clouds;
@property (nonatomic, strong)           ForecastWind *wind;
@property (nonatomic, assign)           NSInteger visibility;
@property (nonatomic, assign)           double pop;
@property (nonatomic, strong)           ForecastSys *sys;
@property (nonatomic, copy)             NSString *dtTxt;
@property (nonatomic, nullable, strong) ForecastRain *rain;
@end

@interface ForecastClouds : NSObject
@property (nonatomic, assign) NSInteger all;
@end

@interface ForecastMainClass : NSObject
@property (nonatomic, assign) double temp;
@property (nonatomic, assign) double feelsLike;
@property (nonatomic, assign) double tempMin;
@property (nonatomic, assign) double tempMax;
@property (nonatomic, assign) NSInteger pressure;
@property (nonatomic, assign) NSInteger seaLevel;
@property (nonatomic, assign) NSInteger grndLevel;
@property (nonatomic, assign) NSInteger humidity;
@property (nonatomic, assign) double tempKf;
@end

@interface ForecastRain : NSObject
@property (nonatomic, assign) double the3H;
@end

@interface ForecastSys : NSObject
@property (nonatomic, assign) ForecastPod *pod;
@end

@interface ForecastWeather : NSObject
@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, assign) ForecastMainEnum *main;
@property (nonatomic, copy)   NSString *theDescription;
@property (nonatomic, copy)   NSString *icon;
@end

@interface ForecastWind : NSObject
@property (nonatomic, assign) double speed;
@property (nonatomic, assign) NSInteger deg;
@end

NS_ASSUME_NONNULL_END
