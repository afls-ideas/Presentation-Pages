# Navigation Functions

Navigate between pages and slides within LSC Intelligent Content presentations.

## Demo Structure

This example uses **3 slides** to demonstrate navigation in action:

| File | Description |
|------|-------------|
| `01_Navigation.html` | Page 1 — API docs for goNextPage/goPreviousPage/goToSlide, with buttons to navigate forward or jump to Page 3 |
| `02_Navigation_PageB.html` | Page 2 — Middle page with Previous/Next buttons and jump-to-page options |
| `03_Navigation_PageC.html` | Page 3 — Last page with navigation summary and jump back to Page 1 |

**Note:** The web player uses `goNextSequence`/`goPreviousSequence` while the iPad uses `goNextPage`/`goPreviousPage`. The `gotoSlide` method works on both platforms. See the cross-platform pattern below.

In production, each HTML file would be packaged as a separate ZIP (e.g., `01_Navigation.zip`, `02_Navigation_PageB.zip`, `03_Navigation_PageC.zip`).

---

## Next / Previous Page Navigation

Goes to the next or previous page in the presentation. Does nothing if already on the first/last page.

**Important:** The method names differ between platforms:

| Platform | Next Page | Previous Page |
|----------|-----------|---------------|
| **Web (Desktop)** | `PresentationPlayer.goNextSequence()` | `PresentationPlayer.goPreviousSequence()` |
| **iPad (Mobile)** | `PresentationPlayer.goNextPage()` | `PresentationPlayer.goPreviousPage()` |

### Cross-platform pattern
```javascript
function goNext() {
    if (typeof PresentationPlayer.goNextSequence === 'function') {
        PresentationPlayer.goNextSequence();
    } else {
        PresentationPlayer.goNextPage();
    }
}

function goPrev() {
    if (typeof PresentationPlayer.goPreviousSequence === 'function') {
        PresentationPlayer.goPreviousSequence();
    } else {
        PresentationPlayer.goPreviousPage();
    }
}
```

**Arguments:** None

---

## PresentationPlayer.gotoSlide()

Goes to the specified page within a presentation. Use unique names or IDs to ensure the correct page opens.

**Available on:** Desktop (Web) and Mobile (iPad)

### Syntax
```javascript
PresentationPlayer.gotoSlide([PageId|PageName|SourceSystemIdentifier], slideName, animation)
```

### Arguments

| Argument | Description |
|----------|-------------|
| `PageId` | The ID of a page (`PresentationPage.Id`). If left blank, the current page is used. |
| `PageName` | The name of a presentation page (`PresentationPage.Name`). |
| `SourceSystemIdentifier` | An optional external ID (`PresentationPage.SourceSystemIdentifier`). |
| `slideName` | The HTML filename inside the target ZIP. |
| `animation` | `'noanimation'` (or null), `'swipeleft'`, `'swiperight'`. Swipe animations can affect performance. |

---

## Retrieving Page ID from JSON

Before using goToSlide with a PageId, retrieve it from the presentation JSON:

```javascript
var configData;
document.addEventListener('PresentationDOMContentLoaded', function(event) {
    configData = event.data;
    var pages = configData.presentations[configData.presentationIndex].Pages;
    var targetPageId = pages[2].id; // third page (index 2)
});

// Jump to that page
PresentationPlayer.gotoSlide(targetPageId, '03_Navigation_PageC.html', 'swipeleft');
```

Or use the Mustache shorthand:

```javascript
var configData = {{{.}}};
var targetPageId = configData.presentations[configData.presentationIndex].Pages[2].id;
```
