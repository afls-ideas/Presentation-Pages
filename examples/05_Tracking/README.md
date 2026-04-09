# Tracking Functions

Track presentation metrics with click stream entry records.

## PresentationPlayer.startTrackingPage()

Starts tracking presentation metrics in a new presentation click stream entry record for the specified presentation page.

**Mobile only.**

### Syntax
```javascript
PresentationPlayer.startTrackingPage(pageid)
```

### Arguments

| Argument | Description |
|----------|-------------|
| `pageid` | The ID of the page to start tracking. Accepts any string as the ID for the current slide. |

---

## PresentationPlayer.stopTrackingPage()

Stops tracking presentation metrics for the current slide.

**Mobile only.**

### Syntax
```javascript
PresentationPlayer.stopTrackingPage()
```

**Arguments:** None

---

## Typical Usage Pattern

```javascript
// Start tracking when page appears
PresentationPlayer.registerEventListener('viewappearing', function() {
    PresentationPlayer.startTrackingPage('my_page_id');
});

// Stop tracking when page disappears
PresentationPlayer.registerEventListener('viewdisappearing', function() {
    PresentationPlayer.stopTrackingPage();
});

// Pause/resume with player controls
PresentationPlayer.registerEventListener('pausebuttonpress', function() {
    PresentationPlayer.stopTrackingPage();
});

PresentationPlayer.registerEventListener('playbuttonpress', function() {
    PresentationPlayer.startTrackingPage('my_page_id');
});
```
