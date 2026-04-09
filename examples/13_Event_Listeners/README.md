# Event Listeners

Register handlers for iOS presentation player events in LSC presentations.

## PresentationPlayer.registerEventListener()

Registers a JavaScript function to handle a specific iOS event from the presentation player.

**Mobile only.**

### Syntax
```javascript
PresentationPlayer.registerEventListener(iOS_event, handler)
```

### Arguments

| Argument | Description |
|----------|-------------|
| `iOS_event` | The name of the event to listen for (see table below). |
| `handler` | A JavaScript function to execute when the event fires. |

### Supported Events

| Event | Description |
|-------|-------------|
| `cancelbuttonpress` | User tapped the Cancel button |
| `pausebuttonpress` | User tapped the Pause button |
| `playbuttonpress` | User tapped the Play button |
| `returntovisitbuttonpress` | User tapped the Visit button (return to visit) |
| `viewappearing` | The presentation page is about to appear on screen |
| `viewdisappearing` | The presentation page is about to disappear |
| `surveyflowjsonloaded` | Survey flow JSON has been loaded (from getSurveyFlowJson) |
| `surveyflowjsonpassedtovisit` | Survey flow JSON was passed back to the visit |

### Examples
```javascript
// Auto-start tracking when page appears
PresentationPlayer.registerEventListener('viewappearing', function() {
    PresentationPlayer.startTrackingPage('myPage');
});

// Save state when leaving
PresentationPlayer.registerEventListener('viewdisappearing', function() {
    PresentationPlayer.stopTrackingPage();
    PresentationPlayer.saveState(JSON.stringify(currentState));
});

// Handle Visit button with dismiss control
PresentationPlayer.registerEventListener('returntovisitbuttonpress', function() {
    PresentationPlayer.disableDismiss();
    PresentationPlayer.upsert([record], 'upsertCallback');
});

// Handle survey data
PresentationPlayer.registerEventListener('surveyflowjsonloaded', function(data) {
    var survey = JSON.parse(data);
    renderSurvey(survey);
});
```

### Notes
- Each event can have only one handler registered at a time
- Events are specific to the current presentation page
- The `returntovisitbuttonpress` event is sent only to the currently open presentation
- `viewappearing` fires each time the page comes into view (including returns from other pages)
