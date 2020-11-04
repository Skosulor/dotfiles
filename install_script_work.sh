#!/bin/bash

# The paths are set in function "set_paths()"

DOT_LOCAL_PATH=""
AUTOSTART_PATH=""
DOT_PATH=""
WORKDOT_PATH=""
DOOM_CONFIG_PATH=""
DOT_CONFIG_PATH=""
AUTOSTART_PATH=""
XCAPE_CONF=""
SHORTCUT_PATH=""
GUAKE_CONF_PATH=""
FISH_CONFIG_PATH=""
TEMP_DIR=""

# Shortcut to exit a program (replaces alt-f4)
QUIT_COMMAND="['<Alt>q']"
# Open application menu
RUN_COMMAND="['<Alt>d']"

# List to fill with failed installations
failed_installations=()

main() {

	# Set path depending on OS
	set_paths

	#
	if pacman --version > /dev/null 2>&1;
	then
	 	install_apps "${apps_manjaro[@]}"
	else
	 	install_apps "${apps_ubuntu[@]}"
	fi
	print_separator

	echo "copying .configs"
	set_dot_configs
	print_separator

	echo "copying .local"
	install_dot_local
	print_separator

	echo "Setting shortcuts.."
	set_shortcuts
	print_separator

	echo "Installing font iosevka"
	install_font_iosevka
	print_separator

	echo "Fetching configs"
	get_configs
	print_separator

	echo "Installing DOOM emacs"
	install_doom
	print_separator

	echo "Configuring xcape"
	configure_xcape
	print_separator

	echo "Configuring fish shell"
	set_fish_conf
	print_separator

	echo "Configuring guake"
	set_guake_preferences
	print_separator


	if [ ${#failed_installations[@]} -eq 0 ]; then
    		echo "All appps successfully installed!"
	else
		echo "Failed to install the following apps:"
		print_list "${failed_installations[@]}"
	fi

	echo "All done, welcome Andreas"
}

function install_apps(){
	apps=("$@")
	failed=()
	for app in  "${apps[@]}";
		do 
			out="Installing ${app}..."
			echo $out 
			if sudo $INSTALL_COMMAND $app > /dev/null 2>&1; then
				:
			else
				echo "failed to install $app"
				failed_installations+=( $app )
			fi

		done

}

function print_list(){
	list=("$@")
	for item in "${list[@]}";
	do
		echo $item
	done
}

function print_separator() {
	echo ""
	echo ""
}

function install_doom(){
	echo "Installing doom emacs"
	git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d 

	# So we don't have to write ~/.emacs.d/bin/doom every time
	PATH="$HOME/.emacs.d/bin:$PATH"


	cp -rf $WORKDOT_PATH/.doom.d $HOME/
	doom sync
	doom env
	emacs --batch -f all-the-icons-install-fonts
}

function get_configs(){
	rm -rf $DOT_PATH
	git clone https://github.com/skosulor/dotfiles $DOT_PATH
}

function configure_xcape(){
	gsettings set org.gnome.desktop.input-sources xkb-options "['caps:ctrl_modifier']"
}

function set_shortcuts(){

	 #drop_command="tdrop -m  -x 50% -w 50% -h 100% gnome-terminal -e tmux"
	 #drop_name="dropdown terminal"
	 #drop_binding="<alt>Return"
	 #drop=(
	#	 ${drop_name}
	#	 ${drop_command}
	#	 ${drop_binding}
	# )
	# shortcut_helper "$drop_name" "$drop_command" "$drop_binding"
	gsettings set org.gnome.desktop.wm.keybindings close $QUIT_COMMAND
	gsettings set org.gnome.shell.keybindings toggle-application-view $RUN_COMMAND

}

function shortcut_helper(){
	CMD_BEGINNING="gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding"
	KEY_PATH_BASE="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings"

	EXISTED_PATHS=$(gsettings get org.gnome.settings-daemon.plugins.media-keys custom-keybindings)

	NEW_KEY_INDEX=$(dconf list /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/ | wc -l)

	NEW_KEY_PATH=$KEY_PATH_BASE/custom$NEW_KEY_INDEX/

	if [ $NEW_KEY_INDEX -gt 0 ]
	then
		NEW_PATHS=${EXISTED_PATHS%]},\ \'${NEW_KEY_PATH}\'\]  # Add the new custom folder into `custom-keybindings` key
	else
		NEW_PATHS="['$NEW_KEY_PATH']"
	fi

	gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "${NEW_PATHS}"

	$CMD_BEGINNING:$NEW_KEY_PATH name "$1"
	$CMD_BEGINNING:$NEW_KEY_PATH command "$2"
	$CMD_BEGINNING:$NEW_KEY_PATH binding "$3"
}

function install_font_iosevka(){
	wget https://github.com/be5invis/Iosevka/releases/download/v3.7.1/ttf-iosevka-term-3.7.1.zip
	mkdir $TEMP_DIR
	cp ttf-iosevka* $TEMP_DIR/
	rm ttf-iosevka-term-3.7.1.zip
	unzip $TEMP_DIR/ttf-iosevka* -d $TEMP_DIR/
	sudo cp -r $TEMP_DIR/ttf /usr/share/fonts/
	fc-cache
	rm -rf $TEMP_DIR
}


function install_alacritty(){
	sudo snap install alacritty --edge --classic
	cp -f $ALACRITTY_PATH ~/.config/
}

function install_tdrop(){
	git clone https://github.com/noctuid/tdrop
	cd tdrop
	sudo make install
	cd ..
}

function set_guake_preferences(){
	guake --restore-preferences $GUAKE_CONF_PATH
}

function set_dot_configs{
	mkdir $DOT_CONFIG_PATH
	cp -r $M_DOT_CONFIG_PATH/* $DOT_CONFIG_PATH
}


function set_fish_conf(){
	cp -rf $FISH_CONFIG_PATH ~/.config/	
}

function install_dot_local(){
	mkdir r $DOT_LOCAL_PATH 
	cp -r $M_DOT_LOCAL_PATH $DOT_LOCAL_PATH
}

function set_paths(){

	DOT_PATH="$HOME/configs"

	if pacman --version > /dev/null 2>&1;
	then
		WORKDOT_PATH="$DOT_PATH/work/manjaro"
		INSTALL_COMMAND="sudo pacman -S --noconfirm"
	else
		WORKDOT_PATH="$DOT_PATH/work/ubuntu"
		INSTALL_COMMAND="sudo apt install --yes"
	fi

	DOOM_CONFIG_PATH="$WORKDOT_PATH/.doom.d"
	DOT_CONFIG_PATH="$HOME/.config"
	M_DOT_CONFIG_PATH="$WORKDOT_PATH/.config"
	M_DOT_LOCAL_PATH="$WORKDOT_PATH/.local"
	DOT_LOCAL_PATH="$HOME/.local"
	AUTOSTART_PATH="$HOME/.config/autostart"
	XCAPE_CONF="$WORKDOT_PATH/xcape.desktop"
	SHORTCUT_PATH="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings"
	GUAKE_CONF_PATH="$WORKDOT_PATH/guakeconf"
	FISH_CONFIG_PATH="$WORKDOT_PATH/fish"
	TEMP_DIR="temporary_dir_for_install_script"


}

	apps_ubuntu=(
		git
		neovim
		xcape
		fd-find
		qutebrowser
		ripgrep
		emacs
		tmux
		ccls
		guake
		gawk
		gnome-tweaks
		fish
		python3-pip
		neofetch
		g++
		gcc
		make
		cmake
		xdotool
		firefox
		libreoffice
	)

	apps_manjaro=(
		git
		neovim
		xcape
		fd
		qutebrowser
		ripgrep
		emacs
		tmux
		ccls
		guake
		gawk
		gnome-tweaks
		fish
		python-pip
		neofetch
		gcc
		make
		cmake
		xdotool
		firefox
		libreoffice
	)


main "$@"; exit

# TODO Languages
# TODO Add input argument for type of tools like basic, c++, configs, office suite
