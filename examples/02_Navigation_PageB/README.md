# Navigation — Page 2 of 3

Middle page in the 3-page navigation demo. Upload all 3 navigation ZIPs together to see navigation in action.

## What This Page Shows

- **Previous/Next buttons** — uses `goNextSequence()` / `goPreviousSequence()` on web, `goNextPage()` / `goPreviousPage()` on iPad
- **Jump buttons** using `gotoSlide()` to jump directly to Page 1 or Page 3

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
| **`02_Navigation_PageB.zip`** | **Page 2 (this page)** | **Previous/Next, jump to any page** |
| `03_Navigation_PageC.zip` | Page 3 | Navigation summary, jump back to Page 1 |

## See Also

- [01_Navigation README](../01_Navigation/README.md) for full API documentation and cross-platform pattern
