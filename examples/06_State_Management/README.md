# State Management & Dismiss Control

Save presentation state and control dismiss behavior in LSC presentations.

## PresentationPlayer.saveState()

Saves data about the presentation's state to the `state` property in the JSON. Stores the state on the user's mobile device so users can resume where they left off.

**Mobile only.**

### Syntax
```javascript
PresentationPlayer.saveState(state)
```

### Arguments

| Argument | Description |
|----------|-------------|
| `state` | Any string representing the state, typically JSON. Examples: current slide position, user preferences, progress tracking. |

### Usage
- State values are stored per **presentation + visit** combination
- When users resume a presentation from a visit, they return to their previous state
- The saved state is available via `configData.state` on next load

### Reading Saved State
```javascript
document.addEventListener('PresentationDOMContentLoaded', function(event) {
    var savedState = event.data.state;
    if (savedState) {
        var state = JSON.parse(savedState);
        // Resume from saved position
    }
});
```

---

## PresentationPlayer.disableDismiss() / enableDismiss()

Control how the presentation player is closed and handled when users select the Visit button. Use these to execute long-running operations in the `returntovisitbuttonpress` event handler.

**Mobile only.**

### Syntax
```javascript
PresentationPlayer.disableDismiss()
PresentationPlayer.enableDismiss()
```

### Important Rules
- `enableDismiss()` **must** be called within **30 seconds** or the player is dismissed automatically
- These functions control only the **currently open** presentation
- The `returntovisitbuttonpress` event is sent only to the currently open presentation

### Recommended Pattern
```javascript
// Disable dismiss when page opens
PresentationPlayer.registerEventListener('viewappearing', function() {
    PresentationPlayer.disableDismiss();
});

// On Visit button: do work, then enable dismiss
PresentationPlayer.registerEventListener('returntovisitbuttonpress', function() {
    // Execute long-running operations
    PresentationPlayer.saveState(JSON.stringify({completed: true}));
    PresentationPlayer.upsert([...], 'callback');
    // Allow dismissal
    PresentationPlayer.enableDismiss();
});
```

### Multi-Presentation Sessions
Users can save data from multiple presentations in one session by selecting the Visit button after presenting a custom presentation. The `returntovisitbuttonpress` event triggers for the current presentation, and upsert requests execute. Users can then use the Return to Presentation link to return to the session.
