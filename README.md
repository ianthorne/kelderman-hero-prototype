# Kelderman Bouw — Hero prototype

Prototype van de nieuwe homepage-hero: "Daar wordt het **[woord]** van",
met roulerend woord, wisselend beeld en slider-navigatie. 1:1 opgebouwd
vanuit het Figma-ontwerp. Puur statisch — één `index.html`.

## Snel starten (met Claude Code)

Open een terminal in deze map en start Claude Code:

```bash
claude
```

Zeg vervolgens bijvoorbeeld: *"Haal de assets op uit Figma en publiceer
dit op GitHub Pages."* — de instructies staan in `CLAUDE.md`.

## Handmatig

**1. Assets ophalen** (Figma desktop open met het Kelderman-bestand):

```bash
bash scripts/fetch-figma-assets.sh
```

Dit downloadt `logo.png` en de vijf slide-beelden naar `assets/`.
Zonder assets werkt het prototype ook (blauwe fallback-gradients).

**2. Lokaal bekijken:**

```bash
python3 -m http.server 8000
# → http://localhost:8000
```

**3. Publiceren op GitHub Pages** (vereist [gh CLI](https://cli.github.com), ingelogd):

```bash
git init && git add -A && git commit -m "Kelderman hero prototype"
gh repo create kelderman-hero-prototype --public --source=. --push
```

De meegeleverde workflow deployt automatisch. Na ± een minuut staat het
prototype op:

```
https://<jouw-gebruikersnaam>.github.io/kelderman-hero-prototype/
```

Die link kun je delen. Elke volgende `git push` deployt opnieuw.

## Structuur

```
index.html                       het volledige prototype
assets/K.svg                     "K" beeldmerk (definitief, klant-aangeleverd)
assets/*.png                     logo + 5 slide-beelden (via fetch-script)
scripts/fetch-figma-assets.sh    downloadt assets van de Figma dev-server
.github/workflows/deploy.yml     automatische GitHub Pages deploy
CLAUDE.md                        instructies voor Claude Code
```
