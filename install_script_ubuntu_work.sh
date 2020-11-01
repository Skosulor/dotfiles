#!/bin/bash

DOT_PATH="$HOME/configs"
WORKDOT_PATH="$DOT_PATH/work"
DOOM_CONFIG_PATH="$WORKDOT_PATH/.doom.d"
AUTOSTART_PATH="$HOME/.config/autostart"
XCAPE_CONF="$WORKDOT_PATH/xcape.desktop"
SHORTCUT_PATH="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings"
GUAKE_CONF_PATH="$WORKDOT_PATH/guakeconf"
FISH_CONFIG_PATH="$WORKDOT_PATH/fish"
QUIT_COMMAND="['<Alt>q']"
RUN_COMMAND="['<Alt>d']"

failed_installations=()


main() {
	apps=(
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
		gcc
		g++
		make
		cmake
		xdotool
		libreoffice
	)


	 install_apps "${apps[@]}"
	 print_separator

	if [ ${#failed_installations[@]} -eq 0 ]; then
    		echo "All appps successfully installed!"
	else
		echo "Failed to install the following apps:"
		print_list "${failed_installations[@]}"
	fi

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

	#install_alacritty
	#install_tdrop
	echo "All done, welcome Andreas"
}

function install_apps(){
	apps=("$@")
	failed=()
	for app in  "${apps[@]}";
		do 
			out="Installing ${app}..."
			echo $out 
			if sudo apt install -y $app > /dev/null 2>&1; then
				echo "Successfully installed $app"
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
	mkdir $AUTOSTART_PATH
	gsettings set org.gnome.desktop.input-sources xkb-options "['caps:ctrl_modifier']"
	sudo cp $XCAPE_CONF $AUTOSTARTPATH/
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

	# get exsited shortcut sub folders
	EXISTED_PATHS=$(gsettings get org.gnome.settings-daemon.plugins.media-keys custom-keybindings)

	# find how many shorcut keybindings already defined, and the value will be used as the new shortcut index
	NEW_KEY_INDEX=$(dconf list /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/ | wc -l)

	NEW_KEY_PATH=$KEY_PATH_BASE/custom$NEW_KEY_INDEX/

	if [ $NEW_KEY_INDEX -gt 0 ]
	then
		NEW_PATHS=${EXISTED_PATHS%]},\ \'${NEW_KEY_PATH}\'\]  # Add the new custom folder into `custom-keybindings` key
	else
		NEW_PATHS="['$NEW_KEY_PATH']"
	fi

    #########################################################################################
	# Four steps to create a new shortcut keybinding

	# Step 1: Add one custom shortcut folder in the "Custom Shortcuts" category
	gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "${NEW_PATHS}"

	# Step 2-4: Set name, command, and binding properties of the shortcut

	$CMD_BEGINNING:$NEW_KEY_PATH name "$1"
	$CMD_BEGINNING:$NEW_KEY_PATH command "$2"
	$CMD_BEGINNING:$NEW_KEY_PATH binding "$3"


	# $CMD_BEGINNING:$NEW_KEY_PATH name $1
	# $CMD_BEGINNING:$NEW_KEY_PATH command $2
	# $CMD_BEGINNING:$NEW_KEY_PATH binding $3


}

function install_font_iosevka(){
	wget https://github.com/be5invis/Iosevka/releases/download/v3.7.1/ttf-iosevka-term-3.7.1.zip
	mkdir temp
	cp ttf-iosevka* temp/
	unzip temp/ttf-iosevka* -d temp/
	sudo cp -r temp/ttf /usr/share/fonts/
	fc-cache
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

function set_fish_conf(){
	cp -rf $FISH_CONFIG_PATH ~/.config/	
}


main "$@"; exit

# TODO Languages
# TODO Add input argument for type of tools like basic, c++, configs, office suite
