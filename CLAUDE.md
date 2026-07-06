# Kelderman Bouw — Hero prototype

Statisch prototype van de nieuwe homepage-hero voor keldermanbouw.nl,
1:1 nagebouwd vanuit Figma. Eén `index.html`, geen build-stap.

## Concept
Hero-zin "Daar wordt het [woord] van" waarin het woord rouleert
(kwalitatiever → beter → duurzamer → sportiever → mooier), elk woord
met een eigen beeld. Woordwissel = letter-stagger in een meebewegend
blauw blok; beeldwissel = drie verticale panelen; slider-nav linksonder.

## Taken die de gebruiker kan vragen

### 1. Assets ophalen uit Figma
Run: `bash scripts/fetch-figma-assets.sh`
Vereist dat Figma desktop openstaat met het Kelderman-bestand en de
MCP/dev-server draait (localhost:3845).

**Als hashes verlopen zijn (404's):** haal verse asset-URL's op via de
Figma MCP met `get_design_context` op deze node-IDs en werk de hashes in
`scripts/fetch-figma-assets.sh` bij. Per Image-node is de BOVENSTE
(laatste) img-laag het juiste beeld:

| Asset             | Figma node (Image) | Woord         |
|-------------------|--------------------|---------------|
| logo.png          | 4:97               | —             |
| sportiever.png    | 4:121              | sportiever    |
| duurzamer.png     | 4:176              | duurzamer     |
| kwalitatiever.png | 4:230              | kwalitatiever |
| mooier.png        | 4:284              | mooier        |
| beter.png         | 4:385              | beter         |

De vijf Hero-frames: 4:81, 4:136, 4:190, 4:244, 4:345.
`assets/K.svg` is definitief (door de klant aangeleverd) — nooit
overschrijven; de vorm staat ook inline in index.html.

### 2. Publiceren op GitHub Pages
```
git init && git add -A && git commit -m "Kelderman hero prototype"
gh repo create kelderman-hero-prototype --public --source=. --push
```
De workflow `.github/workflows/deploy.yml` deployt automatisch naar
Pages bij elke push naar `main` (Pages-bron: GitHub Actions, wordt
automatisch geactiveerd). Deel-URL:
`https://<gebruikersnaam>.github.io/kelderman-hero-prototype/`

Controleer na de eerste push of de Actions-run groen is en meld de
Pages-URL terug aan de gebruiker.

### 3. Lokaal bekijken
`python3 -m http.server 8000` en open http://localhost:8000
(rechtstreeks openen als file:// werkt ook, maar via een server is
betrouwbaarder voor de fonts).

## Ontwerpspecs (uit Figma, niet wijzigen zonder opdracht)
- Kleuren: #023381 (Resolution Blue), #104881 (woordblok),
  #FFC013 (Lightning Yellow), #FAB913/#043F85 (slider), overlay
  rgba(2,51,129,.1)
- Fonts: Exo 2 (headline 66.78px, woord SemiBold uppercase),
  Exo (nav/body; body 20px lh 1.3)
- Layout: 1600-raster via CSS-var --u (1 designpx = 100vw/1600),
  hero op 100svh; content x=235 verticaal gecentreerd; foto van
  x=858 tot rechter- en onderrand; slider-nav en K-beeldmerk aan de
  onderrand verankerd
- Timing: 5,2s per slide (--hold), paneelwissel .72s met .09s stagger
