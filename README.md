# LSC Intelligent Content - Presentation Page Examples

A comprehensive collection of working examples for Life Sciences Cloud (LSC) Intelligent Content presentation pages. Each example demonstrates specific PresentationPlayer API functions with ready-to-use HTML slides.

## Repository Structure

```
Presentation-Pages/
├── input/                          # Source files
│   ├── IC_Guide.pdf               # Official IC documentation
│   └── immunexis_*.zip            # Baseline presentation slides
├── slides/                         # Unzipped baseline slides
│   ├── immunexis_01_Intro/
│   ├── immunexis_02_Risks/
│   ├── immunexis_03_Graph/
│   └── immunexis_04_Survey/
├── shared/                         # Shared assets for examples
│   ├── js/                        # jQuery, swipe.js
│   ├── fonts/                     # Montserrat font files
│   └── images/                    # Logo and background images
└── examples/                       # API examples by category
    ├── 01_Navigation/             # goNextPage, goPreviousPage, goToSlide
    ├── 02_Dynamic_Content/        # Mustache templates, JSON data access
    ├── 03_Data_Query/             # fetchWithParams, upsert
    ├── 04_Visit_Management/       # createVisit, updateFeedback
    ├── 05_Tracking/               # startTrackingPage, stopTrackingPage
    ├── 06_State_Management/       # saveState, disableDismiss/enableDismiss
    ├── 07_Alerts_Logging/         # alert, logError
    ├── 08_Email/                  # launchApprovedEmail, launchEmails
    ├── 09_Survey/                 # getSurveyFlowJson, setSurveyFlowJson
    ├── 10_Swipe_Regions/          # defineNoSwipeRegion, destroyNoSwipeRegion
    ├── 11_Event_Listeners/        # registerEventListener (8 iOS events)
    └── 12_Additional_Content/     # PDFs, videos, iFrames, external links
```

## PresentationPlayer API Quick Reference

| Function | Description | Desktop | Mobile |
|----------|-------------|---------|--------|
| `goNextPage()` | Go to next page | Yes | Yes |
| `goPreviousPage()` | Go to previous page | Yes | Yes |
| `goToSlide(target, slide, animation)` | Navigate to specific page/slide | Yes | Yes |
| `alert(message)` | Show native alert | No | Yes |
| `createVisit(callback)` | Create visit for attendees | No | Yes |
| `defineNoSwipeRegion(id, x, y, w, h)` | Disable swipe in region | No | Yes |
| `destroyNoSwipeRegion(id)` | Remove no-swipe region | No | Yes |
| `disableDismiss()` | Prevent player dismissal | No | Yes |
| `enableDismiss()` | Allow player dismissal | No | Yes |
| `fetchWithParams(query, params, callback)` | Run SOQL query | No | Yes |
| `getSurveyFlowJson(object)` | Load survey data | No | Yes |
| `launchApprovedEmail()` | Open linked email template | No | Yes |
| `launchEmails(templates)` | Open email with templates | No | Yes |
| `logError(message)` | Log error (max 10/page) | No | Yes |
| `saveState(state)` | Save presentation state | No | Yes |
| `setSurveyFlowJson(object, state)` | Save survey results | No | Yes |
| `startTrackingPage(pageid)` | Start click stream tracking | No | Yes |
| `stopTrackingPage()` | Stop tracking current slide | No | Yes |
| `updateFeedback(type)` | Set HCP feedback reaction | No | Yes |
| `upsert(objects, callback)` | Create/update records | No | Yes |
| `registerEventListener(event, handler)` | Listen for iOS events | No | Yes |

## Supported iOS Events (registerEventListener)

| Event | Description |
|-------|-------------|
| `cancelbuttonpress` | User selects Cancel button |
| `pausebuttonpress` | User selects Pause button |
| `playbuttonpress` | User selects Play button |
| `returntovisitbuttonpress` | User selects Visit button |
| `viewappearing` | Page is opened |
| `viewdisappearing` | Page is closed |
| `surveyflowjsonloaded` | getSurveyFlowJson completes |
| `surveyflowjsonpassedtovisit` | Triggered before visit opens |

## Dynamic Content (Mustache Templates)

The presentation player uses a Mustache template processor. Key variables:

```html
<!-- Customer loop -->
{{#customers}}
  Name: {{firstName}} {{lastName}}
  Type: {{accountType}}  <!-- HCP for Person, HCO for Business -->
  Specialty: {{healthcareProviderSpecialties.0.name}}
{{/customers}}

<!-- User info -->
{{user.name}} / {{user.firstName}} / {{user.lastName}}

<!-- Presentation info -->
{{#presentations}}
  {{name}} - {{#isCustom}}Custom{{/isCustom}}{{^isCustom}}Standard{{/isCustom}}
{{/presentations}}
```

Access raw JSON via JavaScript:
```javascript
var configData;
document.addEventListener('PresentationDOMContentLoaded', function(event) {
    configData = event.data;
});
```

## ZIP File Requirements

Each presentation page is a separate ZIP file containing:

| Content | Required | Naming |
|---------|----------|--------|
| HTML file | Yes | `XX_name.html` (XX = page number, start at 01) |
| JPEG thumbnail | Yes | `XX_thumbnail.jpg` (328x232px optimal) |
| CSS/JS files | Optional | Referenced by HTML |

- File name format: `XX_name.zip` (XX = page number)
- Valid characters: A-Z, a-z, 0-9, and `-`, `.`, `_`, `!`, `*`, `'`, `(`, `)`
- Max ZIP size: 1 GB
- Extensions must be lowercase
- HTML and JPEG must be at top level; CSS/JS can be in folders

## Getting Started

1. Browse the `examples/` folder for the API function you need
2. Each example has a README.md with documentation and an HTML file you can preview
3. Copy the HTML patterns into your own presentation pages
4. Package as ZIP files following the naming conventions above
5. Upload to Life Sciences Customer Engagement

## Important Notes

- Avoid `setTimeout`, `setInterval`, and promises in email templates
- Compress images before adding to presentations
- Design for iPad responsive display (2388x1668px for iPad Pro)
- Test presentations on supported mobile devices
- Formula and lookup fields are not supported in Mustache variables
- Custom Salesforce fields use the `__c` suffix in Mustache variables
