# Slack Conversation Summarizer

A command-line tool that fetches Slack conversations and generates AI-powered summaries using GitHub Models.

## Features

- Fetch Slack conversations using URLs
- Generate intelligent summaries using AI
- Customizable prompt templates
- Clean, formatted output suitable for documentation or reporting

## Prerequisites

### 1. GitHub CLI Installation

Install the GitHub CLI if you haven't already:

```bash
# macOS (using Homebrew)
brew install gh

# Or download from: https://cli.github.com/
```

### 2. GitHub CLI Slack Extension

Install the Slack extension for GitHub CLI:

```bash
gh extension install github.com/rneatherway/gh-slack
```

### 3. Authentication

Make sure you're authenticated with GitHub CLI:

```bash
gh auth login
```

You'll also need to configure the Slack extension with your workspace credentials.

### 4. GitHub Models Token

Create a GitHub Personal Access Token (PAT) with `models: read` permission for accessing GitHub Models:

1. Go to GitHub Settings → Developer settings → Personal access tokens → Fine-grained tokens
2. Create a new token with `models: read` permission
3. Set the token as an environment variable:

```bash
export GITHUB_MODELS_TOKEN=github_pat_11XXXXXXX0dSNOTjmU83gq_WXmGokWwcWeabcQFbQGav4qcM893e3kwinSDuqlB964FVXXXXXX7HLJwPo
```

**Note**: Replace the X's with your actual token. This token is required for the AI summarization functionality.

## Setup

1. Clone this repository
2. Copy `prompt.txt.example` to `prompt.txt`
3. Customize the prompt template according to your needs
4. Make the script executable (if needed):

   ```bash
   chmod +x slack-summarizer.sh
   ```

## Usage

```bash
./slack-summarizer.sh <slack-url>
```

### Example

```bash
./slack-summarizer.sh https://yourworkspace.slack.com/archives/C1234567890/p1234567890123456
```

## Tips and Tricks

### Easy Access Setup

For convenient access from anywhere in your terminal, consider setting up the tool globally:

**1. Clone to a dedicated bin folder**:

   ```bash
   mkdir -p ~/bin
   cd ~/bin
   git clone <this-repo-url> slack-summarizer
   ```

**2. Add alias and PATH to your shell profile**:

Add the following lines to your `~/.zprofile` (or `~/.zshrc` for zsh, `~/.bash_profile` for bash):

```bash
# Add ~/bin to PATH
export PATH="$HOME/bin:$PATH"

# Slack Summarizer alias
alias ss="slack-summarizer/slack-summarizer.sh"
```

**3. Reload your shell**:

```bash
source ~/.zprofile
```

**4. Now you can use it from anywhere**:

```bash
ss https://yourworkspace.slack.com/archives/C1234567890/p1234567890123456
```

## Configuration

Edit `prompt.txt` to customize how the AI summarizes your Slack conversations. The template supports:

- Custom instructions for summary format
- Specific mention handling
- Output style preferences
- Context-specific requirements

## How it Works

1. **Fetch**: Uses `gh slack read` to retrieve the Slack conversation content
2. **Process**: Combines the conversation with your custom prompt template
3. **Summarize**: Sends the content to GitHub Models for AI-powered summarization
4. **Output**: Returns a clean, formatted summary

## File Structure

- `slack-summarizer.sh` - Main script
- `prompt.txt` - Your customized prompt template (create from example)
- `prompt.txt.example` - Example prompt template

## Contributing

Feel free to submit issues and enhancement requests!

## License

This project is open source and available under the [MIT License](LICENSE).
