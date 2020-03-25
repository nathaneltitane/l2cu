#!/bin/bash

# Author: Nathanel Titane - nathanel.titane@gmail.com

# L²CU # l2cu # linux ldraw command line utility #

# colors --------------------------------------------------------------------- #

if [ -z $(command -v tput) ]
then
	if [[ -t 1 ]]
	then
		black=$(echo -e \\e\[30m)
		red=$(echo -e \\e\[31m)
		green=$(echo -e \\e\[32m)
		yellow=$(echo -e \\e\[33m)
		blue=$(echo -e \\e\[34m)
		magenta=$(echo -e \\e\[35m)
		cyan=$(echo -e \\e\[36m)
		white=$(echo -e \\e\[97m)
		reset=$(echo -e \\e\[39m)
	fi
else
	if [[ -t 1 ]]
	then
		black=$(tput setaf 0)
		red=$(tput setaf 1)
		green=$(tput setaf 2)
		yellow=$(tput setaf 3)
		blue=$(tput setaf 4)
		magenta=$(tput setaf 5)
		cyan=$(tput setaf 6)
		white=$(tput setaf 7)
		reset=$(tput sgr0)
	fi
fi

# symbols -------------------------------------------------------------------- #

marker_question=$(echo \[ ? ]\ )
marker_info=$(echo \[ i ]\ )
marker_warning=$(echo \[ ! ]\ )
marker_maru=$(echo \[ 〇 ]\ )
marker_sankaku=$(echo \[ △ ]\ )
marker_batsu=$(echo \[ ✕ ]\ )
marker_yes=$(echo \[ ✓ ]\ )
marker_no=$(echo \[ ✕ ]\ )
marker_yes_no=$(echo \[ Y/N ]\ )

# version -------------------------------------------------------------------- #

version="03-01-2020"
script=$(basename -- "$0")

# usage ---------------------------------------------------------------------- #

while (($#))
do
	case "$1" in
		-directory)
			shift
			directory="$1"
			;;

# file types ----------------------------------------------------------------- #

		-all)
			extension_option="all"
			extensions_list=(ldr mpd)
			;;
		-ldr)
			extension_option="ldr"
			extensions_list=(ldr)
			;;
		-mpd)
			extension_option="mpd"
			extensions_list=(mpd)
			;;

# rendering ------------------------------------------------------------------ #

		-render)
			option="render"
			;;
		-full)
			render_option="full"
			render_preset="full"
			;;
		-fixed)
			render_option="fixed"
			render_preset="fixed"
			;;
		-outline)
			render_option="outline"
			render_preset="outline"
			;;
		-quarter-back)
			render_option="quarter-back"
			render_preset="quarter-back"
			;;
		-quarter-front)
			render_option="quarter-front"
			render_preset="quarter-front"
			;;
		-back)
			render_option="back"
			render_preset="back"
			;;
		-front)
			render_option="front"
			render_preset="front"
			;;

# exports -------------------------------------------------------------------- #

		-export)
			option="export"
			;;
		-3ds)
			export_option="3ds"
			export_extension="3ds"
			export_name="3DS"
			;;
		-blender)
			export_option="3ds"
			export_extension="blend"
			export_name="Blender"
			;;
		-collada)
			export_option="dae"
			export_extension="dae"
			export_name="Collada"
			;;
		-wavefront)
			export_option="obj"
			export_extension="obj"
			export_name="Wavefront"
			;;

# modify --------------------------------------------------------------------- #

		-modify)
			option="modify"
			;;
		-color)
			modify_option="color"
			;;
		-part)
			modify_option="part"
			;;
		-bind)
			modify_option="bind"
			;;
		-lint)
			modify_option="lint"
			;;
		-step)
			modify_option="step"
			;;
		-format)
			modify_option="format"
			;;
		-overwrite)
			overwrite_option="overwrite"
			;;

# get ------------------------------------------------------------------------ #

		-get)
			option="get"
			;;
		-update)
			get_option=update
			;;
		-unofficial)
			get_option=unofficial
			;;

# make list ------------------------------------------------------------------ #

		-make-list)
			option="make-list"
			;;
		-descritpion)
			sort_mode="description"
			;;
		-number)
			sort_mode="number"
			;;

# usage ---------------------------------------------------------------------- #

		-h|--help)
			echo -e "USAGE"
			echo -e ""
			echo -e "./$script [EXTENSION OPTION] [OPTION] [PARAMETER]"
			echo -e ""
			echo -e "Utility options:"
			echo -e ""
			echo -e "-directory \t\t Specify directory to load models from."
			echo -e ""
			echo -e "-all \t\t Selects ldr and mpd file formats as target."
			echo -e "-ldr \t\t Selects ldr file format as target."
			echo -e "-mpd \t\t Selects mpd file format as target."
			echo -e ""
			echo -e "RENDER:"
			echo -e ""
			echo -e "-render \t Renders model files using the following parameters:"
			echo -e ""
			echo -e "-full \t\t Render series of images using options 0 to 3."
			echo -e "-fixed \t\t Render series of images using options 0 and 1."
			echo -e "-quarter-back \t [ 0 ] Render image using a quarter-back view preset. \t\t [Lat.:30, Lon.: -135]"
			echo -e "-quarter-front \t [ 1 ] Render image using a quarter-front view preset. \t [Lat.:30, Lon.: 45]"
			echo -e "-back \t\t [ 2 ] Render image using a back view preset. \t\t\t [Lat.:30, Lon.: 180]"
			echo -e "-front \t\t [ 3 ] Render image using a front view preset. \t\t [Lat.:30, Lon.: 0]"
			echo -e ""
			echo -e "EXPORT:"
			echo -e ""
			echo -e "-export \t Exports model files using the following parameters:"
			echo -e ""
			echo -e "-3ds \t\t Export 3ds file format only."
			echo -e "-blender \t Export blender file format only."
			echo -e "-collada \t Export collada file format only."
			echo -e "-wavefront \t Export wavefront (obj and mtl as zip archive) file format only."
			echo -e ""
			echo -e "MODIFY:"
			echo -e ""
			echo -e "-modify \t Modifies model files using the following parameters:"
			echo -e ""
			echo -e "-color \t\t Modify a part's color attribute only."
			echo -e "-part \t\t Modify a part for another by number attribute only."
			echo -e "-bind \t\t Match a part to a specific color and modify the color for that selection."
			echo -e "-lint \t\t Standardize and format model files for parsing."
			echo -e "-step \t\t Separate ldr based submodels using step meta tags."
			echo -e "-format \t Strip and clean model files from older LDraw editor formats and set output to UTF-8 standard."
			echo -e "-overwrite \t Read from and overwrite the original model file after modification."
			echo -e ""
			echo -e "GET:"
			echo -e "-get \t\t Download the LDraw parts library. [-complete | -update | -unofficlal]"
			echo -e ""
			echo -e "-complete \t Download the LDraw parts library - complete official archive."
			echo -e "-update \t Download the LDraw parts library - update official archive."
			echo -e "-unofficial \t Download the LDraw parts library - complete unofficial archive."
			echo -e ""
			echo -e "MAKE LIST:"
			echo -e ""
			echo -e "-description \t Sort list by part description."
			echo -e "-number \t Sort list by part number."
			echo -e ""
			echo -e "USAGE:"
			echo -e ""
			echo -e "-h, --help \t Show help and usage."
			echo -e "-v, --version \t Show ${script} version."
			exit
			;;
		-v|--version)
			echo -e ""
			echo -e "$script $version"
			echo -e ""
			exit
			;;
		*)
			echo -e ""
			echo -e "$script: Unknown option $1"
			echo -e "Type './$script --help' for help and usage information."
			echo -e ""
			exit
			;;
		esac
	shift
done

# initial propmt clear ------------------------------------------------------- #

echo ""

# generate temporary file

if [[ "$option" == "export" ]]
then
	beautify=$(mktemp /tmp/beautify.XXXXXX)
	trap 'rm -rf "$beautify"' EXIT

	# push blender conversion script to temporary file

	cat > "$beautify" <<- 'PYTHON'
	#!/usr/bin/env python3

	import os
	import bpy
	from sys import argv

	context = bpy.context

	# arguments #
	# [blender, --background, --python, script, 3ds]
	# model_path = argv[4]

	# prepare scene #

	for obj in context.scene.objects:
		obj.select = True

	bpy.ops.object.delete()

	# import #

	export_model = argv[4]
	bpy.ops.import_scene.autodesk_3ds(filepath=export_model)

	# join objects #

	context.scene.objects.active = context.selected_objects[0]
	bpy.ops.object.join()

	# normalize transforms #
	bpy.ops.object.transform_apply(
		location = True,
		rotation = True,
		scale = True
	)

	# add smooth shade and edge split modifiers #

	bpy.ops.object.shade_smooth()
	bpy.ops.object.modifier_add(
		type = "EDGE_SPLIT"
	)

	# remove doubles #

	bpy.ops.object.editmode_toggle()
	bpy.ops.mesh.remove_doubles()

	# remove loose vertices #

	bpy.ops.mesh.select_loose()
	bpy.ops.mesh.delete(type='VERT')

	bpy.ops.mesh.normals_make_consistent(
		inside = False
	)
	bpy.ops.object.editmode_toggle()

	# save #

	blend_file = export_model.replace(".3ds",".blend")
	bpy.ops.wm.save_as_mainfile(
		filepath = blend_file,
		compress = True
	)

	# print output #

	print("saved as:", blend_file)
	bpy.ops.wm.quit_blender()
	PYTHON
fi

if [[  $option == "modify" ]]
then
	colors=$(mktemp /tmp/ldraw-colors.XXXXXX)
	trap 'rm -rf "$colors"' EXIT

	# push ldraw colors list to temporary file

	cat > "$colors" <<- 'COLORS'
	Black                                   0          #05131D
	Blue                                    1          #0055BF
	Green                                   2          #257A3E
	Dark_Turquoise                          3          #00838F
	Red                                     4          #C91A09
	Dark_Pink                               5          #C870A0
	Brown                                   6          #583927
	Light_Gray                              7          #9BA19D
	Dark_Gray                               8          #6D6E5C
	Light_Blue                              9          #B4D2E3
	Bright_Green                            10         #4B9F4A
	Light_Turquoise                         11         #55A5AF
	Salmon                                  12         #F2705E
	Pink                                    13         #FC97AC
	Yellow                                  14         #F2CD37
	White                                   15         #FFFFFF
	Light_Green                             17         #C2DAB8
	Light_Yellow                            18         #FBE696
	Tan                                     19         #E4CD9E
	Light_Violet                            20         #C9CAE2
	Purple                                  22         #81007B
	Dark_Blue_Violet                        23         #2032B0
	Orange                                  25         #FE8A18
	Magenta                                 26         #923978
	Lime                                    27         #BBE90B
	Dark_Tan                                28         #958A73
	Bright_Pink                             29         #E4ADC8
	Medium_Lavender                         30         #AC78BA
	Lavender                                31         #E1D5ED
	Very_Light_Orange                       68         #F3CF9B
	Light_Purple                            69         #CD6298
	Reddish_Brown                           70         #582A12
	Light_Bluish_Gray                       71         #A0A5A9
	Dark_Bluish_Gray                        72         #6C6E68
	Medium_Blue                             73         #5C9DD1
	Medium_Green                            74         #73DCA1
	Light_Pink                              77         #FECCCF
	Light_Flesh                             78         #F6D7B3
	Medium_Dark_Flesh                       84         #CC702A
	Dark_Purple                             85         #3F3691
	Dark_Flesh                              86         #7C503A
	Blue_Violet                             89         #4C61DB
	Flesh                                   92         #D09168
	Light_Salmon                            100        #FEBABD
	Violet                                  110        #4354A3
	Medium_Violet                           112        #6874CA
	Medium_Lime                             115        #C7D23C
	Aqua                                    118        #B3D7D1
	Light_Lime                              120        #D9E4A7
	Light_Orange                            125        #F9BA61
	Very_Light_Bluish_Gray                  151        #E6E3E0
	Bright_Light_Orange                     191        #F8BB3D
	Bright_Light_Blue                       212        #86C1E1
	Rust                                    216        #B31004
	Bright_Light_Yellow                     226        #FFF03A
	Sky_Blue                                232        #56BED6
	Dark_Blue                               272        #0D325B
	Dark_Green                              288        #184632
	Dark_Brown                              308        #352100
	Maersk_Blue                             313        #54A9C8
	Dark_Red                                320        #720E0F
	Dark_Azure                              321        #1498D7
	Medium_Azure                            322        #3EC2DD
	Light_Aqua                              323        #BDDCD8
	Yellowish_Green                         326        #DFEEA5
	Olive_Green                             330        #9B9A5A
	Sand_Red                                335        #D67572
	Medium_Dark_Pink                        351        #F785B1
	Earth_Orange                            366        #FA9C1C
	Sand_Purple                             373        #845E84
	Sand_Green                              378        #A0BCAC
	Sand_Blue                               379        #597184
	Fabuland_Brown                          450        #B67B50
	Medium_Orange                           462        #FFA70B
	Dark_Orange                             484        #A95500
	Very_Light_Gray                         503        #E6E3DA
	Trans_Clear                             47         #FCFCFC
	Trans_Black                             40         #635F52
	Trans_Red                               36         #C91A09
	Trans_Neon_Orange                       38         #FF800D
	Trans_Orange                            57         #F08F1C
	Trans_Neon_Yellow                       54         #DAB000
	Trans_Yellow                            46         #F5CD2F
	Trans_Neon_Green                        42         #C0FF00
	Trans_Bright_Green                      35         #56E646
	Trans_Green                             34         #237841
	Trans_Dark_Blue                         33         #0020A0
	Trans_Medium_Blue                       41         #559AB7
	Trans_Light_Blue                        43         #AEE9EF
	Trans_Very_Light_Blue                   39         #C1DFF0
	Trans_Light_Purple                      44         #96709F
	Trans_Purple                            52         #A5A5CB
	Trans_Dark_Pink                         37         #DF6695
	Trans_Pink                              45         #FC97AC
	Chrome_Gold                             334        #BBA53D
	Chrome_Silver                           383        #E0E0E0
	Chrome_Antique_Brass                    60         #645A4C
	Chrome_Black                            64         #1B2A34
	Chrome_Blue                             61         #6C96BF
	Chrome_Green                            62         #3CB371
	Chrome_Pink                             63         #AA4D8E
	Pearl_White                             183        #F2F3F2
	Pearl_Very_Light_Gray                   150        #BBBDBC
	Pearl_Light_Gray                        135        #9CA3A8
	Flat_Silver                             179        #898788
	Pearl_Dark_Gray                         148        #575857
	Metal_Blue                              137        #5677BA
	Pearl_Light_Gold                        142        #DCBE61
	Pearl_Gold                              297        #CC9C2B
	Flat_Dark_Gold                          178        #B4883E
	Copper                                  134        #964A27
	Metallic_Silver                         80         #A5A9B4
	Metallic_Green                          81         #899B5F
	Metallic_Gold                           82         #DBAC34
	Metallic_Black                          83         #1A2831
	Metallic_Dark_Gray                      87         #6D6E5C
	Milky_White                             79         #FFFFFF
	Glow_In_Dark_Opaque                     21         #E0FFB0
	Glow_In_Dark_Trans                      294        #BDC6AD
	Glitter_Trans_Dark_Pink                 114        #DF6695
	Glitter_Trans_Clear                     117        #FFFFFF
	Glitter_Trans_Purple                    129        #640061
	Speckle_Black_Silver                    132        #000000
	Speckle_Black_Gold                      133        #000000
	Speckle_Black_Copper                    75         #000000
	Speckle_Dark_Bluish_Gray_Silver         76         #635F61
	Rubber_Yellow                           65         #F5CD2F
	Rubber_Trans_Yellow                     66         #CAB000
	Rubber_Trans_Clear                      67         #FFFFFF
	Rubber_Black                            256        #212121
	Rubber_Blue                             273        #0033B2
	Rubber_Red                              324        #C40026
	Rubber_Orange                           350        #D06610
	Rubber_Light_Gray                       375        #C1C2C1
	Rubber_Dark_Blue                        406        #001D68
	Rubber_Purple                           449        #81007B
	Rubber_Lime                             490        #D7F000
	Rubber_Light_Bluish_Gra                 496        #A3A2A4
	Rubber_Flat_Silver                      504        #898788
	Rubber_White                            511        #FAFAFA
	Main_Colour                             16         #7F7F7F
	Edge_Colour                             24         #7F7F7F
	Trans_Black_IR_Lens                     32         #000000
	Magnet                                  493        #656761
	Electric_Contact_Alloy                  494        #D0D0D0
	Electric_Contact_Copper                 495        #AE7A59
	COLORS
fi

# test for utility dependencies and requirements

echo "${yellow}${marker_info}Verifying utility requirements...${reset}"
echo ""

sleep 1

binaries_list=(
	leocad
	blender
	curl
	unzip
	zip
)

for binary_name in ${binaries_list[@]}
do
	binary=$(command -v $binary_name)

	# if binary is not found or unspecified

	if [[ -z "$binary" ]]
	then
		echo "${yellow}${marker_warning}The '$binary_name' binary not found.${reset}"
		echo "${yellow}${marker_question}${marker_yes_no}Specify location?${reset}"
		echo ""

		read reply

		if [[ "$reply" = [yY] || "$reply" = [yY][eE][sS] ]]
		then
			# specify binary location or exit on 'cancel'

			binary_path=$(dialog) || exit

			binary="$binary_path/$binary"
		else
			echo "${red}${marker_no}No '$binary_name' binary installed on system.${reset}"
			echo "${yellow}${marker_info}Install '$binary_name' using your system's package manager.${reset}"
			echo "${Yellow}${marker_info}Restart this utility when '$binary_name' is installed.${reset}"
			echo "Exiting."
			echo ""

			exit 1
		fi

	# if binary exists

	elif [[ ! -z "$binary" ]]
	then
		echo "${green}${marker_yes}'$binary' binary found on system.${reset}"
		echo ""
	fi

	sleep 1
done

# dialog --------------------------------------------------------------------- #

dialog() {

	# dialog window title

	title="${script%.sh} - Load model files"

	# gtk dialog - zenity

	g_dialog() {
		zenity \
			--file-selection \
			--multiple\
			--directory \
			--separator=$'\n' \
			--title="$title" "$@"
	}

	# kde dialog - kdialog

	k_dialog() {
		kdialog \
			--getopenfilename \
			--multiple \
			--separate-output \
			--title "$title" "$@"
	}

	# define dialog usage

	if [ -z $(command -v zenity) ]
	then
		dialog=$(k_dialog)
	elif
	[ -z $(command -v kdialog) ]
	then
		dialog=$(g_dialog)
	else
		echo "${red}${marker_no}No dialog binary present on system.${reset}"
		echo "${yellow}${marker_info}This utility must be run using the 'directory' option.${reset}"
		echo "Exiting."
		echo ""

		exit 1
	fi
}

download() {

	curl -L -S  # "$@"
}

# if 'directory' option is not passed

if [[ -z "$directory" ]]
then
	echo "${cyan}${marker_question}Load model files from:${reset}"
	echo""

	# specify directory location or exit on 'cancel'

	directory=$(dialog) || exit
fi

get_library() {

	parts_archive=$(basename "$parts_url")

	# download #

	echo "Downloading..."
	echo ""

	download "$parts_url" > "$directory/$parts_archive"

	# extract #

	echo "Extracting..."
	echo ""

	unzip "$parts_archive"

	# rename #

	mv "$parts_archive" ldraw.zip
}

sleep 1

# confirm options before processing

echo ""
echo "${marker_info}Utility started using the ${cyan}$extension_option${reset} extension option."
echo "${marker_info}Utility started using the ${cyan}$option${reset} option."
echo ""

if [[ "$option" = "render" ]]
then
	echo "${marker_info}Utility started using the ${cyan}$render_option${reset} camera preset."
	echo ""

elif [[ "$option" = "export" ]]
then
	echo "${marker_info}Utility started using the ${cyan}$export_name${reset} export parameter."
	echo ""
fi

if [[ "$option" = "overwrite" ]]
then
	echo "${red}${marker_warning}WARNING:${reset}"
	echo "${red}${marker_warning}Utility started using the overwrite option.${reset}"
	echo "${red}${marker_warning}Parsed model modification will be written to file directly!${reset}"
	echo ""
fi

echo "Proceeding..."
echo ""

sleep 1

# parse #

for extension in ${extensions_list[@]}
do
	for model in $(echo $(find ${directory} -iname "*.$extension"))
	do
		# get model file name from path

		model_file="${model##*/}"

		# strip extension from model file name

		model_file_name="${model_file%.*}"

		# strip first 3 characters from model file name '00-'

		model_name="${model_file_name:3}"

# render --------------------------------------------------------------------- #

		if [[ "$option" = "render" ]]
		then
			# define render routine

			run_leocad () {

				height="4096"
				width="4096"
				extension="png"
				model=$1
				coordinates=$2

				leocad \
					-h "$height" \
					-w "$width" \
					-i "${model_name}-${view[$coordinates]}.${extension}" \
					--camera-angles ${latitude[$coordinates]} ${longitude[$coordinates]} \
					--shading ${shading} \
					--line-width ${line_width} "$model" >> /dev/null
			}

			# define render output directory

			# use model directory as root

			renders_directory="${model%/*}/renders/"

			# use render directory as root

			background_directory="${model%/*}/renders/background"

			# use render directory as root

			outline_directory="${model%/*}/renders/outline"

			# define render parameters for all presets

			# default camera latitude

			latitude=(
				30
				30
				30
				30
			)

			# default camera longitude

			longitude=(
				225
				45
				180
				0
			)

			# default view labels

			view=(
				"quarter-back"
				"quarter-front"
				"back"
				"front"
			)

			# define camera position presets

			if [[ "$render_preset" == "full" ]]
			then
				position=(0 1 2 3)
				shading=full
				line_width=1
			fi

			if [[ "$render_preset" == "fixed" ]]
			then
				position=(0 1)
				shading=full
				line_width=1
			fi

			if [[ "$render_preset" == "quarter-back" ]]
			then
				position=(0)
				shading=full
				line_width=1
			fi

			if [[ "$render_preset" == "quarter-front" ]]
			then
				position=(1)
				shading=full
				line_width=1
			fi

			if [[ "$render_preset" == "back" ]]
			then
				position=(2)
				shading=full
				line_width=1
			fi

			if [[ "$render_preset" == "front" ]]
			then
				position=(3)
			fi

			if [[ "$render_preset" == "outline" ]]
			then
				position=(1)
				shading=flat
				line_width=0

				renders_directory="$outline_directory"
			fi

			# render model using options

			echo "${marker_info}Rendering in..............: ${cyan}$renders_directory${reset}"
			echo ""

			for coordinates in ${position[@]}
			do
				# check for the renders directory existence

				if [ ! -d "$renders_directory" ]
				then
					mkdir -p "$renders_directory"
				fi

				cd "$renders_directory" || exit

				# render #

				echo "${marker_info}Rendering.................: ${cyan}${model_name^^}${reset}"
				echo "${marker_info}View......................: ${cyan}${view[coordinates]^^}${reset}"
				echo ""

				run_leocad "$model" $coordinates

				wait

				# create outline splash image

				if [[ "$render_option" == "outline" ]]
				then
					# Rename renders to designated splash images

					mv "$model_name-${view[1]}.${extension}" "${outline_directory}/outline.${extension}"
				fi
			done

			echo "${marker_info}Output....................: ${green}$renders_directory/${model_name}-${view[$coordinates]}.${extension}${reset}"
			echo ""
		fi

# export --------------------------------------------------------------------- #

		if [[ "$option" == "export" ]]
		then
			export_file="${model_name}.${export_extension}"

			# explicit export file types for optimization

			export_file_3ds="${model_name}.3ds"
			export_file_blend="${model_name}.blend"
			export_file_collada="${model_name}.dae"
			export_file_object="${model_name}.obj"
			export_file_material="${model_name}.mtl"
			export_file_archive="${model_name}.zip"

			# define model exports top directory

			# use model directory as root

			exports_directory="${model%/*}/exports/"

			# define export routine

			run_leocad () {

				echo "${marker_info}Exporting.................: ${cyan}$model${reset}"
				echo "${marker_info}Format....................: ${cyan}${export_name}${reset}"
				echo ""

				leocad "$model" "-$export_option" "$export_file" >> /dev/null

				wait
			}

			# check for the exports directory existence

			if [[ ! -d "$exports_directory" ]]
			then
				mkdir -p "$exports_directory"
			fi

			cd "$exports_directory" || exit

			# export #

			if [[ "$export_option" = "3ds" ]] || \
			   [[ "$export_option" = "dae" ]] || \
			   [[ "$export_option" = "obj" ]]
			then
				run_leocad

				wait

				if [[ "$export_option" = "obj" ]]
				then
					# archive wavefront model elements

					zip "$export_file_archive" "$export_file_object" "$export_file_material"

					# cleanup

					rm -rf {*.obj,*.mtl}
				fi

			elif [[ "$export_option" = "blender" ]]
			then
				run_leocad

				echo "${cyan}Converting $model ("$export_extension")...${reset}"
				echo ""

				# import 3ds file into blender to create optimized blend file

				blender --background --python "$beautify" "$export_file_3ds" >> /dev/null

				# cleanup #

				rm -rf "$export_file_3ds"
			fi

			# verify export file size

			model_size=$(ls -s --block-size=MB "$export_file" | awk '{print $1}')

			model_size_threshold="25"
			model_size_number="${model_size%MB}"

			# if less than threshold

			if [[ "$model_size_number" -le "$model_size_threshold" ]]
			then
				model_size_message="${green}${marker_yes}File size threshold not exceeded - [ $model_size ]${reset}"

			# if greater than threshold

			elif [[ "$model_size_number" -gt "$model_size_threshold" ]]
			then
				model_size_message="${red}${marker_yes}File size threshold exceeded - [ $model_size ]${reset}"

				model_upload_message_1="${red}${marker_warning}WARNING:${reset}"
				model_upload_message_2="${red}${marker_info}Model file size is above ${model_size_threshold}MB [ $model_size ]"
			fi

			echo ""
			echo "Model name................: $model_name"
			echo "Model size................: $model_size"
			echo ""
			echo "${model_size_message}"
			echo ""
			echo "${model_upload_message_1}"
			echo "${model_upload_message_2}"
			echo ""
		fi
	done
done

# modify --------------------------------------------------------------------- #

if [[ "$option" == "modify" ]]
then
	parse_input () {
		while true
		do
			read input

			if [[ -z $input ]]
			then
				echo "${yellow}${marker_warning}WARNING:${reset}"
				echo "${yellow}${marker_warning}Input cannot be empty.${reset}"
				echo "${yellow}${marker_warningTry again.${reset}"
				echo ""
			else
				break
			fi
		done
	}

	parse_colors () {
		parse_input

		# set to lowercase for input match

		color_input="${input,,}"

		while IFS=$' '
		read -r ldraw_color_name ldraw_color_number ldraw_color_hex_value
		do
			# color input entries cleanup

			# color name

			# remove underscores from name

			space_name="${ldraw_color_name//_/ }"

			# set name to lowercase for input match

			name="${space_name,,}"

			# reattribute input variable to lowercase name value

			ldraw_color_name="${name}"

			# color hex value

			# remove pound from name

			hex_value="${ldraw_color_hex_value//#/}"

			# set name to lowercase for input match

			hex_value="${hex_value,,}"

			# attribute input variable to lowercase name value

			ldraw_color_hex_value=${hex_value}

			if [[ "$color_input" == "$ldraw_color_name" ]] || \
			   [[ "$color_input" == "$ldraw_color_number" ]] || \
			   [[ "$color_input" == "$ldraw_color_hex_value" ]]
			then
				# confirmation

				echo "Confirming input value:"
				echo ""
				echo "${marker_info}Color name................: ${cyan}${ldraw_color_name}${reset}"
				echo "${marker_info}Color number..............: ${cyan}${ldraw_color_number}${reset}"
				echo "${marker_info}Color hexadecimal value...: ${cyan}${ldraw_color_hex_value}${reset}"
				echo ""

				return "$ldraw_color_number"
			fi

		done < "$colors"

		echo "${red}${marker_no}No available color matches the input.${reset}"
		echo "Exiting.${reset}"
		echo ""

		exit 1
	}

	parse_parts () {
		parse_input
		part_input="$input"

		return "$part_input"
	}

	# get input

	if [[ "$modify_option" = "color" ]]
	then
		echo "${cyan}Enter the color description [ name / number / hexadecimal ] to modify.${reset}"
		parse_colors

		# $? returning wrong arbitrary value

		old_color="$ldraw_color_number"

		echo "${cyan}Enter the color description [ name / number / hexadecimal ] to set.${reset}"
		parse_colors

		# $? returning wrong arbitrary value

		new_color="$ldraw_color_number"
	fi

	if [[ "$modify_option" = "part" ]]
	then
		echo "${cyan}Enter the part number to modify.${reset}"
		parse_parts

		# $? returning wrong arbitrary value

		old_part="$part_input"

		echo "${cyan}Enter the part number to set as replacement.${reset}"
		parse_parts

		# $? returning wrong arbitrary value

		new_part="$part_input"
	fi

	if [[ "$modify_option" = "bind" ]]
	then
		echo "${cyan}Enter the part number to modify.${reset}"
		parse_parts

		# $? returning wrong arbitrary value

		part_selection="$part_input"

		echo "${cyan}Enter the matching color description [ name | number | hexadecimal ] modify for the selected part.${reset}"
		parse_colors

		# $? returning wrong arbitrary value

		old_color="$ldraw_color_number"

		echo "${cyan}Enter the new color description [ name | number | hexadecimal ] to set for the selected part.${reset}"
		parse_colors

		# $? returning wrong arbitrary value for $new_color

		new_color="$ldraw_color_number"
	fi

	# substitution

	IFS=' '

	for extension in ${extensions_list[@]}
	do
		echo $(find ${directory} -iname "*.$extension") | while read -r model
		do
			model_export="${model##*/}"
			model_export_name="${model_export%.*}"
			model_export_name_clean="${model_export_name:5}"

			temporary_file="$model.tmp"

# modify: read model --------------------------------------------------------- #

			# initialize line count

			line_number=0

			# parse #

			while IFS=
			read -r line
			do
				line_number=$(( $line_number + 1 ))

				if [[ "$line" == *!LEOCAD* ]] || [[ "$line" == *FILE* ]] || [[ "$line" == *NOFILE* ]]
				then
					# skip header and footer lines containing matching patterns
					# prevents model file syntax modification

					echo "$line" >> "$temporary_file"
					continue
				else
					# read lines and parse
					# model_data is either a part file reference or a submodel

					IFS=' '
					read -r flag color x y z a b c d e f g h i model_data <<< "$line"

					vect_x="$a $b $c"
					vect_y="$d $e $f"
					vect_z="$g $h $i"

					# ⎡ a d g 0 ⎤	⎡ a b c x ⎤
					# ⎢ b e h 0 ⎥	⎢ d e f y ⎥
					# ⎢ c f i 0 ⎥	⎢ g h i z ⎥
					# ⎣ x y z 1 ⎦	⎣ 0 0 0 1 ⎦

					# set IFS

					IFS='.'

					# split part argument into part number and part extension

					read part suffix <<< "$model_data"

					IFS=' '

# modify: color -------------------------------------------------------------- #

					# color substitution

					if [[ "$modify_option" = "color" ]]
					then
						if [[ "$color" = "$old_color" ]]
						then
							color="$new_color"

							echo "${marker_info}Modifying.................: ${cyan}$model${reset}"
							echo ""
							echo "${marker_info}Changing..................: ${yellow}$old_color${reset}"
							echo "${marker_info}Setting...................: ${green}$new_color${reset} "
							echo ""
						else
							: # pass
						fi
					fi

# modify: part --------------------------------------------------------------- #

					# part substitution

					if [[ "$modify_option" = "part" ]]
					then
						if [[ "$part" = "$old_part" ]]
						then
							part="$new_part"

							echo "${marker_info}Modifying.................: ${cyan}$model${reset}"

							echo ""
							echo "${marker_info}Changing..................: ${yellow}$old_part${reset}"
							echo "${marker_info}Setting...................: ${green}$new_part${reset} "
							echo ""
						else
							: # pass
						fi
					fi

# modify: bind --------------------------------------------------------------- #

					# bind [ part + color ] color substitution

					if [[ "$modify_option" = "bind" ]]
					then
						if [[ "$part" == "$part_selection" ]]
						then
							if [[ "$color" = "$old_color" ]]
							then
								color="$new_color"

								echo "${marker_info}Modifying.................: ${cyan}$model${reset}"
								echo ""
								echo "${marker_info}Part......................: ${cyan}$part${reset}"
								echo ""
								echo "${marker_info}Changing..................: ${yellow}$old_color${reset}"
								echo "${marker_info}Setting...................: ${green}$new_color${reset} "
								echo ""
							else
								: # pass
							fi
						fi
					fi

# modify: lint --------------------------------------------------------------- #

			# model file linting

			if [[ "$modify_option" = "lint" ]]
			then
				echo "${yellow}${marker_warning}Cleaning up model file.${reset}"
				echo ""
				echo "${marker_info}Model file................: ${cyan}$model${reset}"
				echo ""

					# substitute carriage returns for newline
					# substitute multiple whitespace characters to one
					# delete lines beginning with dot
					# delete lines beginning with whitespace
					# strip '(' character
					# strip ')' character
					# delete lines containing BACKGROUND meta
					# delete lines containing PIVOT meta
					# delete lines containing HIDDEN meta
					# eliminate consecutive dot from faulty parsing # BUG #
					# eliminate consecutive step tags

				sed -i \
					-e 's/\r\ /\n/g' \
					-e 's/  */ /g' \
					-e 's/\r/\n/g'\
					-e '/^\./d' \
					-e '/^ /d' \
					-e 's/(//g' \
					-e 's/)//g' \
					-e '/BACKGROUND/d' \
					-e '/PIVOT/d' \
					-e '/HIDDEN/d' \
					-e 's/\.\ \.*//g' \
					-r ':a; N; /(0 STEP)[^\n]*\n\1/ s/\n.*//; ta; P; D' \
																			$model
			fi

# modify: step --------------------------------------------------------------- #

					# step submodel [ldr] separation

					if [[ "$modify_option" = "step" ]]
					then
							if [[ "$line" == *ldr* ]]
							then
									if [[ "$suffix" == *ldr* ]]
									then
											color="0"
											suffix="ldr\n0 STEP"
									else
											: # pass
									fi
							fi
					fi

# modify: format ------------------------------------------------------------- #

					# file structure and meta substitution

					if [[ "$modify_option" = "format" ]]
					then
						# strip lines that match the following expressions
						# comment out to keep

						if [[ "$line" = *"New Model"* ]]
						then
							: # pass

						elif [[ "$line" = *Name* ]]
						then
							: # pass

						elif [[ "$line" = *Unofficial* ]]
						then
							: # pass

						elif [[ "$line" = *Untitled* ]]
						then
							: # pass

						elif [[ "$line" == *[aA][uU][tT][hH][oO][rR]* ]]
						then
							IFS=' '
							read -r flag statement author_model author author_string <<< "$line"

							if [ ! -e "./author" ]
							then
								echo "${yellow}${marker_warning}${marker_yes_no}No author file found.${reset}"
								echo "${cyan}${marker_question}${marker_yes_no}Create author file?${reset}"
								echo ""

								read reply

								if [[ "$reply" = [yY] || "$reply" = [yY][eE][sS] ]]
								then
									echo "${cyan}${marker_info}Input author information:${reset}"
									echo ""

									parse_input

									author_input="$input"

									echo "$author_input" > ./author

									author_string=$(echo $(cat ./author))
								else
									echo "${red}${marker_warning}No author string/file specified.${reset}"
									echo "${red}${marker_warning}Skipping.${reset}"
									echo ""

									line=""
								fi

							else
								if [ -e "./author" ]
								then
									author_string=$(echo $(cat ./author))
								fi
							fi

							echo "$line" >> "$temporary_file"

						elif [[ "$line" = *BACKGROUND* ]]
						then
							IFS=' '
							read -r flag statement background_model background_background background_color bg_color_1 bg_color_2 bg_color_3 <<< "$line"

							: # pass

						elif [[ "$line" = *"GROUP BEGIN"* ]]
						then
							IFS=' '
							read -r flag statement group group_begin group_name <<< "$line"

							: # pass

						elif [[ "$line" = *"GROUP END"* ]]
						then
							IFS=' '
							read -r flag statement group group_end <<< "$line"

							: # pass

						elif [[ "$line" = *PIVOT* ]]
						then
							IFS=' '
							read -r flag statement piece pivot pivot_coordinates <<< "$line"

							: # pass

						elif [[ "$line" = *HIDDEN* ]]
						then
							IFS=' '
							read -r flag statement piece hidden <<< "$line"

							: # pass
						else
							# if line contains '!LEOCAD' tag

							if [[ "$line" == *!LEOCAD* ]]
							then
								# skip header and footer lines containing matching patterns
								# prevents model file syntax modification

								echo "$line" >> "$temporary_file"

								continue
							fi

							# if line contains 'NOFILE' tag

							if [[ "$line" == *NOFILE* ]]
							then
								# skip header and footer lines containing matching patterns
								# prevents model file syntax modification

								echo "$line" >> "$temporary_file"

								continue
							fi

							# if line contains 'FILE' tag

							if [[ "$line" == *FILE* ]]
							then
								IFS=' '
								read -r flag statement file_name <<< "$line"

								# spaces to dashes

								clean_file_name="${clean_file_name// /-}"

								# string to lower case

								clean_file_name="${clean_file_name,,}"

								# write changes to tempporary file

								echo "$flag $statement $clean_file_name" >> "$temporary_file"
							else
								# parse all other lines and format submodel string

								IFS=' '
								read -r flag color x y z a b c d e f g h i model_data <<< "$line"

								# spaces to dashes

								clean_model_data="${clean_model_data// /-}"

								# string to lower case

								clean_model_data="${clean_model_data,,}"

								vect_x="$a $b $c"
								vect_y="$d $e $f"
								vect_z="$g $h $i"

								# ⎡ a d g 0 ⎤	⎡ a b c x ⎤
								# ⎢ b e h 0 ⎥	⎢ d e f y ⎥
								# ⎢ c f i 0 ⎥	⎢ g h i z ⎥
								# ⎣ x y z 1 ⎦	⎣ 0 0 0 1 ⎦

							fi
						fi
					fi

					# reset IFS

					IFS=" "

					# write changes to tempporary file

					echo -e "$flag" "$color" "$x" "$y" "$z" "$a" "$b" "$c" "$d" "$e" "$f" "$g" "$h" "$i" "$part.$suffix" >> "$temporary_file"
				fi

			done < "$model" # feed model file into loop for parsing

			# Set current date stamp

			stamp=$(date +"%m-%d-%Y-%H-%M-%S")

# modify: overwrite ---------------------------------------------------------- #

			# write changes to file?

			if [[ "$overwrite_option" = "overwrite" ]]
			then
				echo "${red}${marker_warning}[ OVERWRITE ] option enabled!${reset}"
				echo "${red}${marker_info}Writing changes to original model file!${reset}"
				echo ""

				echo "${yellow}${marker_warning}Writing file.${reset}"
				echo ""
				echo "${marker_info}Model file................: ${cyan}$model${reset}"
				echo ""

				mv "$temporary_file" "${temporary_file%.tmp}"
			fi

			if [ -z "$overwrite_option" ]
			then
				echo "${cyan}${marker_question}${marker_yes_no}Write changes to original model file?${reset}"
				echo ""
				echo "${marker_info}Model file................: ${cyan}$model${reset}"
				echo ""

				read reply

				if [[ "$reply" = [yY] || "$reply" = [yY][eE][sS] ]]
				then
					echo "${red}${marker_warning}[ OVERWRITE ] option enabled!${reset}"
					echo "${red}${marker_info}Writing changes to original model file.${reset}"
					echo ""

					echo "${yellow}${marker_warning}Writing file.${reset}"
					echo ""
					echo "${marker_info}Model file................: ${cyan}$model${reset}"
					echo ""

					mv "$temporary_file" "${temporary_file%.tmp}"

				else
					echo "${yellow}${marker_warning}[ OVERWRITE ] option disabled.${reset}"
					echo "${yellow}${marker_info}Writing changes to model file copy.${reset}"
					echo ""
					echo "Writing changes to model file copy."
					echo ""

					mv "$temporary_file" "${temporary_file%.tmp}_modified_$stamp.$extension"
				fi
			fi
		done
	done
fi

# get ------------------------------------------------------------------------ #

if [[  "$option" = "get" ]]
then
	parts_url="https://www.ldraw.org/library/updates/complete.zip"

	complete_parts_url="https://www.ldraw.org/library/updates/complete.zip"
	update_parts_url="https://ldraw.org/library/unofficial/lcad1903.zip"
	unofficial_parts_url="https://ldraw.org/library/unofficial/ldrawunf.zip"

	if [[ "$get_option" = "complete" ]]
	then
		parts_url="$complete_parts_url"
	fi

	if [[ "$get_option" = "update" ]]
	then
		parts_url="$complete_parts_url" # workaround until html parsing is complete # TODO #
	fi

	if [[ "$get_option" = "unofficial" ]]
	then
		parts_url="$unofficial_parts_url"
	fi

	if [ -z "$directory" ]
	then
		echo "${red}${marker_question}${marker_yes_no}Specify download location?${reset}"
		echo ""

		read reply

		if [[ "$reply" = [yY] || "$reply" = [yY][eE][sS] ]]
		then
			# specify directory location or exit on 'cancel'

			browse=$(dialog) || exit

			directory="$browse"
	else
		directory="./"

		echo "${yellow}${marker_warning}No directory location specified.${reset}"
		echo "${yellow}${marker_warning}Downloading into current directory.${reset}"
		echo ""
	fi

	get_library
fi

# make list ------------------------------------------------------------------ #

if [[  "$option" = "make-list" ]]
then
	if [ -z "$directory" ]
	then
		echo "${red}${marker_warning}Is the LDraw parts library setup on this system?${reset}"
		echo "${marker_yes_no}"
		echo ""

		read reply

		if [[ "$reply" = [yY] || "$reply" = [yY][eE][sS] ]]
		then
			# specify directory location or exit on 'cancel'

			browse=$(dialog) || exit

			cd "$browse" || exit

			if [[ "$(basename $(pwd))" == [lL][dD][rR][aA][wW] ]] && [[ -d "parts" ]]
			then
				echo "${green}${marker_yes}LDraw parts library exists.${reset}"
				echo "${green}${marker_yes}Operating within the LDraw parts directory.${reset}"
				echo "Continuing."
				echo ""

				directory="$browse/parts"
			else
				echo "LDraw library directory not recognized: 'parts' directory not found."
			fi
		else
			echo "${yellow}${marker_warning}LDraw parts directory not found.${reset}"
			echo "${yellow}${marker_question}Specify the LDraw parts library directory location to continue?${reset}"
			echo "${marker_yes_no}"
			echo ""

			read reply

			if [[ "$reply" = [yY] || "$reply" = [yY][eE][sS] ]]
			then
				# specify directory location or exit on 'cancel'

				browse=$(dialog) || exit

				directory="$browse/parts"
			else
				echo "${yellow}${marker_question}${marker_yes_no}Download the latest LDraw parts library?${reset}"
				echo ""

				read reply

				if [[ "$reply" = [yY] || "$reply" = [yY][eE][sS] ]]
				then
					echo "${yellow}Specify setup location.${reset}"
					echo ""

					# specify directory location or exit on 'cancel'

					setup_directory=$(dialog) || exit

					cd "$setup_directory" || exit

					get_library

					directory="$setup_directory/[lL][dD][rR][aA][wW]/parts"
				else
					echo "${red}${marker_no}LDraw parts directory not setup on system.${reset}"
					echo ""
					echo "${yellow}${marker_warning}The parts.lst file may be needed for some legacy editors to function.${reset}"
					echo ""
					echo "${cyan}${marker_info}Visit http://www.ldraw.org to get started.${reset}"
					echo "${cyan}${marker_info}You can download and extract the LDraw parts library on your system manually.${reset}"
					echo "${cyan}${marker_info}Restart and run this utility using the 'make-list' option to generate the parts list.${reset}"
					echo "Exiting."
					echo ""

					exit 1
				fi
			fi
		fi
	fi

	cd "$directory" || exit

	# parts list verification and backup

	if [[ -e [pP][aA][rR][tT][sS].[lL][sS][tT] ]]
	then
		echo "${yellow}${marker_warning}Previous instance of the 'parts.lst file found.${reset}"
		echo "${cyan}${marker_info}Backing up...${reset}"
		echo ""

		sleep 1

		mv parts.lst parts.lst.bak
	fi

	# sorting mode verification

	if [[ "$sort_mode" == "description" ]] || [[ "$sort_mode" == "number" ]]
	then
		echo "${cyan}${marker_info}Utility startedusing the $sort_mode option flag.${reset}"
	else
		echo "${yellow}${marker_warning}No sorting method specified.${reset}"
		echo "${cyan}${marker_question}Which sorting method should be used for parsing the parts list?${reset}"
		echo "[ [dD]escription / [nN]umber ]"
		echo ""

		read reply
	fi

	if [-z "$reply" ]
	then
		exit 1
	else
		# parse parts list

		echo "Processing..."
		echo ""

		sleep 1

		# initialize counter

		count=1

		for extension in ${extensions_list[@]}
		do
			for part in $(echo $(find ${directory} -iname *.$extension))
			do
				filename="${part##*/}"
				header="$(head -n 1 "$part")"
				description="${header:2}"

				if [[ "$description" == *~Moved* ]]
				then
					: # pass
				else
					if [[ "$description" == *_* ]]
					then
						printf '%-30s %-s\n' "$filename" "$description" >> "._.lst"

					elif [[ "$description" == *~* ]]
					then
						printf '%-30s %-s\n' "$filename" "$description" >> ".~.lst"

					else
						printf '%-30s %-s\n' "$filename" "$description" >> parts.lst
					fi

					echo -ne "${marker_info}Parts count...............: ${cyan}$((count++))${reset}"'\r'
				fi
			done
		done

		# keep counter visible while looping

		echo ""

		# apply sorting method

		for list in "._.lst" ".~.lst" parts.lst
		do
			if [[ "$reply" = [dD] ]] || [[ "$sort_mode" == "description" ]]
			then
				sort -b -d -k 2 -t ' ' -o "$list" "$list"

			elif [[ "$reply" = [nN] ]] || [[ "$sort_mode" == "number" ]]
			then
				sort -b -n -k 1 -t ' ' -o "$list" "$list"
			fi
		done

		# merge #

		cat "._.lst" ".~.lst" >> parts.lst

		# cleanup #

		rm -rf "._.lst" ".~.lst"
	fi
fi

echo "${green}${marker_yes}Done.${reset}"
echo ""