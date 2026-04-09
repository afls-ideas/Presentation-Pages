# Alerts & Logging

Display native alerts and log errors in LSC presentations.

## PresentationPlayer.alert()

Opens a native alert dialog on the user's mobile device with the specified message.

**Mobile only.**

### Syntax
```javascript
PresentationPlayer.alert(message)
```

### Arguments

| Argument | Description |
|----------|-------------|
| `message` | The message to show to the user. |

### Example
```javascript
// After a successful upsert
function upsertCallback(data) {
    if (data.state === 'success') {
        PresentationPlayer.alert('Record saved successfully!');
    } else {
        PresentationPlayer.alert(data.message + '\n' + data.code);
    }
}
```

---

## PresentationPlayer.logError()

Logs error messages within the presentation player. Useful for debugging and tracking issues.

**Mobile only.**

### Syntax
```javascript
PresentationPlayer.logError(errorMessage)
```

### Arguments

| Argument | Description |
|----------|-------------|
| `errorMessage` | The specific error message to include in the log. |

### Limits
- Error messages are tracked per **individual presentation page**
- Maximum **10** error messages per page
- In the Life Sciences Cloud mobile app, these events are logged for review

### Example
```javascript
function getAccountsCallback(data) {
    if (data.state === 'success') {
        // Process records
    } else {
        PresentationPlayer.logError('Query failed: ' + data.message);
    }
}
```
