# Additional Content

Include PDFs, videos, iFrames, and external links in LSC presentations using the ZIP file naming convention.

## Overview

Additional content files are included in the presentation ZIP alongside the main HTML page. They are identified by the `isadditionalcontent_` prefix in the filename.

## Supported File Types

### PDFs
```
isadditionalcontent_brochure.pdf
```
- PDFs are opened in the native viewer when users tap the link
- Use `<a href="isadditionalcontent_brochure.pdf">` to link from HTML

### Videos
```
isadditionalcontent_demo.mp4
isadditionalcontent_demo.mov
isadditionalcontent_demo.m4v
```
- Supported formats: MP4, MOV, M4V
- Videos play in the native media player
- Can also be embedded with `<video>` tags

### iFrames
```
isadditionalcontent_app.html
```
- Additional HTML files can be loaded in iFrames
- Useful for sub-pages, tools, or embedded apps

### External Links
```html
<!-- Link to external content -->
<a href="https://example.com" target="_blank">View Resource</a>
```
- External links open in the device browser
- Requires network connectivity

## ZIP File Structure Example
```
01_ProductDetail.zip
├── 01_ProductDetail.html          (main page)
├── 01_ProductDetail.jpg           (thumbnail)
├── isadditionalcontent_study.pdf   (additional PDF)
├── isadditionalcontent_video.mp4   (additional video)
├── isadditionalcontent_tool.html   (additional HTML)
├── css/
│   └── styles.css
├── js/
│   └── app.js
└── images/
    └── chart.png
```

## Email Attachments
- Include a PDF file in the ZIP for email attachments
- Use `required__` prefix to make attachment mandatory: `required__document.pdf`
- PDFs under 3 MB are auto-attached to the presentation page record
- For larger files, add the PDF manually

## ZIP File Requirements
| Rule | Details |
|------|---------|
| Naming | `XX_PageName.zip` where XX = display order number |
| HTML file | Must match ZIP name: `XX_PageName.html` |
| Thumbnail | Must match ZIP name: `XX_PageName.jpg` |
| Max size | Recommended under 20 MB per ZIP |
| Encoding | UTF-8 for all text files |
