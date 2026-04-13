# Navigation — Page 3 of 3

Last page in the 3-page navigation demo. Upload all 3 navigation ZIPs together to see navigation in action.

## What This Page Shows

- **Previous button** — uses `goPreviousSequence()` on web, `goPreviousPage()` on iPad
- **Jump back to Page 1** using `gotoSlide()` with swipe animation
- **Navigation API summary** — quick reference of all navigation functions with platform differences

## Platform Difference

| Action | Web (Desktop) | iPad (Mobile) |
|--------|---------------|---------------|
| Next page | `PresentationPlayer.goNextSequence()` | `PresentationPlayer.goNextPage()` |
| Previous page | `PresentationPlayer.goPreviousSequence()` | `PresentationPlayer.goPreviousPage()` |
| Jump to page | `PresentationPlayer.gotoSlide()` | `PresentationPlayer.gotoSlide()` |

## Related Pages

| ZIP | Page | Description |
|-----|------|-------------|
| `01_Navigation.zip` | Page 1 | API docs, forward navigation, jump to Page 3 |
| `02_Navigation_PageB.zip` | Page 2 | Previous/Next, jump to any page |
| **`03_Navigation_PageC.zip`** | **Page 3 (this page)** | **Summary, jump back to Page 1** |

## See Also

- [01_Navigation README](../01_Navigation/README.md) for full API documentation and cross-platform pattern
