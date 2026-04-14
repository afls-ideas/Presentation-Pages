# Upsert — Account

Demonstrates `PresentationPlayer.upsert()` for creating and updating Account and HealthcareProvider records from LSC Intelligent Content presentations.

## Demo Structure

| File | Description |
|------|-------------|
| `01_Upsert_Account.html` | Account/Person Account upsert with HealthcareProvider chaining on insert |

## Features

- **Account Type toggle** — Switch between Account and Person Account
- **Operation toggle** — Insert (new) or Update (existing)
- **Account selector** — Dropdown of existing accounts (Update mode)
- **Chained upsert** — On Account insert, automatically creates a linked HealthcareProvider record
- **Results panel** — Shows request JSON (`>>>`) and response (`<<<`) for each upsert call
- **Explain panel** — Slide-out documentation with syntax, fields, and examples

## Syntax

```javascript
PresentationPlayer.upsert(objects, callbackMethod)
```

| Argument | Description |
|----------|-------------|
| `objects` | Array of record objects (max 15 per call) |
| `callbackMethod` | String name of a global callback function |

## Create vs Update

- **Create:** Omit the `id` field — a new record is created
- **Update:** Include the `id` field — the existing record is updated

Every record object must include `sobject` to specify the target object type.

## Account Insert + HealthcareProvider Chain

When inserting a new Account, the callback uses the returned `data.ids[0]` to create a linked HealthcareProvider:

```javascript
// Step 1: Create Account
PresentationPlayer.upsert([{
  'sobject': 'Account',
  'Name': 'Acme Healthcare',
  'Type': 'Customer'
}], 'onAccountUpserted');

// Step 2 (in callback): Create HealthcareProvider
PresentationPlayer.upsert([{
  'sobject': 'HealthcareProvider',
  'AccountId': data.ids[0],
  'Name': 'Acme Healthcare'
}], 'onHCPUpserted');
```

## Field Blacklisting

| Error Code | Meaning |
|------------|---------|
| `OCE_UPSERT_FIELD_VALIDATION_FAILED` | One or more fields in your payload failed validation |
| `OCE_UPSERT_FIELD_BLACKLISTED` | The field is blacklisted for the operation |

**Account (business):** Uses the `Name` field. Supports both insert and update.

**Person Account:** Cannot be created via upsert. All Person Account name fields (`FirstName`, `LastName`, `Salutation`, `MiddleName`, `Suffix`) and `PersonBirthdate` are **blacklisted** for both insert and update, returning `OCE_UPSERT_FIELD_BLACKLISTED`. Person Accounts can only be **updated** for non-name fields like `Type`.

## Sync After Upsert

Records created or updated via `upsert()` are saved to the **local database first**. The user must sync (pull to refresh or wait for the next automatic sync cycle) to push the record to the server. Until synced, the record only exists on the device.

## Limits

- Max **15 records** per upsert call
- Cannot create/update: User, Record Type, Territory, Territory2, UserTerritory2Association
- Cannot update related records in a single call
- Person Accounts cannot be created via upsert
- Person Accounts can only be updated for non-name fields like `Type`

## See Also

- [16_Create_Visit](../16_Create_Visit/README.md) for `createVisit` function
- [05_Data_Query](../05_Data_Query/README.md) for `fetchWithParams`
- [Salesforce Help: Upsert Function](https://help.salesforce.com/s/articleView?language=en_US&id=ind.lsc_presentation_function_upsert.htm&type=5)
