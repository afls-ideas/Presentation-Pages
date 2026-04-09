# Email Functions

Launch email templates from LSC presentations.

## PresentationPlayer.launchApprovedEmail()

Opens the Send Email window with the email template linked to the current presentation page. If there's no email template ID on the presentation page, the page isn't linked to a template.

**Mobile only.**

### Syntax
```javascript
PresentationPlayer.launchApprovedEmail()
```

**Arguments:** None

---

## PresentationPlayer.launchEmails()

Opens the Send Email window with the specified email templates available to the user.

**Mobile only.**

### Syntax
```javascript
PresentationPlayer.launchEmails(templates)
```

### Arguments

| Argument | Description |
|----------|-------------|
| `templates` | A comma-separated list of email template names. If left blank, users see all templates available for the selected territory. |

### Example
```javascript
// Launch specific templates
PresentationPlayer.launchEmails('Template_A, Template_B');

// Launch all available templates
PresentationPlayer.launchEmails('');
```

---

## Email Template Functions

These functions are used **inside email template HTML files**, not in presentation pages:

### EmailTemplate.fetchWithParams()
```javascript
EmailTemplate.fetchWithParams(query, params, callbackMethod)

// Example:
EmailTemplate.fetchWithParams(
    'SELECT Id, Name FROM Account',
    {'batchSize': 100},
    'getAccountRecordsCallback'
);
```
- Max 100 records per call
- Supports aggregated and relationship queries
- Use separate queries for related records

### EmailTemplate.fetchValidationFailed()
```javascript
EmailTemplate.fetchValidationFailed(string)

// Example - prevent sending if data is missing:
if (!el.Name) {
    EmailTemplate.fetchValidationFailed('Name is missing');
}
```
- Prevents sending emails with empty or invalid query data
- Users see the error message and must remove the account from recipients

### Email Template Rules
- Place JavaScript inside `<script type="text/javascript">` tags
- Avoid `setTimeout`, `setInterval`, and promises
- Use parent-based CSS styles (not global like `div {background: red}`)
- Can't query Long Text Area fields with a WHERE clause
- Child relationship queries aren't supported

## Email Attachment Best Practices
- Include a PDF file in the ZIP for email attachments
- Use `required__` prefix in the file name to make attachment mandatory
- PDFs under 3 MB are auto-attached to the presentation page record
- For larger files, add the PDF manually
