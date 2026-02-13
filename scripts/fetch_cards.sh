#!/bin/bash
#
# Fetch OG card images for all links in _data/links.yml and _data/events.yml
#
# Usage: ./scripts/fetch_cards.sh
#
# For each URL in the data files, this script:
# 1. Checks if a local card image already exists in images/cards/
# 2. If not, fetches OG metadata via the microlink API
# 3. Downloads the OG image and saves it locally
# 4. If no OG image is found, downloads a screenshot via screenshot.11ty.dev
#
# Run this once after adding new links, then commit the downloaded images.
# Re-run with --force to re-fetch all images.
#

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
CARDS_DIR="$ROOT_DIR/images/cards"
LINKS_FILE="$ROOT_DIR/_data/links.yml"
EVENTS_FILE="$ROOT_DIR/_data/events.yml"

FORCE=false
if [[ "${1:-}" == "--force" ]]; then
    FORCE=true
fi

mkdir -p "$CARDS_DIR"

# Extract URLs from both YAML files (simple grep - works for this flat structure)
urls=$(grep -hE '^\s+(-\s+)?url:' "$LINKS_FILE" "$EVENTS_FILE" 2>/dev/null | sed 's/.*url:\s*//' | tr -d '"' | tr -d "'" | xargs)

for url in $urls; do
    # Generate a slug from the URL for the filename
    # Must match the Liquid template: remove protocol, replace each special char with _
    # Do NOT collapse multiple underscores or strip trailing ones.
    slug=$(echo "$url" | sed 's|https\?://||' | sed 's|[^a-zA-Z0-9]|_|g')

    # Check for existing image (any extension)
    existing=$(find "$CARDS_DIR" -name "${slug}.*" 2>/dev/null | head -1)
    if [[ -n "$existing" && "$FORCE" != "true" ]]; then
        echo "SKIP $url (already have $(basename "$existing"))"
        continue
    fi

    echo "FETCH $url"

    # Call microlink API to get OG metadata
    response=$(curl -s "https://api.microlink.io/?url=$(python3 -c "import urllib.parse; print(urllib.parse.quote('$url', safe=''))")" 2>/dev/null || echo '{}')

    # Extract image URL from response
    image_url=$(echo "$response" | python3 -c "
import sys, json
try:
    data = json.load(sys.stdin)
    if data.get('status') == 'success' and data.get('data', {}).get('image', {}).get('url'):
        print(data['data']['image']['url'])
except:
    pass
" 2>/dev/null)

    # Try OG image first, then fall back to screenshot service
    if [[ -n "$image_url" && "$image_url" != data:* ]]; then
        echo "  OG IMAGE: $image_url"

        # Determine file extension from URL or content-type
        ext=$(echo "$image_url" | grep -oP '\.(jpg|jpeg|png|gif|webp|svg)' | head -1 || echo "")
        if [[ -z "$ext" ]]; then
            ext=".jpg"
        fi

        outfile="$CARDS_DIR/${slug}${ext}"

        # Download the image
        if curl -sL -o "$outfile" "$image_url" 2>/dev/null && [[ -s "$outfile" ]]; then
            echo "  SAVED $(basename "$outfile") ($(du -h "$outfile" | cut -f1))"
        else
            echo "  OG download failed, trying screenshot fallback"
            rm -f "$outfile"
            image_url=""
        fi
    else
        image_url=""
    fi

    # Fall back to screenshot.11ty.dev if no OG image
    if [[ -z "$image_url" ]]; then
        encoded_url=$(python3 -c "import urllib.parse; print(urllib.parse.quote('$url', safe=''))")
        screenshot_url="https://v1.screenshot.11ty.dev/${encoded_url}/opengraph/"
        outfile="$CARDS_DIR/${slug}.jpg"

        echo "  SCREENSHOT: $screenshot_url"
        if curl -sL -o "$outfile" "$screenshot_url" 2>/dev/null && [[ -s "$outfile" ]]; then
            echo "  SAVED $(basename "$outfile") ($(du -h "$outfile" | cut -f1))"
        else
            echo "  FAILED to download screenshot"
            rm -f "$outfile"
        fi
    fi

    # Be polite to the API
    sleep 1
done

echo ""
echo "Done. Card images are in images/cards/"
echo "The go.html template will automatically find them by URL slug."
echo "Commit the images to your repo."
