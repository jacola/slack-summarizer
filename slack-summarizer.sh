#!/bin/bash

# Check if slack URL is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <slack-url>"
    echo "Example: $0 https://yourworkspace.slack.com/archives/C1234567890/p1234567890123456"
    exit 1
fi

SLACK_URL="$1"

# Get the slack message content
echo "Fetching Slack message..."
SLACK_CONTENT=$(gh slack read "$SLACK_URL")
# echo "=== Slack content fetched ===" 
# echo "Content length: $(echo "$SLACK_CONTENT" | wc -c) characters" 
# echo "First 200 characters:" 
# echo "$SLACK_CONTENT" | head -c 200 
# echo "" 
# echo "=== End of Slack content preview ===" 
# echo "" 

if [ $? -ne 0 ]; then
    echo "Error: Failed to fetch Slack message"
    exit 1
fi


# Get the directory where the script is located
SCRIPT_DIR="$(dirname "$0")"

# Load prompt template from external file
PROMPT_TEMPLATE_FILE="$SCRIPT_DIR/prompt.txt"
if [ ! -f "$PROMPT_TEMPLATE_FILE" ]; then
    echo "Error: Prompt template file not found: $PROMPT_TEMPLATE_FILE"
    exit 1
fi

# echo ""
# echo "Prompt:"
# cat "$PROMPT_TEMPLATE_FILE"

# Read the prompt template and substitute the Slack content
PROMPT="$(envsubst < "$PROMPT_TEMPLATE_FILE")

Slack conversation content:
$SLACK_CONTENT
"

# echo ""
# echo "Generated Prompt:"
# echo "$PROMPT"

# Create JSON payload using jq for proper escaping
JSON_PAYLOAD=$(jq -n --arg content "$PROMPT" '{model: "openai/gpt-5", messages: [{role: "user", content: $content}]}')

echo "Sending to GitHub Models..."

RESPONSE=$(curl -L \
  -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $GITHUB_MODELS_TOKEN" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  -H "Content-Type: application/json" \
  https://models.github.ai/inference/chat/completions \
  -d "$JSON_PAYLOAD")

echo ""
echo "Result:"
echo ""
echo "$RESPONSE" | jq -r '.choices[0].message.content'