# Swipe Region Control

Define and destroy no-swipe regions to prevent navigation gestures in specific areas of LSC presentations.

## PresentationPlayer.defineNoSwipeRegion()

Creates a rectangular region on the screen where swipe gestures are ignored. Useful for interactive elements like sliders, carousels, or drawing areas that shouldn't trigger page navigation.

**Mobile only.**

### Syntax
```javascript
PresentationPlayer.defineNoSwipeRegion(regionId, x, y, width, height)
```

### Arguments

| Argument | Description |
|----------|-------------|
| `regionId` | A unique string identifier for the region. |
| `x` | The x-coordinate (left edge) of the region in pixels. |
| `y` | The y-coordinate (top edge) of the region in pixels. |
| `width` | The width of the region in pixels. |
| `height` | The height of the region in pixels. |

### Example
```javascript
// Protect a carousel area from triggering navigation
PresentationPlayer.defineNoSwipeRegion('carousel', 100, 200, 800, 400);

// Protect a drawing canvas
PresentationPlayer.defineNoSwipeRegion('canvas', 0, 100, 1024, 600);
```

---

## PresentationPlayer.destroyNoSwipeRegion()

Removes a previously defined no-swipe region, re-enabling swipe gestures in that area.

**Mobile only.**

### Syntax
```javascript
PresentationPlayer.destroyNoSwipeRegion(regionId)
```

### Arguments

| Argument | Description |
|----------|-------------|
| `regionId` | The unique identifier of the region to remove. Must match the ID used in `defineNoSwipeRegion`. |

### Example
```javascript
// Remove a no-swipe region
PresentationPlayer.destroyNoSwipeRegion('carousel');
```

### Notes
- Regions persist until explicitly destroyed or the page unloads
- Multiple regions can be active simultaneously
- Coordinates are relative to the presentation viewport
- Use this when you have interactive elements (carousels, sliders, drag-and-drop) that conflict with swipe navigation
