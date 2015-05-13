//
//  IMAnimatedTableViewHandler.m
//  IBM
//
//  Created by Yury on 12/25/13.
//  Gist: https://gist.github.com/8123997.git
//
//  Edited by Igor Ferreira on 5/13/15.
//

#import "IMAnimatedTableViewHandler.h"
#import <UIKit/UIKit.h>

@interface IMAnimatedTableViewHandler() <UITableViewDelegate>

@property (nonatomic, assign) UIImageOrientation scrollOrientation;
@property (nonatomic, assign) CGPoint lastPos;

@end

@implementation IMAnimatedTableViewHandler

-(instancetype)initWithTableView:(UITableView*)tableView
{
    self = [super init];
    if(self) {
        tableView.delegate = self;
    }
    return self;
}

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.isDragging) {
        UIView *myView = cell.contentView;
        CALayer *layer = myView.layer;
        CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
        rotationAndPerspectiveTransform.m34 = 1.0 / -1000;
        if (self.scrollOrientation == UIImageOrientationDown) {
            rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, M_PI*0.5, 1.0f, 0.0f, 0.0f);
        } else {
            rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, -M_PI*0.5, 1.0f, 0.0f, 0.0f);
        }
        layer.transform = rotationAndPerspectiveTransform;
        [UIView animateWithDuration:.5 animations:^{
            layer.transform = CATransform3DIdentity;
        }];
    }
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    self.scrollOrientation = scrollView.contentOffset.y > self.lastPos.y?UIImageOrientationDown:UIImageOrientationUp;
    self.lastPos = scrollView.contentOffset;
}

@end