# Kiro CLI pre block. Keep at the top of this file.
[[ -f "${HOME}/.local/share/kiro-cli/shell/zprofile.pre.zsh" ]] && builtin source "${HOME}/.local/share/kiro-cli/shell/zprofile.pre.zsh"

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# Kiro CLI post block. Keep at the bottom of this file.
[[ -f "${HOME}/.local/share/kiro-cli/shell/zprofile.post.zsh" ]] && builtin source "${HOME}/.local/share/kiro-cli/shell/zprofile.post.zsh"
