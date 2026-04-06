#!/bin/bash

# Helper function
commit_file() {
    local file="$1"
    local message="$2"
    
    if [ -f "$file" ]; then
        echo "Committing file $file..."
        git add "$file"
        git commit -m "$message"
    else
        echo "Skipping $file (not a file)"
    fi
}

# 1. Base files
echo "===> Initializing base files..."
commit_file ".gitignore" "init: .gitignore"
commit_file "js-lab/commit_per_file.sh" "init: commit script"

# 2. .agents folder (recursive through files)
echo "===> Committing .agents files..."
if [ -d ".agents" ]; then
    # Use find to list all files, avoid hidden files or directories
    find .agents -type f -not -name ".DS_Store" | sort | while read -r item; do
        commit_file "$item" "feat(agents): $item"
    done
fi

# 3. js-lab topics
JS_LAB_DIR="js-lab"
VIS_DIR="js-lab/visualisation"

echo "===> Committing topics from $JS_LAB_DIR..."
# Get topic folders, excluding visualisation
TOPICS=$(find "$JS_LAB_DIR" -maxdepth 1 -mindepth 1 -type d ! -name "visualisation" | sort)

# We'll keep track of handled visualisation folders
HANDLED_VIS=()

while read -r topic_path; do
    if [ -z "$topic_path" ]; then continue; fi
    topic=$(basename "$topic_path")
    echo "--- TOPIC: $topic ---"
    
    # Files in this topic (main content)
    find "$topic_path" -type f -not -name ".DS_Store" | sort | while read -r item; do
        commit_file "$item" "feat($topic): $item"
    done
    
    # Files in corresponding visualisation
    if [ -d "$VIS_DIR/$topic" ]; then
        echo "--- VISUALISATION: $topic ---"
        find "$VIS_DIR/$topic" -type f -not -name ".DS_Store" | sort | while read -r item; do
            commit_file "$item" "visualisation($topic): $item"
        done
        HANDLED_VIS+=("$topic")
    fi
done <<< "$TOPICS"

# 4. Leftover visualisations (folders in VIS_DIR that aren't in JS_LAB_DIR)
echo "===> Committing leftover visualisations..."
VIS_FOLDERS=$(find "$VIS_DIR" -maxdepth 1 -mindepth 1 -type d | sort)

while read -r vis_path; do
    if [ -z "$vis_path" ]; then continue; fi
    vis_name=$(basename "$vis_path")
    
    # Check if already handled
    ALREADY_DONE=false
    for item in "${HANDLED_VIS[@]}"; do
        if [[ "$item" == "$vis_name" ]]; then
            ALREADY_DONE=true
            break
        fi
    done
    
    if [ "$ALREADY_DONE" = false ]; then
        echo "--- EXTRA VISUALISATION: $vis_name ---"
        find "$vis_path" -type f -not -name ".DS_Store" | sort | while read -r item; do
            commit_file "$item" "visualisation($vis_name): $item"
        done
    fi
done <<< "$VIS_FOLDERS"

echo "Done! All 176+ files should be committed individually."
