//
//  Coordinate+Annotation.m
//  CCLocationManager
//
//  Created by sidoufu on 15/4/7.


#import "Coordinate+Annotation.h"

@implementation Coordinate (Annotation)


- (CLLocationCoordinate2D)coordinate
{
    CLLocationCoordinate2D coordinate;
    
    coordinate.latitude = [self.latitude doubleValue];
    coordinate.longitude = [self.longitude doubleValue];
    
    return coordinate;
}

- (NSString *)title
{
//    NSString *address = [NSString new];
//    address = self.address;
    return self.address;
}

/*- (NSString *)subtitle
{
    return @"#17-1-402";
}*/
@end
