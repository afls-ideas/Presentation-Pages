# Visit Management

Create visits and capture HCP feedback during LSC presentations.

## PresentationPlayer.createVisit()

Creates a visit for the selected attendees and returns the result to a callback. When visits are created, Salesforce applies all configured visit validations.

**Mobile only.** Recommend invoking only once per presentation session.

### Syntax
```javascript
PresentationPlayer.createVisit(callbackMethod)
```

### Arguments

| Argument | Description |
|----------|-------------|
| `callbackMethod` | Name of the JavaScript function that receives the results. |

### Returns (JSON)

**Success:**
```json
{"state": "success", "id": "<parent_visit_uid>"}
```

**Error:**
```json
{"state": "error", "errorMessage": "<error>", "id": "<optional_id_of_previously_created_visit>"}
```

### Usage
- Users can select the Visit button in the presentation player menu to open the visit
- All presentation metrics tracked during the session are linked to the visit
- If no attendees were selected, the account field on the visit is blank
- Product restrictions and presentation targeting apply

### Related Records Created
- Provider visit
- Provider visit product detailing
- Provider visit detailing product message
- Presentation forum
- Presentation click stream entry

### Errors
- Validation rules fail
- A visit was already created during the presentation session (returns the existing visit ID)
- The presentation player is opened for an existing visit (returns that visit ID)
- The presentation player is opened in a context unrelated to the visit

### Limitations
- The `createVisit` function doesn't populate the new visit's details into Mustache variables that reference visits
- Don't use `upsert` to create visits

---

## PresentationPlayer.updateFeedback()

Sets the feedback from the healthcare professional (HCP) to the specified type during presentations. Updates the related provider visit detailing product message record.

**Mobile only.**

### Syntax
```javascript
PresentationPlayer.updateFeedback(type)
```

### Arguments

| Argument | Description |
|----------|-------------|
| `type` | The feedback type: `'Positive'`, `'Negative'`, `'Neutral'`, or `null` (clears feedback). |

### Example
```html
<a href="javascript:PresentationPlayer.updateFeedback('Positive');">
    I like the presentation
</a>
```
