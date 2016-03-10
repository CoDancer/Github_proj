//
//  TribePlaceViewController.m
//  GraduationProject
//
//  Created by onwer on 16/3/8.
//  Copyright © 2016年 onwer. All rights reserved.
//

#import "TribePlaceViewController.h"
#import "NaviView.h"
#import "GPSecondDetailViewController.h"
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>

@interface RouteAnnotation : BMKPointAnnotation
{
    int _type; ///<0:起点 1：终点 2：公交 3：地铁 4:驾乘 5:途经点
    int _degree;
}

@property (nonatomic) int type;
@property (nonatomic) int degree;
@end

@implementation RouteAnnotation

@synthesize type = _type;
@synthesize degree = _degree;
@end


@interface TribePlaceViewController ()<BMKMapViewDelegate, BMKLocationServiceDelegate,
                                        BMKRouteSearchDelegate>

@property (nonatomic, strong) BMKMapView *mapView;
@property (nonatomic, strong) BMKLocationService *locotionSer;
@property (nonatomic, strong) BMKRouteSearch *routeSearch;
@property (nonatomic, assign) CLLocationCoordinate2D userCoor;
@property (nonatomic, strong) UIButton *moreBtn;
@property (nonatomic, strong) UIButton *downBtn;

@end

@implementation TribePlaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithHexString:@"f3f3f3"];
    [self configView];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [self.mapView viewWillAppear];
    self.mapView.delegate = self;
    self.locotionSer.delegate = self;
    self.routeSearch.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated {
    
    self.mapView.delegate = nil;
    self.locotionSer.delegate = nil;
    self.routeSearch.delegate = nil;
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    BMKPointAnnotation *annotation = [BMKPointAnnotation new];
    CLLocationCoordinate2D coor;
    coor.latitude = [self.placeModel.latitude doubleValue];
    coor.longitude = [self.placeModel.longitude doubleValue];
    annotation.coordinate = coor;
    annotation.title = self.subTitle;
    [self.mapView addAnnotation:annotation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIButton *)moreBtn {
    
    if (!_moreBtn) {
        _moreBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [_moreBtn setImage:[UIImage imageNamed:@"arrow_up"] forState:UIControlStateNormal];
        [_moreBtn addTarget:self action:@selector(btnDidTap:) forControlEvents:UIControlEventTouchUpInside];
        _moreBtn.adjustsImageWhenHighlighted = NO;
    }
    return _moreBtn;
}

- (UIButton *)downBtn {
    
    if (!_downBtn) {
        _downBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [_downBtn setImage:[UIImage imageNamed:@"arrow_down"] forState:UIControlStateNormal];
        [_downBtn addTarget:self action:@selector(btnDidTap:) forControlEvents:UIControlEventTouchUpInside];
        _downBtn.adjustsImageWhenHighlighted = NO;
    }
    return _downBtn;
}

- (void)configView {
    
    NaviView *naviView = [[NaviView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    naviView.BGColor = MainColor;
    naviView.text = self.placeModel.placeName;
    [self.view addSubview:naviView];
    naviView.backBlock = ^(){
        [self dismissViewControllerAnimated:YES completion:nil];
    };
    
    self.mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT)];
    BMKCoordinateSpan span = BMKCoordinateSpanMake(0.02, 0.02);
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([self.placeModel.latitude floatValue], [self.placeModel.longitude floatValue]);
    BMKCoordinateRegion region = BMKCoordinateRegionMake(coordinate,span);
    [_mapView setRegion:region animated:NO];
    self.mapView.mapType = BMKMapTypeStandard;
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = BMKUserTrackingModeFollowWithHeading;
    [self.view addSubview:self.mapView];
    
    self.locotionSer = [BMKLocationService new];
    self.locotionSer.userLocation.title = @"当前位置";
    [self.locotionSer startUserLocationService];
    
    self.routeSearch = [BMKRouteSearch new];
    [self.view addSubview:self.moreBtn];
    self.moreBtn.centerX = self.view.centerX;
    self.moreBtn.bottom = self.view.height - 10;
    [self.view addSubview:self.downBtn];
    self.downBtn.left = 10;
    self.downBtn.centerY = self.moreBtn.centerY;
}

- (void)btnDidTap:(UIButton *)sender {
    
    if (sender == self.moreBtn) {
        self.mapView.userTrackingMode = BMKUserTrackingModeFollowWithHeading;
        UIMenuController *menu = [UIMenuController sharedMenuController];
        UIMenuItem *menuItem1 = [[UIMenuItem alloc] initWithTitle:@"公交" action:@selector(busAction)];
        UIMenuItem *menuItem2 = [[UIMenuItem alloc] initWithTitle:@"驾车" action:@selector(driveAction)];
        UIMenuItem *menuItem3 = [[UIMenuItem alloc] initWithTitle:@"骑车" action:@selector(walkAction)];
        menu.menuItems = @[menuItem1,menuItem2,menuItem3];
        [menu setTargetRect:CGRectMake(SCREEN_WIDTH/2.0-100, SCREEN_HEIGHT - 35, 200, 40) inView:self.view];
        [menu setMenuVisible:YES animated:YES];
    }else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (BOOL)canBecomeFirstResponder {
    
    return YES;
}

- (void)busAction {
    
    BMKPlanNode* start = [[BMKPlanNode alloc]init];
    start.pt = self.userCoor;
    BMKPlanNode* end = [[BMKPlanNode alloc]init];
    end.pt = CLLocationCoordinate2DMake([self.placeModel.latitude doubleValue],
                                        [self.placeModel.longitude doubleValue]);
    
    BMKTransitRoutePlanOption *transitRouteSearchOption = [[BMKTransitRoutePlanOption alloc]init];
    transitRouteSearchOption.city= @"成都市";
    transitRouteSearchOption.from = start;
    transitRouteSearchOption.to = end;
    BOOL flag = [self.routeSearch transitSearch:transitRouteSearchOption];
    
    if(flag)
    {
        NSLog(@"bus检索发送成功");
    }
    else
    {
        NSLog(@"bus检索发送失败");
    }
}

- (void)driveAction {
    
    BMKPlanNode* start = [[BMKPlanNode alloc]init];
    start.pt = self.userCoor;
    BMKPlanNode* end = [[BMKPlanNode alloc]init];
    end.pt = CLLocationCoordinate2DMake([self.placeModel.latitude doubleValue],
                                        [self.placeModel.longitude doubleValue]);
    BMKDrivingRoutePlanOption *drivingRouteSearchOption = [[BMKDrivingRoutePlanOption alloc]init];
    drivingRouteSearchOption.from = start;
    drivingRouteSearchOption.to = end;
    BOOL flag = [self.routeSearch drivingSearch:drivingRouteSearchOption];
    if(flag)
    {
        NSLog(@"car检索发送成功");
    }
    else
    {
        NSLog(@"car检索发送失败");
    }
}

- (void)walkAction {
    
    BMKPlanNode* start = [[BMKPlanNode alloc]init];
    start.pt = self.userCoor;
    BMKPlanNode* end = [[BMKPlanNode alloc]init];
    end.pt = CLLocationCoordinate2DMake([self.placeModel.latitude doubleValue],
                                        [self.placeModel.longitude doubleValue]);
    BMKWalkingRoutePlanOption *walkingRouteSearchOption = [[BMKWalkingRoutePlanOption alloc]init];
    walkingRouteSearchOption.from = start;
    walkingRouteSearchOption.to = end;
    BOOL flag = [self.routeSearch walkingSearch:walkingRouteSearchOption];
    if(flag)
    {
        NSLog(@"walk检索发送成功");
    }
    else
    {
        NSLog(@"walk检索发送失败");
    }
}

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorGreen;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        imageView.image = self.image;
        newAnnotationView.leftCalloutAccessoryView = imageView;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        return newAnnotationView;
    }
    return nil;
}

- (BMKOverlayView*)mapView:(BMKMapView *)map viewForOverlay:(id<BMKOverlay>)overlay
{
    if ([overlay isKindOfClass:[BMKPolyline class]]) {
        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        polylineView.fillColor = [[UIColor alloc] initWithRed:0 green:1 blue:1 alpha:1];
        polylineView.strokeColor = MainColor;
        polylineView.lineWidth = 3.0;
        return polylineView;
    }
    return nil;
}

- (void)onGetTransitRouteResult:(BMKRouteSearch*)searcher result:(BMKTransitRouteResult*)result errorCode:(BMKSearchErrorCode)error {
    
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:_mapView.overlays];
    [_mapView removeOverlays:array];
    if (error == BMK_SEARCH_NO_ERROR) {
        BMKTransitRouteLine* plan = (BMKTransitRouteLine*)[result.routes objectAtIndex:0];
        // 计算路线方案中的路段数目
        NSInteger size = [plan.steps count];
        int planPointCounts = 0;
        for (int i = 0; i < size; i++) {
            BMKTransitStep* transitStep = [plan.steps objectAtIndex:i];
            if(i==0){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.starting.location;
                item.title = @"起点";
                item.type = 0;
                [_mapView addAnnotation:item]; // 添加起点标注
                
            }else if(i==size-1){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.terminal.location;
                item.title = self.subTitle;
                item.type = 1;
                [_mapView addAnnotation:item]; // 添加起点标注
            }
            RouteAnnotation* item = [[RouteAnnotation alloc]init];
            item.coordinate = transitStep.entrace.location;
            item.title = transitStep.instruction;
            item.type = 3;
            [_mapView addAnnotation:item];
            
            //轨迹点总数累计
            planPointCounts += transitStep.pointsCount;
        }
        
        //轨迹点
        BMKMapPoint *temppoints = new BMKMapPoint[planPointCounts];
        int i = 0;
        for (int j = 0; j < size; j++) {
            BMKTransitStep* transitStep = [plan.steps objectAtIndex:j];
            int k=0;
            for(k=0;k<transitStep.pointsCount;k++) {
                temppoints[i].x = transitStep.points[k].x;
                temppoints[i].y = transitStep.points[k].y;
                i++;
            }
            
        }
        // 通过points构建BMKPolyline
        BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:temppoints count:planPointCounts];
        [_mapView addOverlay:polyLine]; // 添加路线overlay
        delete []temppoints;
        [self mapViewFitPolyLine:polyLine];
    }
}

- (void)onGetDrivingRouteResult:(BMKRouteSearch*)searcher result:(BMKDrivingRouteResult*)result errorCode:(BMKSearchErrorCode)error {
    
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:_mapView.overlays];
    [_mapView removeOverlays:array];
    if (error == BMK_SEARCH_NO_ERROR) {
        BMKDrivingRouteLine* plan = (BMKDrivingRouteLine*)[result.routes objectAtIndex:0];
        // 计算路线方案中的路段数目
        NSInteger size = [plan.steps count];
        int planPointCounts = 0;
        for (int i = 0; i < size; i++) {
            BMKDrivingStep* transitStep = [plan.steps objectAtIndex:i];
            if(i==0){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.starting.location;
                item.title = @"起点";
                item.type = 0;
                [_mapView addAnnotation:item]; // 添加起点标注
                
            }else if(i==size-1){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.terminal.location;
                item.title = @"终点";
                item.type = 1;
                [_mapView addAnnotation:item]; // 添加起点标注
            }
            //添加annotation节点
            RouteAnnotation* item = [[RouteAnnotation alloc]init];
            item.coordinate = transitStep.entrace.location;
            item.title = transitStep.entraceInstruction;
            item.degree = transitStep.direction * 30;
            item.type = 4;
            [_mapView addAnnotation:item];
            
            //轨迹点总数累计
            planPointCounts += transitStep.pointsCount;
        }
        // 添加途经点
        if (plan.wayPoints) {
            for (BMKPlanNode* tempNode in plan.wayPoints) {
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item = [[RouteAnnotation alloc]init];
                item.coordinate = tempNode.pt;
                item.type = 5;
                item.title = tempNode.name;
                [_mapView addAnnotation:item];
            }
        }
        //轨迹点
        BMKMapPoint * temppoints = new BMKMapPoint[planPointCounts];
        int i = 0;
        for (int j = 0; j < size; j++) {
            BMKDrivingStep* transitStep = [plan.steps objectAtIndex:j];
            int k=0;
            for(k=0;k<transitStep.pointsCount;k++) {
                temppoints[i].x = transitStep.points[k].x;
                temppoints[i].y = transitStep.points[k].y;
                i++;
            }
            
        }
        // 通过points构建BMKPolyline
        BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:temppoints count:planPointCounts];
        [_mapView addOverlay:polyLine]; // 添加路线overlay
        delete []temppoints;
        [self mapViewFitPolyLine:polyLine];
    }
}

- (void)onGetWalkingRouteResult:(BMKRouteSearch*)searcher result:(BMKWalkingRouteResult*)result errorCode:(BMKSearchErrorCode)error {
    
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:_mapView.overlays];
    [_mapView removeOverlays:array];
    if (error == BMK_SEARCH_NO_ERROR) {
        BMKWalkingRouteLine* plan = (BMKWalkingRouteLine*)[result.routes objectAtIndex:0];
        NSInteger size = [plan.steps count];
        int planPointCounts = 0;
        for (int i = 0; i < size; i++) {
            BMKWalkingStep* transitStep = [plan.steps objectAtIndex:i];
            if(i==0){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.starting.location;
                item.title = @"起点";
                item.type = 0;
                [_mapView addAnnotation:item]; // 添加起点标注
                
            }else if(i==size-1){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.terminal.location;
                item.title = @"终点";
                item.type = 1;
                [_mapView addAnnotation:item]; // 添加起点标注
            }
            //添加annotation节点
            RouteAnnotation* item = [[RouteAnnotation alloc]init];
            item.coordinate = transitStep.entrace.location;
            item.title = transitStep.entraceInstruction;
            item.degree = transitStep.direction * 30;
            item.type = 4;
            [_mapView addAnnotation:item];
            
            //轨迹点总数累计
            planPointCounts += transitStep.pointsCount;
        }
        
        //轨迹点
        BMKMapPoint * temppoints = new BMKMapPoint[planPointCounts];
        int i = 0;
        for (int j = 0; j < size; j++) {
            BMKWalkingStep* transitStep = [plan.steps objectAtIndex:j];
            int k=0;
            for(k=0;k<transitStep.pointsCount;k++) {
                temppoints[i].x = transitStep.points[k].x;
                temppoints[i].y = transitStep.points[k].y;
                i++;
            }
            
        }
        // 通过points构建BMKPolyline
        BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:temppoints count:planPointCounts];
        [_mapView addOverlay:polyLine]; // 添加路线overlay
        delete []temppoints;
        [self mapViewFitPolyLine:polyLine];
    }
}

- (void)mapViewFitPolyLine:(BMKPolyline *) polyLine {
    CGFloat ltX, ltY, rbX, rbY;
    if (polyLine.pointCount < 1) {
        return;
    }
    BMKMapPoint pt = polyLine.points[0];
    ltX = pt.x, ltY = pt.y;
    rbX = pt.x, rbY = pt.y;
    for (int i = 1; i < polyLine.pointCount; i++) {
        BMKMapPoint pt = polyLine.points[i];
        if (pt.x < ltX) {
            ltX = pt.x;
        }
        if (pt.x > rbX) {
            rbX = pt.x;
        }
        if (pt.y > ltY) {
            ltY = pt.y;
        }
        if (pt.y < rbY) {
            rbY = pt.y;
        }
    }
    BMKMapRect rect;
    rect.origin = BMKMapPointMake(ltX , ltY);
    rect.size = BMKMapSizeMake(rbX - ltX, rbY - ltY);
    [_mapView setVisibleMapRect:rect];
    _mapView.zoomLevel = _mapView.zoomLevel - 0.3;
}

- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation {
    
    [self.mapView updateLocationData:userLocation];
    NSLog(@"heading is %@",userLocation.heading);
}

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {

    self.userCoor = userLocation.location.coordinate;
    [self.mapView updateLocationData:userLocation];
}

@end
