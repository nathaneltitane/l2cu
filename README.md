![l2cu](https://raw.githubusercontent.com/nathaneltitane/l2cu/main/l2cu.svg)

[![Donate](https://img.shields.io/badge/Paypal-2f343f.svg?style=for-the-badge&logo=paypal&label=Donate)](https://www.paypal.com/donate?hosted_button_id=ZW3CDCANHJCWJ)

[[ L²CU // Project Page ]](https://github.com/nathaneltitane/l2cu) [ Version // 01-21-2023 ]

---

### Welcome to [L²CU](https://l2cu.app)

L²CU uses [Frobulator](https://github.com/nathaneltitane/frobulator) to streamline the scripts and make redundant code a thing of the past.

L²CU (The LDraw Linux Command line Utility) stems from a set of independent scripts written over the last few years to respond to an obvious need for efficient management of LDraw model files in several ways, with bulk editing being one of them.

Most older and even more modern editors miss that mark to provide such features and that is where L²CU tries to fill the gap in a simple, user-friendly way.

### What can it do?

L²CU supports the standard LDraw model file extension ([ldr](https://www.ldraw.org/article/218.html)) and the multi-part document (model assembly) file extension ([mpd](https://www.ldraw.org/article/47.html)).

In short, with L²CU you can:
- render your models
- export your models (to various 3D standard formats)
- modify your models (color, part or part with a specific color)
- format your models in bulk (meta tags, steps, linting, etc.)
- download and unpack the LDraw parts library
- create the legacy 'parts.lst' file

You can also tweak or rework the utility's functions to match your preferences.

### How does it work?

LDraw model files (ldr, mpd and even dat) are plain text files, thus making them stream edit friendly:

L²CU is a shell script (BASH) that parses and modifies the text in the model file to get the job done.
It is optimized for portability and uses a very minimal set of dependencies to get the job done.

### What does it need?

On startup, L²CU verifies the presence of necessary dependencies before proceeding and pocessing the user's change request(s).

You will need:

Common utilities either already set up on your Linux-based system or that you can easily install using your distribution's package manager:

- curl
- sed
- zip
- unzip

The 'render' and 'export' features depend on the following. Install them before processing:

- [LeoCAD](https://github.com/leozide/leocad) - Leonardo Zide's LDraw model editor
- [Blender](https://www.blender.org) - The free and open source 3D creation suite

### 'render'

The render function generates preset, high defintion renders, of the selected LDraw model files or projects (using [LeoCAD](https://github.com/leozide/leocad) to process the renders).

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

You can refer to the [LeoCAD help manual](https://www.leocad.org/docs/start.html) to get you started on setting up your editing and rendering preferences.

### 'export'

This function serves as a 3D standard file exporter.
It can generate (with the use of Leocad and/or Blender) the following formats:

- 3ds
- wavefront (as obj and mtl within a zip archive)
- blender compatible and optimized 3D files

The model exports can be used for showcase purposes, displaying them online in personal or commercial galleries (uses WebGL: [Three.JS](https://threejs.org/))

Examples:

- [LegoLinux](https://legolinux.com)
- [Sketchfab](https://sketchfab.com)

### 'modify'

Here is where the batch editing happens: this feature is extremely helpful when processing massive model updates and color or part adjustments that would normally be done manually through an editor.

The script uses stream editing to find and replace the desired elements, using the LDraw file specification syntax as reference.

The user can modify any ldr or mpd file in one of four ways:

- modify any specific color for another (color option)
- modify any specific part for another (part option)
- modify the color of a specific part to any other color for that same part (bind option)
- modify or eliminate unwanted or extraneous meta tags
- strip special characters from model and submodel assemblies
- condense the model or project file by removing unneded blank or extraneous lines that could otherwise corrupt the file

### 'get'

The 'get' function lets you download and extract the LDraw parts library. This is especially useful for quick updates or if you're getting started.

You can:

- download the LDraw parts library using the -complete, -update, or -unofficlal parameters.
- download the 'complete' official LDraw parts library archive
- download the 'update' officialLDraw parts library archive
- download the complete 'unofficial' LDraw parts library archive

### 'make-list'

The 'make-list' option was the initial project script that started L²CU over 6 years ago.

This (now) function was built as a need to replace the 'mklist.exe' utility that is found and packaged with the base LDraw parts library archive.
It serves the exact same purpose: parse and generate an updated list of all the parts located under the main 'LDraw' directory (within ./LDraw/parts).

The user can create a list that sorts the parts in that directory either by part [n]umber or by part [d]escription.

This utility comes in handy with the use of editors or other LDraw related application that do not have the ability to generate their own parts index or that rely on the oldtext based index (parts.lst) to load parts into the editor (i.e.: [MLCAD](http://mlcad.lm-software.com/), which can be run using [Wine](https://www.winehq.org/) when using Linux-based distributions).

More modern or cutting-edge editors now generate a cached dynamic index or database on startup and do not require the list generated by this function anymore.

To find examples that make use of L²CU, or to simply browse my models, you can visit my [Blog](https://legolinux.com) which is hosted at [GitHub](https://github.com/nathaneltitane/legolinux) as well.

### Links:

- [Blender](https://www.blender.org) - The free and open source 3D creation suite
- [LDraw](https://www.LDraw.org) - The open standard for LEGO CAD
- [LegoLinux](https://legolinux.com) - Where Lego meets Linux
- [LeoCAD](https://leocad.org) - A CAD program for creating virtual LEGO models
- [MLCAD](http://mlcad.lm-software.com/) - Mike's Lego CAD
- [Three.JS](https://threejs.org) - JavaScript 3D library
- [Sketchfab](https://sketchfab.com) - Publish & find 3D models online
- [Wine](https://www.winehq.org/) - Windows compatibility layer for POSIX-compliant operating systems

### Repositories:

[Frobulator](https://github.com/nathaneltitane/frobulator) to streamline the scripts and make redundant code a thing of the past.

[LeoCAD](https://github.com/leozide/leocad) to export LDraw models into an exploitable 3D format via L²CU.

[LPub3D](https://github.com/trevorsandy/lpub3d) to generate instructions out of the models submitted to L²CU.

[Three.JS](https://github.com/mrdoob/three.js) to create the viewer used to render and display my models on your web browser.

[GNU/Bash](https://github.com/gitGNU/gnu_bash) as the shell environment on top of which the scripts function.

### Reports:

[Submit bug report or feature request](https://github.com/nathaneltitane/l2cu/issues)

### Other Projects:

[![GitHub Repo stars](https://img.shields.io/github/stars/nathaneltitane/dextop?style=for-the-badge&logo=gnubash&logoColor=ffffff&label=DEXTOP)](https://github.com/nathaneltitane/dextop)

[![GitHub Repo stars](https://img.shields.io/github/stars/nathaneltitane/frobulator?style=for-the-badge&logo=gnubash&logoColor=ffffff&label=FROBULATOR)](https://github.com/nathaneltitane/frobulator)

[![GitHub Repo stars](https://img.shields.io/github/stars/nathaneltitane/terminal?style=for-the-badge&logo=gnubash&logoColor=ffffff&label=TERMINAL)](https://github.com/nathaneltitane/terminal)

[![GitHub Repo stars](https://img.shields.io/github/stars/nathaneltitane/legolinux?style=for-the-badge&logo=gnubash&logoColor=ffffff&label=LEGO//LINUX)](https://github.com/nathaneltitane/legolinux)

[![GitHub Repo stars](https://img.shields.io/github/stars/nathaneltitane/pixtrm?style=for-the-badge&logo=gnubash&logoColor=ffffff&label=PIXTRM)](https://github.com/nathaneltitane/pixtrm)

[![GitHub Repo stars](https://img.shields.io/github/stars/nathaneltitane/nathaneltitane?style=for-the-badge&logo=gnubash&logoColor=ffffff&label=NATHANEL+TITANE)](https://github.com/nathaneltitane/nathaneltitane)

[![GitHub Repo stars](https://img.shields.io/github/stars/nathaneltitane/pewpewprints?style=for-the-badge&logo=gnubash&logoColor=ffffff&label=PEWPEWPRINTS)](https://github.com/nathaneltitane/pewpewprints)

---

[[ L²CU // Project Page ]](https://github.com/nathaneltitane/l2cu) [ Version // 01-21-2023 ]

### Enjoying L²CU? Buy me a coffee to show your appreciation!

[![Donate](https://img.shields.io/badge/Paypal-2f343f.svg?style=for-the-badge&logo=paypal&label=Donate)](https://www.paypal.com/donate?hosted_button_id=ZW3CDCANHJCWJ)
