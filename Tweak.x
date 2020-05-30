#import "ping.h"
#import <AudioToolbox/AudioServices.h>
BOOL enabled;


%group ping
    %hook NCNotificationShortLookView
    - (void)layoutSubviews {
        NSString *titlee = self.primaryText;
        // Checking if there's content in title, if not leaving default
        if ([titlee length] == 0) {
        } else {
            self.title = titlee;
        }
        %orig;
        if ([self.secondaryText length] <= 2) {
            self.secondaryText = @"";
        }
        // Setting background colour
        NSArray<__kindof UIView *> *subs = self.subviews;
        UIView *transparent = subs[0];
        [transparent setHidden:YES];
        self.layer.cornerRadius = radius;

        self.primaryText = @"";

        // Setting notification colour
        int onTop = 1;
        for (UIView *sub in subs) {
            if (onTop == 2) {
                // Setting upper radius
                UIBezierPath *maskPath;
                maskPath = [UIBezierPath bezierPathWithRoundedRect:sub.bounds
                                                 byRoundingCorners:(UIRectCornerTopRight |UIRectCornerTopLeft)
                                                       cornerRadii:CGSizeMake(radius, radius)];
                CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
                maskLayer.frame =sub.bounds;
                maskLayer.path = maskPath.CGPath;
                sub.layer.mask = maskLayer;
                sub.backgroundColor = [UIColor colorWithRed:red / 255.0f green:green / 255.0f blue:blue / 255.0f alpha:1.00];
            } else {
                // Setting bottom radius
                UIBezierPath *maskPath;
                maskPath = [UIBezierPath bezierPathWithRoundedRect:sub.bounds
                                                 byRoundingCorners:(UIRectCornerBottomRight | UIRectCornerBottomLeft)
                                                       cornerRadii:CGSizeMake(radius, radius)];
                CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
                maskLayer.frame = sub.bounds;
                maskLayer.path = maskPath.CGPath;
                sub.layer.mask = maskLayer;
                sub.backgroundColor = [UIColor colorWithRed:red / 255.0f green:green / 255.0f blue:blue / 255.0f alpha:1.00];
            }
            onTop = onTop + 1;
        }
    }
    %end

    // TODO: Add per app titles

    // Changing the notifications text
    %hook NCNotificationListHeaderTitleView
        - (void)layoutSubviews {
            %orig;
            // Checking if it's an app name
            UIView *parent = self.superview.superview.superview.superview.superview.superview;
            NSString *description = parent.description;
            NSString *newTitle = [settings valueForKey:self.title];
            if ([description containsString:@"<CSMainPageView"]) {
                self.title = title;
            } else {
                // Then checking if the user has defined a custom title, if they have set the title to that.
                if (newTitle == nil) {
                } else {
                    // Setting text with out Ellipsis
                    UILabel *t = self.subviews[0].subviews[0];
                    t.text = newTitle;
                    t.minimumScaleFactor = 8./factLabel.font.pointSize;
                    t.adjustsFontSizeToFitWidth = YES;
                }
            }
        }
    %end

    // Removing shadow in popup

    %hook NCNotificationViewController
        - (void)viewDidLoad {
            %orig;
            self.hasShadow = false;
        }
    %end

    // Changing action cell colour

    %hook NCNotificationListCellActionButton
        - (void)layoutSubviews {
            UIView *actionButton = self.subviews[0];
            actionButton.backgroundColor = [UIColor colorWithRed:red / 255.0f green:green / 255.0f blue:blue / 255.0f alpha:1.00];
            // Need to do it first or it flickers in
            %orig;
        }
    %end
%end

%ctor {
    // Getting preferences and seeing if tweak is enabled
    // And setting defaults
    settings = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/me.justnaaa.Pingpref.plist"] ?: [@{} mutableCopy];
    BOOL enabled = [[settings objectForKey:@"enableTweak"] ?: @(YES) boolValue];
    radius = [[settings objectForKey:@"notificationRadius"] ?: @10 intValue];
    red = [[settings objectForKey:@"redAmount"] ?: @39 intValue];
    green = [[settings objectForKey:@"greenAmount"] ?: @52 intValue];
    blue = [[settings objectForKey:@"blueAmount"] ?: @65 intValue];
    title = [NSString stringWithFormat:@"%@", [[settings valueForKey:@"notificationsText"] ?: @"Notifications" stringValue] ];
    if (enabled) {
        %init(ping);
    }
}