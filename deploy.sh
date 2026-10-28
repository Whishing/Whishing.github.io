#!/usr/bin/env bash
# Publish the homepage: sync files from the research repo, commit, push to GitHub.
#
#   ./deploy.sh              # sync + commit + push
#   ./deploy.sh "my message" # custom commit message
#
# Docs live in /media/SSD/shenxing/vggt_nips/homepage/ (edit there, then run this).
set -euo pipefail

SRC="${SRC:-/media/SSD/shenxing/vggt_nips/homepage}"
cd "$(dirname "$0")"

cp "$SRC/index.html" "$SRC/styles.css" "$SRC/photo.jpg" .
rm -rf figures
cp -r "$SRC/figures" figures

git add -A
if git diff --cached --quiet; then
  echo "nothing to commit — already up to date"
else
  git commit -m "${1:-Update site $(date +%F)}"
fi

git push
echo "done. live at https://whishing.github.io/ (allow ~1 min for Pages to rebuild)"
