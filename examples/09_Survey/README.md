# Survey Flow

Get and set survey flow JSON data in LSC presentations.

## PresentationPlayer.getSurveyFlowJson()

Retrieves the survey flow JSON for a specified survey. The result is delivered asynchronously via the `surveyflowjsonloaded` event.

**Mobile only.**

### Syntax
```javascript
PresentationPlayer.getSurveyFlowJson(options)
```

### Arguments

| Argument | Description |
|----------|-------------|
| `options` | An object with a `developerName` property specifying the survey flow to retrieve. |

### Example
```javascript
// Request the survey flow
PresentationPlayer.getSurveyFlowJson({
    developerName: 'Patient_Satisfaction_Survey'
});

// Listen for the result
PresentationPlayer.registerEventListener('surveyflowjsonloaded', function(data) {
    var surveyData = JSON.parse(data);
    // Process survey flow JSON
});
```

---

## PresentationPlayer.setSurveyFlowJson()

Saves or submits survey flow JSON data. Use this to persist survey responses.

**Mobile only.**

### Syntax
```javascript
PresentationPlayer.setSurveyFlowJson(surveyJson, state)
```

### Arguments

| Argument | Description |
|----------|-------------|
| `surveyJson` | The survey flow JSON object containing responses. |
| `state` | Either `'save'` (draft, can be resumed) or `'submit'` (final, creates records). |

### Example
```javascript
// Save as draft
PresentationPlayer.setSurveyFlowJson(surveyData, 'save');

// Submit final responses
PresentationPlayer.setSurveyFlowJson(surveyData, 'submit');
```

### Notes
- Use `save` to allow users to resume the survey later
- Use `submit` to finalize responses and create survey records
- The `surveyflowjsonpassedtovisit` event fires when the survey JSON is passed back to the visit
