//
//  ViewController.m
//  OpenWeather
//
//  Created by Oskar Figiel on 15/08/2020.
//

#import "WeatherViewController.h"

@interface WeatherViewController ()
@end

@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    self.viewModel = [[WeatherViewModel alloc] init];
    self.viewModel.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = true;
}

- (void)viewWillDisappear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = false;
}

- (void)setupView {
    UILayoutGuide * guide = self.view.safeAreaLayoutGuide;
    
    self.view.backgroundColor = UIColor.systemBackgroundColor;

    self.weatherIcon = [[UIImageView alloc] init];
    self.weatherIcon.translatesAutoresizingMaskIntoConstraints = false;
    self.weatherIcon.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview: self.weatherIcon];
    [self.weatherIcon.topAnchor constraintEqualToAnchor:guide.topAnchor].active = true;
    [self.weatherIcon.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = true;
    [self.weatherIcon.heightAnchor constraintEqualToConstant:200].active = true;
    [self.weatherIcon.widthAnchor constraintEqualToConstant:200].active = true;
    
    
    self.currentTemperatureLabel = [[UILabel alloc] init];
    self.currentTemperatureLabel.font = [UIFont systemFontOfSize:45];
    self.currentTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self.view addSubview: self.currentTemperatureLabel];
    
    [self.currentTemperatureLabel.topAnchor constraintEqualToAnchor:self.weatherIcon.bottomAnchor constant:-5].active = true;
    [self.currentTemperatureLabel.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = true;
    
    self.maxTemperatureLabel = [[UILabel alloc] init];
    self.maxTemperatureLabel.font = [UIFont systemFontOfSize:12];
    self.maxTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false;
    
    self.minTemperatureLabel = [[UILabel alloc] init];
    self.minTemperatureLabel.font = [UIFont systemFontOfSize:12];
    self.minTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false;
    
    self.stackView = [[UIStackView alloc] init];
    self.stackView.translatesAutoresizingMaskIntoConstraints = false;
    self.stackView.alignment = UIStackViewAlignmentCenter;
    self.stackView.distribution = UIStackViewDistributionFillProportionally;
    self.stackView.axis = UILayoutConstraintAxisHorizontal;
    self.stackView.spacing = 10;
    [self.stackView addArrangedSubview:self.minTemperatureLabel];
    [self.stackView addArrangedSubview:self.maxTemperatureLabel];
    
    [self.view addSubview: self.stackView];
    
    [self.stackView.topAnchor constraintEqualToAnchor:self.currentTemperatureLabel.bottomAnchor constant:5].active = true;
    [self.stackView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = true;
    
    self.feelsLikeTemperatureLabel = [[UILabel alloc] init];
    self.feelsLikeTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self.view addSubview: self.feelsLikeTemperatureLabel];
    [self.feelsLikeTemperatureLabel.topAnchor constraintEqualToAnchor:self.stackView.bottomAnchor].active = true;
    [self.feelsLikeTemperatureLabel.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = true;
    [self.feelsLikeTemperatureLabel.heightAnchor constraintEqualToConstant:50].active = true;
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.translatesAutoresizingMaskIntoConstraints = false;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.view addSubview:self.tableView];
    [self.tableView.topAnchor constraintEqualToAnchor:self.feelsLikeTemperatureLabel.bottomAnchor constant:15].active = true;
    [self.tableView.bottomAnchor constraintEqualToAnchor:guide.bottomAnchor].active = true;
    [self.tableView.leftAnchor constraintEqualToAnchor:guide.leftAnchor].active = true;
    [self.tableView.rightAnchor constraintEqualToAnchor:guide.rightAnchor].active = true;
    
}

- (void)didFinishFetchingData:(WeatherViewModel *)sender {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.weatherIcon.image = self.viewModel.weatherImage;
        self.feelsLikeTemperatureLabel.text = self.viewModel.feelsLikeText;
        self.minTemperatureLabel.text = self.viewModel.minTemperatureText;
        self.maxTemperatureLabel.text = self.viewModel.maxTemperatureText;
        self.currentTemperatureLabel.text = self.viewModel.currentTemperatureText;
        [self.tableView reloadData];
    });
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    cell.textLabel.text = @"OK";
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewModel.numberOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.numberOfRows;
}

@end
