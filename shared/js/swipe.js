// Initialize touch support
var touchSupport = ('ontouchstart' in window) || (navigator.maxTouchPoints > 0) || (navigator.msMaxTouchPoints > 0);
var touchEvents = touchSupport ? {
    start: 'touchstart',
    move: 'touchmove',
    end: 'touchend'
} : {
    start: 'mousedown',
    move: 'mousemove',
    end: 'mouseup'
};

// Custom swipe event
$.event.special.swipe = {
    setup: function() {
        var self = this;
        var $self = $(self);
        var startX, startY, endX, endY, startTime, endTime;
        var minSwipeDistance = 50;
        var maxSwipeTime = 500;

        $self.on(touchEvents.start, function(e) {
            var touch = e.originalEvent.touches ? e.originalEvent.touches[0] : e;
            startX = touch.pageX;
            startY = touch.pageY;
            startTime = new Date().getTime();
        });

        $self.on(touchEvents.move, function(e) {
            if (!startX) return;
            e.preventDefault();
        });

        $self.on(touchEvents.end, function(e) {
            if (!startX) return;
            var touch = e.originalEvent.changedTouches ? e.originalEvent.changedTouches[0] : e;
            endX = touch.pageX;
            endY = touch.pageY;
            endTime = new Date().getTime();

            var deltaX = endX - startX;
            var deltaY = endY - startY;
            var deltaTime = endTime - startTime;

            if (deltaTime <= maxSwipeTime && Math.abs(deltaX) >= minSwipeDistance && Math.abs(deltaY) < Math.abs(deltaX)) {
                var direction = deltaX > 0 ? 'right' : 'left';
                $self.trigger('swipe', [direction]);
            }

            startX = startY = null;
        });
    }
};

// Bind swipe events when document is ready
$(document).ready(function() {
    // Prevent swipe on elements with .no-swipe class
    $('.no-swipe').on('touchstart touchmove touchend', function(e) {
        e.stopPropagation();
    });

    // Bind swipe events to CLMPlayer navigation
    $(document).on('swipe', function(e, direction) {
        if (direction === 'left') {
            CLMPlayer.goNextSequence();
        } else if (direction === 'right') {
            CLMPlayer.goPreviousSequence();
        }
    });

    // Initialize native swipe regions
    if (window.webkit && window.webkit.messageHandlers && window.webkit.messageHandlers.nativeCall) {
        // Define no-swipe regions if needed
        $('.no-swipe').each(function(index) {
            var $el = $(this);
            var offset = $el.offset();
            CLMPlayer.defineNoSwipeRegion(
                'no-swipe-' + index,
                offset.left,
                offset.top,
                $el.width(),
                $el.height()
            );
        });
    }
}); 