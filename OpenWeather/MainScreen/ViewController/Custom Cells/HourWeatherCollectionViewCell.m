//
//  HourWeatherCollectionViewCell.m
//  OpenWeather
//
//  Created by Oskar Figiel on 21/08/2020.
//

#import "HourWeatherCollectionViewCell.h"

@implementation HourWeatherCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.weatherImage = [[UIImageView alloc]init];
        self.weatherImage.translatesAutoresizingMaskIntoConstraints = false;
        self.weatherImage.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.weatherImage];
        [self.weatherImage.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor].active = true;
        [self.weatherImage.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor].active = true;
        [self.weatherImage.heightAnchor constraintEqualToConstant:50].active = true;
        

        self.timeLabel = [[UILabel alloc] init];
        self.timeLabel.translatesAutoresizingMaskIntoConstraints = false;
        self.timeLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.timeLabel];


        [self.timeLabel.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor].active = true;
        [self.timeLabel.topAnchor constraintEqualToAnchor:self.contentView.topAnchor].active = true;
        
        self.temperatureLabel = [[UILabel alloc] init];
        self.temperatureLabel.translatesAutoresizingMaskIntoConstraints = false;
        self.temperatureLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.temperatureLabel];


        [self.temperatureLabel.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor].active = true;
        [self.temperatureLabel.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor].active = true;


       self.contentView.layer.masksToBounds = YES;
       self.contentView.layer.cornerRadius = 8.0f;
    }
    return self;
}

@end
