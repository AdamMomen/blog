#!/usr/bin/env bash
set -e
title="$*"
if [ -z "$title" ]; then
  echo "Usage: ./scripts/new_post.sh \"Post Title\""
  exit 1
fi
slug=$(echo "$title" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g;s/^-|-$//g')
date=$(date +%F)
mkdir -p _posts
file="_posts/${date}-${slug}.md"
cat > "$file" <<EOF
---
layout: post
title: "${title}"
date: ${date}
---
<!-- Write here -->
EOF
echo "Created $file"
