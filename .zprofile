#!/bin/zsh

# zsh profile file. Runs on login. Environmental variables are set here.

# If you don't plan on reverting to bash, you can remove the link in ~/.profile
# to clean up.

# Adds `~/.local/bin` to $PATH
export PATH="$PATH:$(du "$HOME/.local/bin" | cut -f2 | paste -sd ':')"
export PATH="$PATH:/opt/texlive/2020/bin/x86_64-linux"
export MANPATH="$MANPATH:/opt/texlive/2020/texmf-dist/doc/man"
export INFOPATH="$INFOPATH:/opt/texlive/2020/texmf-dist/doc/info"

# Default programs:
export EDITOR="nvim"
export TERMINAL="st"
export BROWSER="firefox"
export READER="zathura"

# ~/ Clean-up:
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
#export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority" # This line will break some DMs.
export NOTMUCH_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/notmuch-config"
export GTK2_RC_FILES="${XDG_CONFIG_HOME:-$HOME/.config}/gtk-2.0/gtkrc-2.0"
export LESSHISTFILE="-"
export WGETRC="${XDG_CONFIG_HOME:-$HOME/.config}/wget/wgetrc"
export INPUTRC="${XDG_CONFIG_HOME:-$HOME/.config}/inputrc"
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
export GNUPGHOME="${XDG_CONFIG_HOME:-$HOME/.config}/gnupg"
export WINEPREFIX="${XDG_DATA_HOME:-$HOME/.local/share}/wineprefixes/default"
export KODI_DATA="${XDG_DATA_HOME:-$HOME/.local/share}/kodi"
export PASSWORD_STORE_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/password-store"
export TMUX_TMPDIR="$XDG_RUNTIME_DIR"
export ANDROID_SDK_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/android"
export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo"
export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"
export ANSIBLE_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/ansible/ansible.cfg"
export UNISON="${XDG_DATA_HOME:-$HOME/.local/share}/unison"
export HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/history"
export WEECHAT_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/weechat"

# Other program settings:
export DICS="/usr/share/stardict/dic/"
export SUDO_ASKPASS="$HOME/.local/bin/dmenupass"
export FZF_DEFAULT_OPTS="--layout=reverse --height 40%"
export LESS=-R
export LESS_TERMCAP_mb="$(printf '%b' '[1;31m')"
export LESS_TERMCAP_md="$(printf '%b' '[1;36m')"
export LESS_TERMCAP_me="$(printf '%b' '[0m')"
export LESS_TERMCAP_so="$(printf '%b' '[01;44;33m')"
export LESS_TERMCAP_se="$(printf '%b' '[0m')"
export LESS_TERMCAP_us="$(printf '%b' '[1;32m')"
export LESS_TERMCAP_ue="$(printf '%b' '[0m')"
export LESSOPEN="| /usr/bin/highlight -O ansi %s 2>/dev/null"
export QT_QPA_PLATFORMTHEME="gtk2"	# Have QT use gtk2 theme.
export MOZ_USE_XINPUT2="1"		# Mozilla smooth scrolling/touchpads.
export AWT_TOOLKIT="MToolkit wmname LG3D"	#May have to install wmname
export _JAVA_AWT_WM_NONREPARENTING=1	# Fix for Java applications in dwm

# This is the list for lf icons:
export LF_ICONS="di=:\
fi=:\
tw=🤝:\
ow=:\
ln=:\		#
or=❌:\
ex=:\		#🎯
*.txt=:\
*.mom=:\
*.me=:\
*.ms=:\
*.png=:\
*.webp=:\
*.ico=:\
*.jpg=:\
*.jpe=:\
*.jpeg=:\
*.gif=:\
*.svg=:\
*.tif=:\
*.tiff=:\
*.xcf=:\
*.html=:\
*.xml=:\
*.gpg=:\
*.css=:\
*.pdf=:\
*.djvu=:\
*.epub=:\
*.csv=:\
*.xlsx=:\
*.tex=:\
*.md=:\
*.r=:\
*.R=:\
*.rmd=:\
*.Rmd=:\
*.m=:\
*.mp3=:\
*.opus=:\
*.ogg=:\
*.m4a=:\
*.flac=:\
*.mkv=:\
*.mp4=:\
*.webm=:\
*.mpeg=:\
*.avi=:\
*.zip=:\	#
*.rar=:\
*.7z=:\
*.tar.gz=:\
*.z64=:\
*.v64=:\
*.n64=:\
*.gba=:\
*.nes=:\
*.gdi=:\
*.1=:\
*.nfo=:\
*.info=:\
*.log=:\
*.iso=﫭:\
*.img=﫭:
*.bib=:\
*.ged=פּ:\
*.part=:\
*.torrent=:\
*.jar=♨:\
*.java=♨:\
"

[ ! -f ${XDG_CONFIG_HOME:-$HOME/.config}/shortcutrc ] && shortcuts >/dev/null 2>&1 &

if pacman -Qs libxft-bgra >/dev/null 2>&1; then
	# Start graphical server on user's current tty if not already running.
	[[ -n "$(tty)" && -z $(pgrep -u $USER "\bXorg$") ]] && exec startx
else
	echo "\033[31mIMPORTANT\033[0m: Note that \033[32m\`libxft-bgra\`\033[0m must be installed for this build of dwm.
Please run:
	\033[32myay -S libxft-bgra-git\033[0m
and replace \`libxft\`"
fi

# Switch escape and caps if tty and no passwd required:
sudo -n loadkeys ${XDG_DATA_HOME:-$HOME/.local/share}/larbs/ttymaps.kmap 2>/dev/null
