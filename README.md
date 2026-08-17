# Pack 14 Website

A Jekyll-based website for Cub Scout Pack 14 in Palo Alto, CA.

## Overview

This repository contains the source code for the Pack 14 website. The site is built using Jekyll, styled with TailwindCSS, and integrates with the pack's Scoutbook Plus calendar for event management.

We intend to create a more easily deployable template version of this site in the future. In the meantime, we've made this repository available to other Scouting America organizations so they can use it as a starting point for their own websites.

## Features

- **Responsive Design**: Mobile-friendly layout using TailwindCSS
- **Event Management**: Integration with Scoutbook Plus for public and private events
- **Downloadable Calendar Events**: Support for adding events to personal calendars (.ics)
- **Leadership Directory**: Information about pack leadership
- **Den Information**: Details about each den and meeting times

## Getting Started

### Prerequisites

- Ruby 3.x
- Bundler

### Installation

1. Clone the repository
   ```
   git clone https://github.com/your-username/pack14.git
   cd pack14
   ```

2. Install dependencies
   ```
   bundle install
   ```

3. Setup Scoutbook Plus Calendar Integration
   - In Scoutbook Plus, go to Calendar, scroll to the bottom, and copy the .ics
     feed URL for your unit's calendar
   - Add it to `scoutbook_calendars` in `_config.yml` (see the existing entry
     for the shape). No API key or service account is needed — the feed is
     fetched directly at build time by `_plugins/scoutbook_calendar.rb`.

### Development

Run the local development server:
```
bundle exec jekyll serve
```

The site will be available at `http://localhost:4000`.

### Building for Production

```
bundle exec jekyll build
```

This will generate the static site in the `_site` directory.

## Deployment

The site is automatically deployed to GitHub Pages when changes are pushed to the main branch using GitHub Actions.

## Image Optimization

Built images are optimized during the GitHub Pages workflow by `script/optimize-images.sh`. This keeps the original source photos in the repository while shrinking the files that are actually deployed.

The current rules are intentionally simple:

- large hero and content JPEGs are resized to a practical maximum width and recompressed
- leader profile PNGs are resized aggressively because they are only displayed as small avatars
- metadata is stripped from generated assets

If you want to preview the optimized output locally after a build, run:

```bash
bundle exec jekyll build
script/optimize-images.sh _site/assets/images
```

## Directory Structure

- `_config.yml`: Main Jekyll configuration
- `_layouts/`: Layout templates
- `_includes/`: Reusable components
- `assets/`: Static assets (images, CSS)
- `_site/`: Generated site (not in repository)

## Contributing

1. Fork the repository
2. Create a new branch (`git checkout -b feature/your-feature`)
3. Make your changes
4. Commit your changes (`git commit -m 'Add some feature'`)
5. Push to the branch (`git push origin feature/your-feature`)
6. Open a Pull Request

## License

This project is licensed under the Scouting America Non-Commercial License - see the [LICENSE](LICENSE) file for details. This custom license permits use by:

- Registered Scouting America organizations (Cub Scout packs, Scout troops, etc.)
- Non-profit educational organizations affiliated with Scouting America
- Volunteers affiliated with Scouting America organizations

For uses outside these terms, please contact [info@paloaltopack14.org].

## Acknowledgments

- [Pack 57 Palo Alto](https://github.com/Pack57PaloAlto/pack57paloalto.github.io) — original site by Friends of Pack 57 (Jacob Foster Heimark), licensed under the Scouting America Non-Commercial License. This project is based on their work with modifications.
- [Jekyll](https://jekyllrb.com/)
- [TailwindCSS](https://tailwindcss.com/)
- [GitHub Pages](https://pages.github.com/)
- [icalendar](https://github.com/icalendar/icalendar)
