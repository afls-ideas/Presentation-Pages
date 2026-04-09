# Examples Guide

Detailed documentation for each LSC Intelligent Content example in this repository. Each example is a working presentation page demonstrating specific PresentationPlayer API functions.

All examples include:
- **HTML source** — the presentation page you can preview in a browser
- **JPEG thumbnail** — placeholder thumbnail for the ZIP package
- **README.md** — API documentation with syntax, arguments, and usage patterns
- **Pre-built ZIP** — ready to upload in `output/`

---

## 01 — Navigation

**Directory:** [`examples/01_Navigation/`](examples/01_Navigation/)
**ZIPs:** `output/01_Navigation.zip`, `output/02_Navigation_PageB.zip`, `output/03_Navigation_PageC.zip`
**Platform:** Desktop + Mobile

A 3-page mini presentation demonstrating all navigation functions. This is the only multi-page example — upload all 3 ZIPs together to see navigation in action.

### Functions Covered

| Function | Description |
|----------|-------------|
| `PresentationPlayer.goNextPage()` | Move to the next page in order |
| `PresentationPlayer.goPreviousPage()` | Move to the previous page in order |
| `PresentationPlayer.gotoSlide(identifier, slideName, animation)` | Jump to any page by name, ID, or external ID |

### Pages

| File | Role |
|------|------|
| `01_Navigation.html` | Page 1 — Next button, jump-to-Page-3 with animation options |
| `02_Navigation_PageB.html` | Page 2 — Previous/Next buttons, jump to any page |
| `03_Navigation_PageC.html` | Page 3 — Previous button, jump back to Page 1, API summary |

### Key Patterns

- **Sequential navigation:** `PresentationPlayer.goNextPage()` / `PresentationPlayer.goPreviousPage()`
- **Direct jump by page name:** `PresentationPlayer.gotoSlide('Navigation PageC', '01_Navigation_PageC.html', 'swipeleft')`
- **Animation options:** `'noanimation'`, `'swipeleft'`, `'swiperight'`, or `null`
- **Retrieving Page IDs from JSON** using `{{{.}}}` Mustache shorthand or `PresentationDOMContentLoaded` event

### Gotcha — Mustache in Code Blocks

LSC's Mustache processor scans **all** HTML content including `<script>` tags. To display Mustache syntax as documentation text (e.g., `{{{.}}}`), build the strings via JavaScript:

```javascript
var ob = String.fromCharCode(123); // {
var cb = String.fromCharCode(125); // }
element.textContent = ob+ob+ob + '.' + cb+cb+cb;
```

---

## 02 — Dynamic Content

**Directory:** [`examples/02_Dynamic_Content/`](examples/02_Dynamic_Content/)
**ZIP:** `output/04_Dynamic_Content.zip`
**Platform:** Desktop + Mobile

Demonstrates Mustache template syntax and live `configData` JSON display. The left panel shows template examples; the right panel renders the actual JSON structure from the player so users can explore available fields.

### What It Shows

- **Customer loop** — `{{#customers}}...{{/customers}}` with name, type, specialty
- **User info** — `{{user.name}}`, `{{user.firstName}}`
- **Presentation info** — `{{#presentations}}...{{/presentations}}` with page arrays
- **Live JSON viewer** — Sections for top-level fields, presentations/pages, customers, user, and full raw JSON
- **configData loading** via `{{{.}}}` in a dedicated `<script>` block

### Supported Mustache Variables

- **Account fields** — All standard + custom fields, ContactPointAddress/Email/Phone, HealthcareProviderSpecialties
- **Presentation fields** — id, name, Pages array (id, name, slides), isCustom
- **User fields** — All User fields, UserAdditionalInfo, LifeScienceMobileApp (device data, mobile only)
- **Visit fields** — id, accountId, isParent, sourceSystemIdentifier
- **Top-level** — currentMode, currentTerritoryId, emailTemplateId, state, presentationIndex, pageIndex

---

## 03 — Data Query

**Directory:** [`examples/03_Data_Query/`](examples/03_Data_Query/)
**ZIP:** `output/05_Data_Query.zip`
**Platform:** Mobile only

Query Salesforce records with SOQL and create/update records from within presentations.

### Functions Covered

| Function | Description |
|----------|-------------|
| `PresentationPlayer.fetchWithParams(query, params, callback)` | Run SOQL queries with pagination |
| `PresentationPlayer.upsert(objects, callback)` | Create or update Salesforce records |

### Key Details

- **fetchWithParams** — Default batch size 15, max 100 per call. Supports SELECT, WHERE, GROUP BY, ORDER BY, LIMIT, OFFSET. Use `queryLocator` for pagination.
- **upsert** — Max 15 records per call. Specify `sobject` + fields to create; add `id` to update. Objects must be allowlisted by Salesforce Support.
- Cannot upsert User, RecordType, Territory objects
- Cannot create visits with upsert (use `createVisit` instead)

---

## 04 — Visit Management

**Directory:** [`examples/04_Visit_Management/`](examples/04_Visit_Management/)
**ZIP:** `output/06_Visit_Management.zip`
**Platform:** Mobile only

Create visits and capture HCP feedback reactions during presentations.

### Functions Covered

| Function | Description |
|----------|-------------|
| `PresentationPlayer.createVisit(callback)` | Create a visit for selected attendees |
| `PresentationPlayer.updateFeedback(type)` | Set HCP reaction: `'Positive'`, `'Negative'`, `'Neutral'`, or `null` |

### Key Details

- **createVisit** — Invoke only once per session. Returns `{state, id}`. Creates provider visit, product detailing, click stream records.
- **updateFeedback** — Updates the provider visit detailing product message record. Pass `null` to clear.
- If a visit already exists for the session, `createVisit` returns the existing visit ID.

---

## 05 — Tracking

**Directory:** [`examples/05_Tracking/`](examples/05_Tracking/)
**ZIP:** `output/07_Tracking.zip`
**Platform:** Mobile only

Track presentation metrics with click stream entry records.

### Functions Covered

| Function | Description |
|----------|-------------|
| `PresentationPlayer.startTrackingPage(pageid)` | Start tracking for a page (any string as ID) |
| `PresentationPlayer.stopTrackingPage()` | Stop tracking the current slide |

### Typical Pattern

```javascript
PresentationPlayer.registerEventListener('viewappearing', function() {
    PresentationPlayer.startTrackingPage('my_page_id');
});
PresentationPlayer.registerEventListener('viewdisappearing', function() {
    PresentationPlayer.stopTrackingPage();
});
```

---

## 06 — State Management

**Directory:** [`examples/06_State_Management/`](examples/06_State_Management/)
**ZIP:** `output/08_State_Management.zip`
**Platform:** Mobile only

Save and restore presentation state, and control player dismiss behavior.

### Functions Covered

| Function | Description |
|----------|-------------|
| `PresentationPlayer.saveState(state)` | Save a string (typically JSON) to `configData.state` |
| `PresentationPlayer.disableDismiss()` | Prevent player from closing |
| `PresentationPlayer.enableDismiss()` | Re-allow closing (must call within 30 seconds) |

### Key Details

- State is stored per **presentation + visit** combination
- Read saved state via `configData.state` on next load
- `disableDismiss`/`enableDismiss` are used with `returntovisitbuttonpress` to run long operations before closing

---

## 07 — Alerts & Logging

**Directory:** [`examples/07_Alerts_Logging/`](examples/07_Alerts_Logging/)
**ZIP:** `output/09_Alerts_Logging.zip`
**Platform:** Mobile only

Display native alerts and log errors for debugging.

### Functions Covered

| Function | Description |
|----------|-------------|
| `PresentationPlayer.alert(message)` | Show a native alert dialog |
| `PresentationPlayer.logError(errorMessage)` | Log an error (max 10 per page) |

---

## 08 — Email

**Directory:** [`examples/08_Email/`](examples/08_Email/)
**ZIP:** `output/10_Email.zip`
**Platform:** Mobile only

Launch email templates from presentations.

### Functions Covered

| Function | Description |
|----------|-------------|
| `PresentationPlayer.launchApprovedEmail()` | Open the email template linked to the current page |
| `PresentationPlayer.launchEmails(templates)` | Open Send Email with specified template names (comma-separated) |

### Also Covers

- **EmailTemplate.fetchWithParams()** — Query data inside email template HTML
- **EmailTemplate.fetchValidationFailed()** — Prevent sending with invalid data
- **Email attachment rules** — `required__` prefix, 3 MB auto-attach limit

---

## 09 — Survey

**Directory:** [`examples/09_Survey/`](examples/09_Survey/)
**ZIP:** `output/11_Survey.zip`
**Platform:** Mobile only

Get and set survey flow JSON data.

### Functions Covered

| Function | Description |
|----------|-------------|
| `PresentationPlayer.getSurveyFlowJson(options)` | Request survey flow by `developerName` |
| `PresentationPlayer.setSurveyFlowJson(surveyJson, state)` | Save (`'save'`) or submit (`'submit'`) survey responses |

### Key Details

- `getSurveyFlowJson` is async — results arrive via the `surveyflowjsonloaded` event
- `'save'` = draft (resumable), `'submit'` = final (creates records)
- `surveyflowjsonpassedtovisit` fires when JSON is passed back to the visit

---

## 10 — Swipe Regions

**Directory:** [`examples/10_Swipe_Regions/`](examples/10_Swipe_Regions/)
**ZIP:** `output/12_Swipe_Regions.zip`
**Platform:** Mobile only

Define rectangular regions where swipe gestures are disabled.

### Functions Covered

| Function | Description |
|----------|-------------|
| `PresentationPlayer.defineNoSwipeRegion(id, x, y, w, h)` | Create a no-swipe zone (pixels) |
| `PresentationPlayer.destroyNoSwipeRegion(id)` | Remove a no-swipe zone by ID |

### Use Cases

- Carousels and sliders
- Drawing canvases
- Drag-and-drop interfaces
- Any interactive element that conflicts with swipe navigation

---

## 11 — Event Listeners

**Directory:** [`examples/11_Event_Listeners/`](examples/11_Event_Listeners/)
**ZIP:** `output/13_Event_Listeners.zip`
**Platform:** Mobile only

Register handlers for all 8 iOS presentation player events.

### Function

```javascript
PresentationPlayer.registerEventListener(iOS_event, handler)
```

### Supported Events

| Event | When It Fires |
|-------|---------------|
| `cancelbuttonpress` | User taps Cancel |
| `pausebuttonpress` | User taps Pause |
| `playbuttonpress` | User taps Play |
| `returntovisitbuttonpress` | User taps Visit button |
| `viewappearing` | Page comes into view |
| `viewdisappearing` | Page leaves view |
| `surveyflowjsonloaded` | `getSurveyFlowJson` completes |
| `surveyflowjsonpassedtovisit` | Survey JSON passed to visit |

---

## 12 — Additional Content

**Directory:** [`examples/12_Additional_Content/`](examples/12_Additional_Content/)
**ZIP:** `output/14_Additional_Content.zip`
**Platform:** Desktop + Mobile

Include supplementary files (PDFs, videos, HTML pages) alongside your presentation page.

### Content Types

| Type | Filename Pattern | How to Reference |
|------|-----------------|------------------|
| PDF | `isadditionalcontent_*.pdf` | `<a href="isadditionalcontent_study.pdf">` |
| Video | `isadditionalcontent_*.mp4` / `.mov` / `.m4v` | `<video>` tag or `<a href>` |
| HTML | `isadditionalcontent_*.html` | `<iframe src="isadditionalcontent_tool.html">` |
| External URL | N/A | `<a href="https://..." target="_blank">` |

### Email Attachments

- `required__document.pdf` — mandatory attachment (always sent)
- `isadditionalcontent_supplement.pdf` — optional attachment
- PDFs under 3 MB are auto-attached to the presentation page record
