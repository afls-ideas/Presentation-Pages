# Data Query & Upsert

Query Salesforce data and create/update records from within LSC presentations.

## PresentationPlayer.fetchWithParams()

Queries data not already returned in Mustache variables and returns results to a callback.

**Mobile only.** Requires active object metadata cache configurations synced to the mobile app.

### Syntax
```javascript
PresentationPlayer.fetchWithParams(query, params, callbackMethod)
```

### Arguments

| Argument | Description |
|----------|-------------|
| `query` | SOQL query string, or `queryLocator` value for pagination. Supports: SELECT (columns, relations, aggregates - no subqueries), FROM (one object), WHERE (AND, OR, NOT; IN, LIKE, =, <, >; subqueries, literal sets), GROUP BY, HAVING, ORDER BY, LIMIT, OFFSET. Literals: INT, FLOAT, STRING, NULL, BOOLEAN. |
| `params` | Optional. Object with `batchSize` (number of records per call, max 100). |
| `callbackMethod` | Name of the JavaScript function to receive results. |

### Returns (JSON)

| Field | Type | Description |
|-------|------|-------------|
| `records` | Array | Result data |
| `done` | Boolean | `true` if all data queried, `false` if more pages |
| `totalSize` | Integer | Total records processed |
| `queryLocator` | String | Unique ID for fetching next batch |
| `state` | String | `success` or `error` |

### Usage
- Default batch size is **15** if not specified
- Maximum **100** records per call regardless of batch size
- Can query: User, Account, Record Type, Territory2, UserTerritory2Association, LSC objects, custom objects
- User must have Read permissions on queried objects/fields

### Pagination Example
```javascript
function getAccounts() {
    PresentationPlayer.fetchWithParams(
        'SELECT Id FROM Account',
        {'batchSize': 15},
        'getAccountsCallback'
    );
}

function getAccountsCallback(data) {
    // Process data.records...
    if (!data.done) {
        PresentationPlayer.fetchWithParams(
            data.queryLocator,
            {'batchSize': 15},
            'getAccountsCallback'
        );
    }
}
```

---

## PresentationPlayer.upsert()

Creates and updates records for specified objects.

**Mobile only.** Objects must be allowlisted by Salesforce Support. Requires active object metadata cache configurations.

### Syntax
```javascript
PresentationPlayer.upsert(objects, callbackMethod)
```

### Arguments

| Argument | Description |
|----------|-------------|
| `objects` | Array of objects. To create: specify `sobject` and field values. To update: also include `id` (record ID or offline ID). |
| `callbackMethod` | Name of the JavaScript function to receive results. |

### Returns
Array of IDs of the new or updated records.

### Create Example
```javascript
PresentationPlayer.upsert([{
    'sobject': 'Account',
    'name': 'New Account',
    'customField__c': 'value'
}], 'upsertCallback');
```

### Update Example
```javascript
PresentationPlayer.upsert([{
    'sobject': 'Account',
    'id': accountId,
    'name': 'Updated Name',
    'customField__c': 'new value'
}], 'upsertCallback');
```

### Limitations
- Max **15** records per call
- Cannot create/update: User, Record Type, Territory, Territory2, UserTerritory2Association
- Cannot create/update related records in a single call (use two calls for parent-child)
- Don't use `upsert` to create visits (use `createVisit` instead)

### Errors
- Validation rules fail
- User lacks Read or Edit access
- Object or field not supported
- SQLite database query errors
