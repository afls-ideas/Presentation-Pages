# Dynamic Content (Mustache Templates & JSON Access)

Display dynamic Salesforce data in LSC Intelligent Content presentations using Mustache templates and JavaScript.

## Mustache Template Syntax

The presentation player uses a Mustache template processor. Before each page loads, data is collected as JSON and fed into the processor to fill placeholders.

### Customer Loop
```html
{{#customers}}
  Name: {{firstName}} {{lastName}}
  Type: {{accountType}}           <!-- HCP for Person Accounts, HCO for Business -->
  Specialty: {{healthcareProviderSpecialties.0.name}}
{{/customers}}
```

### Presentation Info
```html
{{#presentations}}
  Name: {{name}}
  {{#isCustom}}Custom presentation{{/isCustom}}
  {{^isCustom}}Standard presentation{{/isCustom}}
{{/presentations}}
```

### User and Visit Info
```html
Rep: {{user.name}}
Visit ID: {{visits.0.id}}
```

## Supported Attributes

### Account Objects (in `customers` node)

| Object | Fields | Notes |
|--------|--------|-------|
| Account | All standard and custom fields | `accountType` returns HCP/HCO. `recordType` returns name and ID. |
| ContactPointAddress | Associated address records | Only active records. Uses preferred address > primary > most recent. |
| ContactPointEmail | Associated email records | Only primary records, ordered by preference rank. |
| ContactPointPhone | Associated phone records | Only primary records, ordered by preference rank. |
| ContactPointSocials | Associated social records | Ordered by social platform provider. |
| HealthCareProvider | All fields on related record | - |
| HealthcareProviderSpecialties | Array of specialties | Active + primary only, ordered by most recently modified. |

### Presentation Fields

| Field | Description |
|-------|-------------|
| `id` | Presentation ID |
| `name` | Presentation name |
| `sourceSystemIdentifier` | External identifier |
| `Pages` | Array with: id, sourceSystemIdentifier, contentDocumentId, name, slides (name) |
| `isCustom` | `true` if created by field user, `false` if standard |

### User Objects

| Object | Fields |
|--------|--------|
| User | All standard and custom fields |
| UserAdditionalInfo | All fields on associated record |
| LifeScienceMobileApp | Device data (location, last download sync date) - mobile only |

### Visit Fields

| Field | Description |
|-------|-------------|
| `id` | Visit ID |
| `accountId` | Account ID |
| `isParent` | `true` when Parent Visit field is blank |
| `sourceSystemIdentifier` | External identifier |

### Top-Level JSON Fields

| Field | Description |
|-------|-------------|
| `currentMode` | Current mode of the presentation player |
| `currentTerritoryId` | ID of the current territory |
| `currentTerritoryName` | Name of the current territory |
| `emailTemplateId` | Email template ID associated with current page |
| `state` | Saved state of the presentation (mobile app) |
| `presentationIndex` | Index in presentations array |
| `pageIndex` | Index in pages array |
| `slideIndex` | Index in slides array |

## JavaScript Access

### PresentationDOMContentLoaded Event
```javascript
var configData;
document.addEventListener('PresentationDOMContentLoaded', function(event) {
    configData = event.data;
});
```

### Mustache Shorthand
```javascript
var configData = {{{.}}};
```

## Rules & Limitations

- Formula and lookup fields are **not** supported
- Standard Salesforce fields: no prefix or suffix
- Custom fields: use the `__c` suffix
- Mustache variables must be **lowercase** (e.g., `accounttype`)
- Users must have access to the objects and fields referenced
