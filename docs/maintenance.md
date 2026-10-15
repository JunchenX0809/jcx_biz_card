# Maintaining the NFC card

The page publishes directly from the root of `main` at
[junchenx0809.github.io/jcx_biz_card](https://junchenx0809.github.io/jcx_biz_card/).
Keep `index.html` at the root and asset links relative. The stable page URL is
also encoded in `assets/qr/website.svg` for printing on a physical card.
`assets/qr/website.png` is a 1032-pixel copy for easy preview and sharing.

## Updating contact details

1. Edit the name, role, employer, email, LinkedIn, and other links in
   `index.html`. Check its title, description, Open Graph text, and vCard
   download filename for the same changes.
2. Edit `assets/contact/contact.vcf` to match. Its lines must end with CRLF;
   `.gitattributes` preserves those bytes when Git checks out the file.
   Keep the file path stable so existing links continue to work.
3. If a QR destination changes, regenerate its SVG from the repository root
   on macOS (the script uses Apple's Core Image):

   ```sh
   swift scripts/generate_qr.swift https://junchenx0809.github.io/jcx_biz_card/ assets/qr/website.svg
   sips -s format png -z 1032 1032 assets/qr/website.svg --out assets/qr/website.png
   swift scripts/generate_qr.swift https://www.linkedin.com/in/jcxiong0809/ assets/qr/linkedin.svg
   ```

   The 1032-pixel PNG size is an exact 24-pixel multiple of the current
   43-module website QR (including its quiet zone). Use the SVG as the print
   master; if the URL changes enough to alter the module count, choose a new
   integer multiple for the PNG size.

4. Update `version.txt` once for the whole release. Git history records the
   exact changes; `version.txt` labels the published state.

## HubSpot invitation

The invitation inside the navy card links to a
[shared HubSpot form](https://rnfhm.share.hsforms.com/2QL-SKF97Qna9dIP4tbCl-w).
The form's fields and confirmation message are managed in HubSpot, outside
this repository. Keep the invitation wording aligned with the live form and
check the link on a phone when either changes. The team plans to add an
optional question about what the visitor would like to discuss.

## Before handing out a card

Preview the site at the project path:

```sh
/usr/bin/python3 -m http.server 4173 --directory ..
```

Open `http://localhost:4173/jcx_biz_card/` and check a narrow phone width,
the HubSpot invitation, all three contact actions, and both QR codes. Test the
vCard download and Contacts import on a real phone. After you push, check the live page and
`/version.txt` before writing its stable URL to an NFC card or printing a QR.

The team-supplied logo is `assets/icons/bankuity-logo-landscape-solid-dark.svg`.
`assets/icons/favicon.svg` contains its symbol paths, and the page uses the
64-pixel PNG derived from it as the browser tab icon. If an approved symbol
changes, regenerate the PNG with a new filename and update `index.html` so
browsers fetch the replacement instead of showing a cached icon. The current
file was generated with:

```sh
sips -s format png -z 64 64 assets/icons/favicon.svg --out assets/icons/bankuity-symbol-64.png
```

The README intentionally stays short and links directly to the page.
