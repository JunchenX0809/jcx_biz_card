# NFC business card

A small, build-free static site for GitHub Pages. The repository keeps the same public URL when the card's role, employer, or visual style changes.

## Files

```text
index.html                  Page content, metadata, and links
assets/css/styles.css       Layout, typography, and color tokens
assets/icons/favicon.svg   Original Bankuity-like site favicon
assets/contact/contact.vcf  Downloadable contact details
.nojekyll                   Publish the static files directly
version.txt                 Human-readable published version
```

GitHub Pages is configured to publish from `main` and `/(root)`. Keep `index.html` at the root; its asset links are relative so they work at the project URL. There is no package manager, build step, or generated `dist` folder to maintain.

## Updating the card

1. Edit the visible name, role, employer, introduction, email, and outgoing links in `index.html`. Also review its `<title>`, description, Open Graph text, and contact download filename.
2. Edit `assets/contact/contact.vcf` to match the current details. Keep the path stable so the page link does not need to change.
3. Edit the color tokens at the start of `assets/css/styles.css` if the visual identity changes. Replace `assets/icons/favicon.svg` only with an asset you own or have permission to use.
4. When a LinkedIn URL is confirmed, add a direct profile link and optional QR section at the marked point in `index.html`. A QR should encode that exact profile URL and be scan-tested before publication.
5. Preview the page at a project-style path, check narrow phone widths, and download the vCard. After pushing to `main`, check the live page and contact action on a real phone before writing the Pages URL to an NFC card.

The favicon is the original icon drawn during the earlier site work. It resembles Bankuity's visual language, but it was **not** copied from the Figma deck or verified as an official logo. The deck informed the navy and cyan palette, and the earlier site work verified the name, GTM role, and Bankuity email there. Other wording is site copy and should be reviewed as such.

## Version tracking

`version.txt` starts at `0.1.0` for the prepublication card. Update it when publishing a new card revision, in the same commit as the changed files. It is available at the Pages URL plus `/version.txt`, which makes it easy to check which revision is live. Git commits remain the precise change history; for a named milestone, add a matching Git tag after checking the live page (for example, `v1.0.0`). GitHub's Pages deployment history also identifies the commit used for each deployment.
