# Maintaining the NFC cards

Cloudflare Pages publishes directly from the root of `main` at
[bankuity-cards.pages.dev](https://bankuity-cards.pages.dev/). Each person's
card gets a directory and URL path in this one Pages project. Junchen's card
is `junchen-xiong/index.html` at
[bankuity-cards.pages.dev/junchen-xiong/](https://bankuity-cards.pages.dev/junchen-xiong/).
Sven's card is `sven-shi/index.html` at
[bankuity-cards.pages.dev/sven-shi/](https://bankuity-cards.pages.dev/sven-shi/).
Michael's card is `michael-luxenberg/index.html` at
[bankuity-cards.pages.dev/michael-luxenberg/](https://bankuity-cards.pages.dev/michael-luxenberg/).
Don's card is `don-amoruso/index.html` at
[bankuity-cards.pages.dev/don-amoruso/](https://bankuity-cards.pages.dev/don-amoruso/).
Cloudflare's `_redirects` rule sends the root URL there, while the root
`index.html` provides a fallback for GitHub Pages. The root can become a team
directory later without changing personal card URLs.
The `bankuity-cards` project uses Git integration with this repository, no
framework or build command, and `/` as the output directory. Pushes to `main`
deploy automatically. The Cloudflare GitHub app is limited to this repository.
Keep each card's `index.html` in its own directory and link to shared assets
with relative paths such as `../assets/css/styles.css`. Junchen's direct URL
is encoded in `assets/qr/website.svg` for printing on a physical card.
`assets/qr/website.png` is a 1032-pixel copy for easy preview and sharing.
The orb's scroll fade lives in `assets/js/motion.js`; the invitation button's
moving cyan glow lives in `assets/css/styles.css`. Keep both decorative and honor
the existing reduced-motion setting when changing either effect.

## Adding a teammate's card

Create `<first-last>/index.html` and use a matching direct URL such as
`https://bankuity-cards.pages.dev/<first-last>/`. Share the CSS, JavaScript,
and approved brand icons under `assets/`, but give each person distinct contact
and QR filenames. The person's name is a more durable URL path than a job title.
This uses the existing Pages project; no new repository or Pages setup is
needed. Push `main` to deploy the added card alongside the existing ones.

## Updating contact details

1. Edit the name, role, employer, email, LinkedIn, and other links in the
   relevant person's `index.html`. Check its title, description, Open Graph
   text, and vCard download filename for the same changes.
2. Edit the matching vCard (`assets/contact/contact.vcf` for Junchen,
   `sven-shi/contact.vcf` for Sven, `michael-luxenberg/contact.vcf` for
   Michael, or `don-amoruso/contact.vcf` for Don). Its lines must end with CRLF;
   `.gitattributes` preserves those bytes when Git checks out the file.
   Keep the file path stable so existing links continue to work. The `NOTE`
   field on Michael's and Don's vCards supplies the iOS Contacts note;
   keep the note in sync if the product description changes.
3. If a QR destination changes, regenerate its SVG from the repository root
   on macOS (the script uses Apple's Core Image):

   ```sh
   swift scripts/generate_qr.swift https://bankuity-cards.pages.dev/junchen-xiong/ assets/qr/website.svg
   sips -s format png -z 1032 1032 assets/qr/website.svg --out assets/qr/website.png
   swift scripts/generate_qr.swift https://www.linkedin.com/in/jcxiong0809/ assets/qr/linkedin.svg
   swift scripts/generate_qr.swift https://bankuity-cards.pages.dev/sven-shi/ sven-shi/website.svg
   sips -s format png -z 936 936 sven-shi/website.svg --out sven-shi/website.png
   swift scripts/generate_qr.swift https://www.linkedin.com/in/wen-shi-87004874/ sven-shi/linkedin.svg
   swift scripts/generate_qr.swift https://bankuity-cards.pages.dev/michael-luxenberg/ michael-luxenberg/website.svg
   sips -s format png -z 1032 1032 michael-luxenberg/website.svg --out michael-luxenberg/website.png
   swift scripts/generate_qr.swift https://www.linkedin.com/in/michael-luxenberg-a2091/ michael-luxenberg/linkedin.svg
   swift scripts/generate_qr.swift https://bankuity-cards.pages.dev/don-amoruso/ don-amoruso/website.svg
   sips -s format png -z 1032 1032 don-amoruso/website.svg --out don-amoruso/website.png
   swift scripts/generate_qr.swift https://www.linkedin.com/in/donamoruso/ don-amoruso/linkedin.svg
   ```

   Each PNG size is an exact 24-pixel multiple of its QR module count,
   including the quiet zone. Use the SVG as the print master; if a URL change
   alters the module count, choose a new integer multiple for the PNG size.

4. Update `version.txt` once for the whole release. Git history records the
   exact changes; `version.txt` labels the published state.

## HubSpot invitation

The invitation inside the navy card links to a
[shared HubSpot form](https://rnfhm.share.hsforms.com/2GHlHhI3-SaKExqpzz_7jUg).
The form's fields and confirmation message are managed in HubSpot, outside
this repository. Keep the invitation wording aligned with the live form and
check the link on a phone when either changes. The team plans to add an
optional question about what the visitor would like to discuss.

## Before handing out a card

Preview the site at the project path:

```sh
/usr/bin/python3 -m http.server 4173 --directory ..
```

Open `http://localhost:4173/jcx_biz_card/junchen-xiong/`,
`http://localhost:4173/jcx_biz_card/sven-shi/`,
`http://localhost:4173/jcx_biz_card/michael-luxenberg/`, and
`http://localhost:4173/jcx_biz_card/don-amoruso/`. Check a narrow phone width,
the scroll response, the reduced-motion setting, the HubSpot invitation, all
three contact actions, and both QR codes. Test the
vCard download and Contacts import on a real phone. After you push, check the live page and
`/version.txt` before writing its direct URL to an NFC card or printing a QR.

The team-supplied logo is `assets/icons/bankuity-logo-landscape-solid-dark.svg`.
`assets/icons/favicon.svg` contains its symbol paths, and the page uses the
64-pixel PNG derived from it as the browser tab icon. If an approved symbol
changes, regenerate the PNG with a new filename and update the card's `index.html` so
browsers fetch the replacement instead of showing a cached icon. The current
file was generated with:

```sh
sips -s format png -z 64 64 assets/icons/favicon.svg --out assets/icons/bankuity-symbol-64.png
```

The README intentionally stays short and links directly to all cards.
