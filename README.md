### L²CU: LDraw Linux Command line Utilities

This project aims at providing any user running a Linux-based distribution with the tools to handle LDraw model file related batch operations on multiple models and/or project files at the same time.

L²CU stems from a set of independant scripts that were written over the last few years to respond to an obvious need for efficientmanagement of Ldraw model files in various ways, be it part, color, submodel or format editing, where most of the modern editors fail to provide such obvious features.

The BASH shell is what makes the L²CU backbone: the now monolithic utilityaims to pearate while being optimized for portability and uses a very minimal set of dependencies to get the job done.


### What does it do?

L²CU also offers rendering and export features to standard 3D formats, making your models shareable and visible without compromising your build information (if you do not wish to share the actual model file).

It supports the standard 'single-part' model file extension (ldr) and the multipart data, or model assembly file extension (mpd).

You can rework the utility'S functions to match or ignore certain meta tags commonly found in the model files (used by modern editors such as LeoCAD) and format them just the way you'd like.

### How does it work?

LDraw model files (ldr, mpd and even dat) are plain text files, thus making them stream edit friendly.
L²CU parses the model file, reads each line contained in it and processes the values to modify or format the file according to your needs.

### What does it need?

On startup, L²CU verifies the presence of necessary dependencies before proceeding and pocessing the user's request.
That being said,the user may wish to build or install the following requirements prior to using this utility for convenience's sake:

- [LeoCAD](https://github.com/leozide/leocad) - Leonardo Zide's multiplatform LDraw compatible model editor

- [LDView](https://github.com/tcobbs/ldview) - Travis Cobb's real-time 3D viewer for displaying LDraw models [*]
- [ldview](https://github.com/tcobbs/ldview) (ldview-osmesa) - the command line version of the LDView renderer [*]

- [Blender](https://www.blender.org/) - The free and open source 3D creation suite

- curl, sed, zip, unzip - common utilities either already set up on your Linux-based system or that you can easily install using your distribution's package manager/installer (i.e.: apt, dnf, etc.)

  
###### [*] Deprecated in latest L²CU updates to the benefit of LeoCAD as an all in one solution for most functions.

### What can I do with L²CU?

L²CU is split into wseveral functions to make the most out of your Ldraw model files.

### make-list

'ldraw-make-List' was built as a need to replace the 'mklist.exe' utility that is found and packaged with the base LDraw package.
It serves the exact same function, which is to parse and generate an updated list of all the parts located under the main 'ldraw' directory (within Ldraw/parts).

The user can create a list that either parses and sorts the content of that directory by part number or by description.

This utility comes in handy with the use of editors or other LDraw related application that do not have the ability to generate their own parts index or that rely on such a text based index to parse the Ldraw parts directory contents.

The list that is generated is frequently used for legacy editors (such as MLCAD, which can be run using wine) to provide it with an index of parts to locate and use. Most modern editors generate a cached session dynamic index on launch and do nor require this list anymore.

### export

'ldraw-model-export', as its name implies, serves as a batch LDraw model file exporter, that can generate (with the use of leocad and blender) 3ds, wavefront (as obj and mtl within a zip archive) and blend compatible and optimized 3D files of the selected LDraw model(s).

Those exported formats can be used to then upload the models online for showcasing or presentation, using WebGL based services such as Sketchfab.

### modify

'ldraw-model-modify' serves as a bulk editing tool to enable batch editing and modification of LDraw based digital Lego model files and projects.

It can be extremely helpful in the case of massive model updates or adjustments that would normally be done manually through any LDraw model editor.

It uses stream editing to find and replace the appropriate string elements from the known syntax of the LDraw file specification.

The user can modify any ldr or mpd file in one of four ways:
- modify any specific color for another (color option)
- modify any specific part for another (part option)
- modify the color of a specific part to any other color for that same part (bind option)
- strip and clean the model file for unwanted or extraneous meta tags and condense it to suitable parameters (format option)

### render

'ldraw-model-render' enables the user to generate preset, high defintion renders, of the selected LDraw model files or projects (using leocad as the main rendering engine).

The user can choose from preselected defaults or specify the latitude and longitude parameters of the camera as well as a file saving suffix to register the coordinates as a viewing angle to the file name:

Defaults (as arrays):

latitude=(
	30
	30
	30
	30
)

longitude=(
	225
	45
	180
	0
)

view=(
	"quarter-back"
	"quarter-front"
	"back"
	"front"
)

Please refer to the [LeoCAD help manual](https://www.leocad.org/docs/start.html) to get you started on setting up your editing and rendering preferences to generate the output desired using the visual settings and angles of your choice.

Feel free to follow developments and new model builds at my [Blog](http://www.legolinux.com) or follow the [Sketchfab Blog](https://blog.sketchfab.com/tag/ldraw/) for *Sketchfab*/*LDraw* tutorials and editorials!

### [Submit bug report or feature request](https://github.com/nathaneltitane/ldraw/issues)
### [Submit pull request](https://github.com/nathaneltitane/ldraw/pulls)

### [LDraw](https://www.ldraw.org)
