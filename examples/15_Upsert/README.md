# Upsert Examples

Demonstrates `PresentationPlayer.upsert()` for creating and updating Salesforce records from LSC Intelligent Content presentations.

## Demo Structure

This example uses **5 slides**, each covering different Salesforce objects:

| File | Objects | Description |
|------|---------|-------------|
| `01_Upsert_Account.html` | Account, Person Account | Account/Person Account toggle — insert/update Accounts, update-only Person Accounts, with Explain panel |
| `02_Upsert_Address.html` | Address, ContactPointAddress | Physical addresses and contact point addresses linked to Accounts |
| `03_Upsert_Visit.html` | Visit, ProviderVisit | Visit scheduling/status and provider-specific visit context |
| `04_Upsert_Product.html` | Product2 | Product catalog entries with batch upsert example |
| `05_Upsert_Custom.html` | Adverse_Event_Report__c, Clinical_Trial_Enrollment__c | Custom objects for adverse event reporting and clinical trial enrollment |

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

## Callback Format

```javascript
function myCallback(data) {
    if (data.state === 'success') {
        // Record saved
    } else {
        console.log('Error: ' + data.message);
        console.log('Code: ' + data.code);
    }
}
```

## Field Blacklisting

Some fields are **create-only** and cannot be sent on updates. Common errors:

| Error Code | Meaning |
|------------|---------|
| `OCE_UPSERT_FIELD_VALIDATION_FAILED` | One or more fields in your payload failed validation |
| `OCE_UPSERT_FIELD_BLACKLISTED` | The field is blacklisted for the operation (e.g., name fields on update) |

**Account (business):** Uses the `Name` field. Supports both insert and update via upsert.

**Person Account:** Cannot be created via upsert. All Person Account name fields (`FirstName`, `LastName`, `Salutation`, `MiddleName`, `Suffix`) and `PersonBirthdate` are **blacklisted** for both insert and update, returning `OCE_UPSERT_FIELD_BLACKLISTED`. Person Accounts can only be **updated** for non-name fields like `Type`.

## Sync After Upsert

Records created or updated via `upsert()` are saved to the **local database first**. The user must sync (pull to refresh or wait for the next automatic sync cycle) to push the record to the server. Until synced, the record only exists on the device.

## Limits

- Max **15 records** per upsert call
- Cannot create/update: User, Record Type, Territory, Territory2, UserTerritory2Association
- Cannot update related records in a single call
- Person Accounts cannot be created via upsert — all name fields and `PersonBirthdate` are blacklisted for insert and update
- Person Accounts can only be updated for non-name fields like `Type`

## Objects Covered

1. **Account / Person Account** — Account insert/update with Name field; Person Account update-only (name fields blacklisted)
2. **Address** — Physical location linked to an Account
3. **ContactPointAddress** — Mailing/contact address for consent workflows
4. **Visit** — Scheduled rep-account interaction
5. **ProviderVisit** — Provider-specific context within a Visit
6. **Product2** — Product catalog entry
7. **Adverse_Event_Report__c** — Adverse event reporting during provider visits
8. **Clinical_Trial_Enrollment__c** — Clinical trial interest and patient enrollment tracking

## See Also

- [05_Data_Query](../05_Data_Query/README.md) for `fetchWithParams` and basic upsert
- [Salesforce Help: Upsert Function](https://help.salesforce.com/s/articleView?language=en_US&id=ind.lsc_presentation_function_upsert.htm&type=5)
