//
//  iCarousel.h
//
//  Version 1.8.3
//
//  Created by Nick Lockwood on 01/04/2011.
//  Copyright 2011 Charcoal Design
//
//  Distributed under the permissive zlib License
//  Get the latest version from here:
//
//  https://github.com/nicklockwood/iCarousel
//
//  This software is provided 'as-is', without any express or implied
//  warranty.  In no event will the authors be held liable for any damages
//  arising from the use of this software.
//
//  Permission is granted to anyone to use this software for any purpose,
//  including commercial applications, and to alter it and redistribute it
//  freely, subject to the following restrictions:
//
//  1. The origin of this software must not be misrepresented; you must not
//  claim that you wrote the original software. If you use this software
//  in a product, an acknowledgment in the product documentation would be
//  appreciated but is not required.
//
//  2. Altered source versions must be plainly marked as such, and must not be
//  misrepresented as being the original software.
//
//  3. This notice may not be removed or altered from any source distribution.
//


#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunknown-pragmas"
#pragma clang diagnostic ignored "-Wreserved-id-macro"
#pragma clang diagnostic ignored "-Wobjc-missing-property-synthesis"


#import <Availability.h>
#undef weak_delegate
#undef __weak_delegate
#if __has_feature(objc_arc) && __has_feature(objc_arc_weak) && \
(!(defined __MAC_OS_X_VERSION_MIN_REQUIRED) || \
__MAC_OS_X_VERSION_MIN_REQUIRED >= __MAC_10_8)
#define weak_delegate weak
#else
#define weak_delegate unsafe_unretained
#endif


#import <QuartzCore/QuartzCore.h>
#if defined USING_CHAMELEON || defined __IPHONE_OS_VERSION_MAX_ALLOWED
#define ICAROUSEL_IOS
#else
#define ICAROUSEL_MACOS
#endif


#ifdef ICAROUSEL_IOS
#import <UIKit/UIKit.h>
#else
#import <Cocoa/Cocoa.h>
typedef NSView UIView;
#endif


typedef NS_ENUM(NSInteger, iCarouselType)
{
    iCarouselTypeLinear = 0,
    iCarouselTypeRotary,
    iCarouselTypeInvertedRotary,
    iCarouselTypeCylinder,
    iCarouselTypeInvertedCylinder,
    iCarouselTypeWheel,
    iCarouselTypeInvertedWheel,
    iCarouselTypeCoverFlow,
    iCarouselTypeCoverFlow2,
    iCarouselTypeTimeMachine,
    iCarouselTypeInvertedTimeMachine,
    iCarouselTypeCustom
};


typedef NS_ENUM(NSInteger, iCarouselOption)
{
    
    /**
     一个布尔值，表示滚动条滚动到最后是否环绕。
     如果您希望carousel到达结束时环绕则返回YES，否则返回 NO。
     一般来说，循环carousel类型将默认为环绕，而线性转盘类型不会环绕。 不要担心返回类型是浮点值，因为除0.0之外的任何值都将被视为YES。
     */
    iCarouselOptionWrap = 0,
    
    /**
     对于某些carousel类型，例如 iCarouselTypeCylinder，
     可以看到某些视图的后侧（默认情况下，iCarouselTypeInvertedCylinder隐藏背面）。
     如果您希望隐藏后视图，您可以为此选项返回 NO。
     要重写iCarouselTypeInvertedCylinder的默认背景隐藏，
     可以返回YES。 此选项也可用于导致视图背面显示的自定义轮播转换。
     */
    iCarouselOptionShowBackfaces,
    
    
    /**
     用户用手指拖动转盘时使用的偏移倍数。
     它不影响程序滚动或减速速度。
     对于大多数轮播类型，默认值为1.0，
     但对于CoverFlow样式的 carousel，默认值为2.0，
     以补偿其项目间隔更紧密的事实，
     因此必须进一步拖动以移动相同的距离。
     */
    iCarouselOptionOffsetMultiplier,
    
    
    /**
     这是一次应该在轮播中可见的视图（包括占位符）的最大数量。
     这一数量的一半视图将显示在当前所选项目索引的两边。
     超出该视图的视图在滚动到视图之前将不会被加载。
     这是考虑到carousel 中大量 item 会对性能产生不好的影响.。iCarousel根据轮播类型选择合适的默认值，如果您希望重写该值可以使用这个属性（例如，自定义的轮播类型）。
     */
    iCarouselOptionVisibleItems,
    
    
    /**
     在 Rotary,Cylinder 和 Wheel 类型中显示的 item 的数量。
     通常，这是根据轮播中的视图大小和item 的数量自动计算的，
     但如果要更精确地控制carousel的显示，则可以重写此选项。
     该属性用于计算 carousel半径，因此另一个选项是直接操作半径。
     */
    iCarouselOptionCount,
    
    /**
     Rotary，Cylinder和Wheel 类型的弧线转换（弧度）。
     通常默认为2 * M_PI（一个完整的圆），
     但您可以指定较小的值，因此例如，M_PI的值将创建一个半圆或圆柱。
     该属性用于计算圆盘传送带半径和角度步长，
     因此另一个选项是直接操作这些值。
     */
    iCarouselOptionArc,
    
    /**
     旋转，圆柱和轮的半径以像素/点转换。
     为了可见item显示的数量更好的适应特定的弧度,这个值通常被计算 。
     您可以操作该值来增加或减少项目间距（以及圆的半径）
     */
    iCarouselOptionAngle,
    
    /**
     Rotary，Cylinder和Wheel之间的每个项目之间的角度步长（以弧度表示）。 在不改变半径的情况下,在 carousel 滚动到最后时改变间隙或使item 交叠。
     */
    iCarouselOptionRadius,
    
    
    /**
     tilt用于CoverFlow，CoverFlow2和TimeMachine的 carousel类型中的非居中项目。 该值应在0.0到1.0的范围内。
     */
    iCarouselOptionTilt,
    
    /**
     项目视图之间的间距。
     该值乘以项目宽度（或高度，如果carousel 是垂直的），
     以获得每个项目之间的总空间，
     因此值为1.0（默认值）表示视图之间没有空隙（除非视图已经包括填充，因为 他们在许多示例项目中做）。
     */
    iCarouselOptionSpacing,
    
    
    /**
     这三个选项根据它们与当前居中的item的偏移量来控制carousel的视图的淡出。
      FadeMin是item视图在开始淡入之前可以达到的最小负偏移量。 FadeMax是视图在开始淡化之前可以达到的最大正偏移量。
      FadeRange是项目可以在开始褪色的点与完全不可见的点之间移动的距离。
     */
    iCarouselOptionFadeMin,
    iCarouselOptionFadeMax,
    iCarouselOptionFadeRange,
    iCarouselOptionFadeMinAlpha
};


NS_ASSUME_NONNULL_BEGIN

@protocol iCarouselDataSource, iCarouselDelegate;

@interface iCarousel : UIView

@property (nonatomic, weak_delegate) IBOutlet __nullable id<iCarouselDataSource> dataSource;
@property (nonatomic, weak_delegate) IBOutlet __nullable id<iCarouselDelegate> delegate;

/*
 用来变换carousel展示样式
 */
@property (nonatomic, assign) iCarouselType type;

/*
用于调整各种3D轮播视图的透视缩小效果。
超出此范围的值将产生非常奇怪的结果。
默认值为-1/500或-0.005。
 */
@property (nonatomic, assign) CGFloat perspective;


/*
 这个率用于carousel被快速轻击时carousel减速率。值越大表示减速越慢。
 默认值是0.95.值应该在 0.0 和 1.0 之间。
 0.0表示:设置为这个值时，carousel被释放时立即停止滚动
 1.0表示:设置为这个值时，carousel继续无限滚动而不减速，直到它到达底部
 */
@property (nonatomic, assign) CGFloat decelerationRate;

/*
 这是当用户用手指轻击carousel时 滚动速度乘数。默认值是1.0.
 */
@property (nonatomic, assign) CGFloat scrollSpeed;


/*
 一个非包裹样式的carousel在超过底部时将弹跳的最大距离。
 这个用itemWidth的倍数来衡量的，
 所以1.0这个值意味着弹跳一整个item的宽度，
 0.5这个值是一个item宽度的一半，以此类推。
 默认值是1.0.
 */
@property (nonatomic, assign) CGFloat bounceDistance;

/*
 使能或者禁止用户滚动carousel。
 如果这个值被设为no，carousel仍然可以以编程方式被滚动。
 */
@property (nonatomic, assign, getter = isScrollEnabled) BOOL scrollEnabled;

/*
 是否支持翻页
 */
@property (nonatomic, assign, getter = isPagingEnabled) BOOL pagingEnabled;

/*
 这个属性切换，不管carousel 是水平展示还是垂直展示的。
 所有内嵌的carousel样式在这两个方向上都可以运行。
 切换到垂直将会改变carousel的布局和屏幕上的切换方向。
 --***--注意，
 自定义的carousel 变换不受这个属性影响，但是，切换手势的方向还是会受影响。
 */
@property (nonatomic, assign, getter = isVertical) BOOL vertical;


/*
 如果打包被使能的话，返回yes，如果不是返回no。
 这个属性是只读的。
 如果你想重写这个默认值，
 实现carousel:valueForOption:withDefault:方法且给iCarouselOptionWrap返回一个值。
 */
@property (nonatomic, readonly, getter = isWrapEnabled) BOOL wrapEnabled;

/*
 设置carousel在超出底部和返回时是否应该弹跳，或者是停止并挂掉。
 --***--注意，
 在carousel样式设置为缠绕样式时或者carouselShouldWrap代理方法返回为yes时，这个属性不起作用。
 */
@property (nonatomic, assign) BOOL bounces;


/*
 这是以itemWidth的整数倍来计算的carousel当前的滚动偏移量，
 这个值，被截取为最接近的整数，是currentItemIndex值。
 当carousel运动中，你可以使用这个值定位其他屏幕的元素。
 这个值也可以被编程方式设置如果你想滚动carousel到一个特定的偏移。
 如果你想禁用内置手势处理并提供自己的实现时，这个可能有用。
 */
@property (nonatomic, assign) CGFloat scrollOffset;


/*
 这是当用户用手指拖动carousel时偏移量的乘数。
 它并不影响编程的滚动和减速的速度。
 对大多数carousel样式这个默认值是1.0，
 但是对CoverFlow-style样式的carousels默认值是2.0，
 来弥补他们的items在空间上更紧凑，
 所以必须拖拽更远来移动相同的距离的事实。
 你不能直接设置这个值，
 但是可以通过实现carouselOffsetMultiplier:代理方法来重写默认值。
 这个应该是滑动一下移动的距离。
 */
@property (nonatomic, readonly) CGFloat offsetMultiplier;


/*
 这个属性用来调整carousel item views相对于carousel中心的边距。
 它的默认值是CGSizeZero，意思是carousel items是居中的。
 改变这个属性的值来移动carousel items而不必改变他们的视觉。
 消失点随着carousel items移动，
 所以，如果你把carousel items移动到下边，
 如果你在carousel上向下看时他就不会出现。
 */
@property (nonatomic, assign) CGSize contentOffset;


/**
 这个属性用来调整相对于carousel items的 用户视点，
 它与调整contentOffset 效果相反。
 如果你向上移动视点，而carousel 显示是向下移动。
 与 contentOffset不同，移动视点也会改变和carousel items有关的视角消失点，
 所以如果你向上移动视点，他就会像你在carousel上向下看一样出现。
 */

@property (nonatomic, assign) CGSize viewpointOffset;

/*
 carousel中 items的数量（只读），要设置他的话，实现 numberOfItemsInCarousel:这个数据源方法。
 --***--注意，
 所有这些item views在一个给定的时间点将会被加载或者可见
 －carousel当它滚动的时候经要求加载item views。
 */
@property (nonatomic, readonly) NSInteger numberOfItems;


/*
 在carousel中展示的占位视图的数量（只读）。
 要设置他，实现一下numberOfPlaceholdersInCarousel:这个数据源方法。
 */
@property (nonatomic, readonly) NSInteger numberOfPlaceholders;


/*
 当前carousel中居中的item 的索引，
 设置这个属性相当于调用scrollToItemAtIndex:animated:方法时将 animated参数设置为no。
 */
@property (nonatomic, assign) NSInteger currentItemIndex;

/*
 当前carousel中居中的item view。
 这个视图的索引与currentItemIndex匹配。
 */
@property (nonatomic, strong, readonly) UIView * __nullable currentItemView;

/*
 一个包含了所有当前加载的和在carousel中可见的item views的索引，
 包括占位视图的数组，这个数组包含NSNumber的对象，他们的整数值与视图的索引匹配。
 这些item views的索引从0开始且与加载视图时数据源传递的索引匹配，
 然而，任何占位视图的索引将是负数或者大于等于numberOfItems。
 数组中的placeholder views 的索引并不等于数据源中使用的占位视图的索引。
 */
@property (nonatomic, strong, readonly) NSArray *indexesForVisibleItems;

/*
 同时显示在屏幕上的carousel itemviews的最大数量（只读）。
 这个属性对执行最优化很重要，且是基于carousel的样式和视图的frame被自动计算的。
 如果你想重写这个默认值，
 实现一下 carousel:valueForOption:withDefault:
 这个代理方法且给iCarouselOptionVisibleItems返回一个值。
 */
@property (nonatomic, readonly) NSInteger numberOfVisibleItems;


/*
 一个存放当前carousel中展示的所有item views的 数组（只读），
 它包括任何可见的占位视图。
 这个数组中视图的索引并不与item的索引匹配，
 然而，这些视图的顺序与visibleItemIndexes数组属性中的顺序匹配，
 你可以通过从visibleItemIndexes 数组中去掉对应的对象来在这个数组中获取一个指定视图的索引
 （或者，你可以仅仅用indexOfItemView:方法，这个会更简单）
 */
@property (nonatomic, strong, readonly) NSArray *visibleItemViews;

/*
 carousel中展示的items的宽度（只读）。
 这是自动从使用carousel:viewForItemAtIndex:reusingView:数据源方法第一个传到carousel中的视图中继承来的。
 你也可以使用carouselItemWidth:代理方法重写这个值，
 这个方法会改变分配给carousel items的空间（但是不会对这些item views重写设置大小或规模）。
 */
@property (nonatomic, readonly) CGFloat itemWidth;

/*
 包含carousel item views的视图。
 你可以增加子视图如果你想用这些carousel items散置这些视图。
 如果你想让一个视图出现在所有carouselitems的前边或者后边，
 你应该直接添加它到iCarousel view本身来替代。
 --***--注意，
 在contentView中视图的顺序是受当app执行时的频率和未标注的变化决定的。
 任何添加到contentView中的视图
 应该将他们的 userInteractionEnabled属性设置为no,
 来防止和iCarousel的触摸时间处理放生冲突。
 */
@property (nonatomic, strong, readonly) UIView *contentView;

/*
 这个属性用于iCarouselTypeCoverFlow2的carousel变换。
 它是被暴露的以便于你可以使用
 carousel:itemTransformForOffset:baseTransform:
 代理方法实现自己的CoverFlow2样式变量。
 */
@property (nonatomic, readonly) CGFloat toggle;


@property (nonatomic, assign) CGFloat autoscroll;

/**
 当设置为YES时，点击任何在carousel 中的item而不是那个匹配currentItemIndex 的视图，将会使平滑动画移动到居中位置。点击当前被选中的item将没有效果。默认值是YES
 */
@property (nonatomic, assign) BOOL stopAtItemBoundary;

/*
 默认情况下，不管carousel何时停止移动，
 他会自动滚动到最近的item 边界。
 如果你设置这个属性为no，
 carousel停止后将不会滚动且不管在哪儿他都会停下来，
 即使他不是正好对准当前的索引。
 有一个特例，如果打包效果被禁止且bounces被设置为yes，
 然后，不管这个设置是什么，carousel会自动滚回第一个或者最后一个索引，
 如果它停下来时超出了carousel的底部。
 */
@property (nonatomic, assign) BOOL scrollToItemBoundary;


/*
 如果为yes,carousel将会忽略垂直于carousel方向的切换手势。
 目前，一个水平的carousel，垂直切换将不会被拦截。
 这就意味着你可以获得一个在carouselitem view里的垂直滚动的scrollView切它依然会正确工作。
 默认值为yes。
 */
@property (nonatomic, assign) BOOL ignorePerpendicularSwipes;

/*
 当设置为yes时，
 点击任何在carousel 中的item而不是那个匹配currentItemIndex 的视图，
 将会使平滑动画移动到居中位置。
 点击当前被选中的item将没有效果。默认值是yes。
 */
@property (nonatomic, assign) BOOL centerItemWhenSelected;


/**
 洪加的
 */

/**
 滚动间隔
 */
@property(nonatomic, readwrite, assign)float scrollInterval;


@property (nonatomic, readonly, getter = isDragging) BOOL dragging;
@property (nonatomic, readonly, getter = isDecelerating) BOOL decelerating;
@property (nonatomic, readonly, getter = isScrolling) BOOL scrolling;

- (void)scrollByOffset:(CGFloat)offset duration:(NSTimeInterval)duration;
- (void)scrollToOffset:(CGFloat)offset duration:(NSTimeInterval)duration;
- (void)scrollByNumberOfItems:(NSInteger)itemCount duration:(NSTimeInterval)duration;
- (void)scrollToItemAtIndex:(NSInteger)index duration:(NSTimeInterval)duration;
- (void)scrollToItemAtIndex:(NSInteger)index animated:(BOOL)animated;

- (nullable UIView *)itemViewAtIndex:(NSInteger)index;
- (NSInteger)indexOfItemView:(UIView *)view;
- (NSInteger)indexOfItemViewOrSubview:(UIView *)view;
- (CGFloat)offsetForItemAtIndex:(NSInteger)index;
- (nullable UIView *)itemViewAtPoint:(CGPoint)point;

- (void)removeItemAtIndex:(NSInteger)index animated:(BOOL)animated;
- (void)insertItemAtIndex:(NSInteger)index animated:(BOOL)animated;
- (void)reloadItemAtIndex:(NSInteger)index animated:(BOOL)animated;

- (void)reloadData;

@end


@protocol iCarouselDataSource <NSObject>

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel;
- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(nullable UIView *)view;

@optional

- (NSInteger)numberOfPlaceholdersInCarousel:(iCarousel *)carousel;
- (UIView *)carousel:(iCarousel *)carousel placeholderViewAtIndex:(NSInteger)index reusingView:(nullable UIView *)view;

@end


@protocol iCarouselDelegate <NSObject>
@optional

- (void)carouselWillBeginScrollingAnimation:(iCarousel *)carousel;
- (void)carouselDidEndScrollingAnimation:(iCarousel *)carousel;
- (void)carouselDidScroll:(iCarousel *)carousel;
- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel;
- (void)carouselWillBeginDragging:(iCarousel *)carousel;
- (void)carouselDidEndDragging:(iCarousel *)carousel willDecelerate:(BOOL)decelerate;
- (void)carouselWillBeginDecelerating:(iCarousel *)carousel;
- (void)carouselDidEndDecelerating:(iCarousel *)carousel;

- (BOOL)carousel:(iCarousel *)carousel shouldSelectItemAtIndex:(NSInteger)index;
- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index;

- (CGFloat)carouselItemWidth:(iCarousel *)carousel;
- (CATransform3D)carousel:(iCarousel *)carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform;
- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value;

@end

NS_ASSUME_NONNULL_END

#pragma clang diagnostic pop

