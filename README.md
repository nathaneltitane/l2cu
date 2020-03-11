### L²CU: LDraw Linux Command line Utility

<p align="center">
  <img src="https://img.shields.io/github/issues/nathaneltitane/ldraw?color=lightgrey&style=flat-square">
  <img src="https://img.shields.io/github/forks/nathaneltitane/ldraw?color=lightgrey&style=flat-square">
  <img src="https://img.shields.io/github/stars/nathaneltitane/ldraw?color=lightgrey&style=flat-square">
</p>

This project aims at providing any user running a Linux-based distribution with the tools to handle LDraw model file related operations, on multiple models and/or project files at the same time.

L²CU stems from a set of independant scripts that were written over the last few years to respond to an obvious need for an efficient management of LDraw model files in several ways: bulk editing of tags properties and attributes.

Most older and even more modern editors miss that mark to provide such features and that is where L²CU tries to fill the gap in a simple, user-friendly way.

### What can it do?

L²CU supports the standard 'single-part' model file extension (ldr) and the multipart data, or model assembly file extension (mpd).

It offers several features amongst which rendering and exporting your models: this is particularly interesting since it can turn your creations into image and 3D content (standard 3D formats), letting you publish and share them without compromising your build information (if you do not wish to share the actual model file).

You can also tweak or rework the utility's functions to match your preferences or work with certain meta tags commonly found in the model files (used by modern editors such as LeoCAD) and format them just the way you'd like.

In short, L²CU is split into several functions to make the most out of your LDraw model files. 

You can:
- render your models
- export your models (to various 3D standard formats)
- modify your models(color, part or part with a specific color)
- format your models in bulk (meta tags, steps, linting, etc.)
- download and unpack the LDraw parts library
- create the legacy 'parts.lst' file

For a quick preview of the most up-to-date capabilities, you can call `./l2cu.sh --help` on your terminal emulator to see what's currently supported in L²CU.

### How does it work?

L²CU is a shell script, with BASH (Bourne Again Shell)  as its backbone: the now monolithic utility is optimized for portability and uses a very minimal set of dependencies to get the job done.

LDraw model files (ldr, mpd and even dat) are plain text files, thus making them stream edit friendly.
L²CU parses the model file, reads each line contained in it and processes the values to modify or format the file according to your needs.

### What does it need?

On startup, L²CU verifies the presence of necessary dependencies before proceeding and pocessing the user's request.
That being said, the user may wish to build or install the following requirements prior to using this utility for convenience's sake:

- [LeoCAD](https://github.com/leozide/leocad) - Leonardo Zide's LDraw model editor

- [Blender](https://www.blender.org) - The free and open source 3D creation suite

- curl, sed, zip, unzip - common utilities either already set up on your Linux-based system or that you can easily install using your distribution's package manager/installer (i.e.: apt, dnf, etc.)

### render

The render function generates preset, high defintion renders, of the selected LDraw model files or projects (using leocad to process the renders).

The user can choose from set defaults or specify the latitude and longitude parameters of the camera, as well as a file saving suffix to register the coordinates as a viewing angle string to the file name:

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

Please refer to the [LeoCAD help manual](https://www.leocad.org/docs/start.html) to get you started on setting up your editing and rendering preferences.

### export

This function serves as a 3D standard file exporter. It can generate (with the use of Leocad and/or Blender) 3ds, wavefront (as obj and mtl within a zip archive) and blend compatible and optimized 3D files of the selected LDraw model(s) or project files.

Those exports can then be used to upload the models online for showcase purposes, displaying them online in personal or commercial galleries (using WebGL: [ThreeJS](https://threejs.org/), [LegoLinux](https://legolinux.com), [Sketchfab](https://sketchfab.com)).

### modify

This portion of the utility is the more interesting one: it serves as a batch editing tool to modify model files at the part level for both ldr and mpd file extensions.

It can be extremely helpful in the case of massive model updates and color or part adjustments that would normally be done manually through an editor.

It uses stream editing to find and replace the desired elements, using the LDraw file specification syntax as reference.

The user can modify any ldr or mpd file in one of four ways:

- modify any specific color for another (color option)
- modify any specific part for another (part option)
- modify the color of a specific part to any other color for that same part (bind option)
- modify or eliminate unwanted or extraneous meta tags
- strip special characters from model and submodel assemblies
- condense the model or project file by removing unneded blank or extraneous lines that could otherwise corrupt the file

### get

The 'get' function lets you download and extract the LDraw parts library. This is especially useful for quick updates or if you're getting started.

You can:

- download the LDraw parts library using the -complete | -update | -unofficlal parameters.
- download the 'complete' official LDraw parts library archive
- download the 'update' officialLDraw parts library archive
- download the complete 'unofficial' LDraw parts library archive

### 'make-list'

The 'make-list' option was the initial project that inadvertantly started the L²CU project over 6 years ago. This function was built as a need to replace the 'mklist.exe' utility that is found and packaged with the base LDraw parts library.
It serves the exact same function, which is to parse and generate an updated list of all the parts located under the main 'LDraw' directory (within ./LDraw/parts).

The user can create a list that sorts the parts in that directory either by part number or by description.

This utility comes in handy with the use of editors or other LDraw related application that do not have the ability to generate their own parts index or that rely on such a text based index to parse the LDraw parts directory contents.

The parts list acts as an index and is often required for legacy editors (i.e.: MLCAD, which can be run using wine under Linux-based distributions).

Most modern editors now generate a cached, per-session dynamic index on launch and do not require this list anymore.

To find examples that make use of L²CU, or to simply browse my models, you can visit my [Blog](https://legolinux.com) which is hosted at [GitHub](https://github.com/nathaneltitane/legolinux.github.io) as well.

***

### Links

- [LDraw](https://www.LDraw.org) - The open standard for LEGO CAD
- [LeoCAD](https://github.com/leozide/leocad) - A CAD program for creating virtual LEGO models
- [Blender](https://www.blender.org) - The free and open source 3D creation suite
- [ThreeJS](https://threejs.org) - JavaScript 3D library
- [LegoLinux](https://legolinux.com) - Where Lego meets Linux
- [Sketchfab](https://sketchfab.com) - Publish & find 3D models online

***

[Submit bug report or feature request](https://github.com/nathaneltitane/LDraw/issues)
