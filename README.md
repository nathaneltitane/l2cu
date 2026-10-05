![l2cu](https://raw.githubusercontent.com/nathaneltitane/l2cu/main/l2cu.svg)

[![Donate](https://img.shields.io/badge/Paypal-2f343f.svg?style=for-the-badge&logo=paypal&label=Donate)](https://www.paypal.com/donate?hosted_button_id=ZW3CDCANHJCWJ)

[[ L²CU // Project Page ]](https://github.com/nathaneltitane/l2cu) [ Version // 2026-10-05 ]

---

### Welcome to [L²CU](https://l2cu.app)

L²CU uses [Frobulator](https://github.com/nathaneltitane/frobulator) to streamline the scripts and make redundant code a thing of the past.

L²CU (The LDraw Linux Command line Utility) stems from a set of independent scripts written over the last few years to respond to an obvious need for efficient management of LDraw model files in several ways, with bulk editing being one of them.

Most older and even more modern editors miss that mark to provide such features and that is where L²CU tries to fill the gap in a simple, user-friendly way.

### What can it do?

L²CU supports the standard LDraw model file extension ([ldr](https://www.ldraw.org/article/218.html)), the multi-part document (model assembly) file extension ([mpd](https://www.ldraw.org/article/47.html)) and the LDraw part file extension (dat).

In short, with L²CU you can:
- render your models
- export your models (to various 3D standard formats)
- generate building instructions, sample pages and piece counts for your models
- modify your models (color, part or part with a specific color)
- format your models in bulk (steps, linting, etc.)
- download the LDraw parts library
- create the legacy 'parts.lst' file

You can also tweak or rework the utility's functions to match your preferences.

### How does it work?

LDraw model files (ldr, mpd and even dat) are plain text files, thus making them stream edit friendly:

L²CU is a shell script (BASH) that parses and modifies the text in the model file to get the job done.
It is optimized for portability and uses a very minimal set of dependencies to get the job done.

Every model found in the selected directory (and its subdirectories) is processed - paths containing spaces included.

### What does it need?

On startup, L²CU verifies the presence of necessary dependencies before proceeding and processing the user's change request(s).
Missing dependencies are installed on request - privilege escalation is only asked for when something is missing.

You will need:

- [LeoCAD](https://github.com/leozide/leocad) - Leonardo Zide's LDraw model editor - all options
- [Blender](https://www.blender.org) - The free and open source 3D creation suite - 'blender' export
- [LPub3D](https://github.com/trevorsandy/lpub3d) - LDraw building instructions editor - 'instructions' option
- curl - 'download' option
- sed

### Usage

```
Usage: ./l2cu [EXTENSION] | [OPTION] [PARAMETER]

-d, --directory       Specify [d]irectory to load models from.
-f, --file            Specify model [f]ile extension to work on.              [ all | dat | ldr | mpd ]
-e, --export          Run model file [e]xport.                                [ 3dstudio | collada | blender | wavefront ]
-r, --render          Run model file [r]endering.                             [ full | flat | wireframe | overlay | social | thumbnail | 0 - 7 ]
-i, --instructions    Generate model [i]nstruction file.                      [ pieces | samples ]
-m, --modify          Run model file [m]odification.                          [ lint | color | part | bind | step ]
-o, --overwrite       Overwrite the original model file after modification.
-w, --download        Run do[w]nload of the LDraw parts library.              [ official | unofficial ]
-l, --list            Generate the LDraw parts [l]ist for use with legacy editors.    [ description | number ]
-h, --help            Show [h]elp and usage information.
```

Examples ↴

```
bash l2cu --file mpd --render full --directory ~/models
bash l2cu --file ldr --export collada --directory ~/models
bash l2cu --file mpd --modify step --directory ~/models/work-in-progress
```

Without a directory or file extension, L²CU asks for them - defaults are the current directory and mpd files.

### 'render'

The render function generates preset, high definition renders of the selected LDraw model files or projects (using [LeoCAD](https://github.com/leozide/leocad) to process the renders).

Renders are saved under each model's 'renders' directory:

- full: eight 4096 x 4096 views around the model (presets 0 to 7) - saved under 'renders/full'
- flat / wireframe / overlay: single view with the matching shading - saved under 'renders/[option]'
- social: single 1200 x 600 view - saved under 'renders/social'
- thumbnail: single 512 x 512 view - saved under 'renders/thumbnail'
- 0 to 7: single view preset - saved under 'renders'

View presets (latitude / longitude):

| preset | latitude | longitude |
|---|---|---|
| 0 | 30 | 0 |
| 1 | 30 | 45 |
| 2 | 30 | 90 |
| 3 | 30 | 135 |
| 4 | 30 | 180 |
| 5 | 30 | 225 |
| 6 | 30 | 270 |
| 7 | 30 | 315 |

You can refer to the [LeoCAD help manual](https://www.leocad.org/docs/start.html) to get you started on setting up your editing and rendering preferences.

### 'export'

This function serves as a 3D standard file exporter.
It can generate (with the use of LeoCAD and/or Blender) the following formats:

- collada (dae) - default
- 3dstudio (3ds)
- wavefront (obj and mtl)
- blender compatible and optimized 3D files (blend - exported through wavefront, then joined, smoothed and cleaned up in Blender)

Exports are saved under each model's 'exports' directory - files above 25 MB are flagged for their loading times.

The model exports can be used for showcase purposes, displaying them online in personal or commercial galleries (uses WebGL: [Three.JS](https://threejs.org/))

Examples:

- [mechablocks](https://mechablocks.com)
- [Sketchfab](https://sketchfab.com)

### 'instructions'

This function generates building instructions with [LPub3D](https://github.com/trevorsandy/lpub3d), based on a configuration framework (title, piece count, category and url are filled in for each model):

- default: full instructions document (pdf)
- pieces: piece count written to the model's 'pieces' file
- samples: six sample pages spread over the instructions (png) - saved under 'instructions/samples'

Models flagged with a 'work-in-progress' file receive placeholder samples instead.

### 'modify'

Here is where the batch editing happens: this feature is extremely helpful when processing massive model updates and color or part adjustments that would normally be done manually through an editor.

The script parses the model files, using the LDraw file specification syntax as reference.

The user can modify any ldr or mpd file in one of five ways:

- modify any specific color for another (color option)
- modify any specific part for another (part option)
- modify the color of a specific part to any other color for that same part (bind option)
- wrap each ldr submodel reference in its own step (step option)
- standardize the model file for parsing (lint option):
  - eliminate unwanted or extraneous meta tags
  - strip special characters from model and submodel assemblies
  - condense the model or project file by removing unneeded blank or extraneous lines that could otherwise corrupt the file

Colors can be entered by name, number or hexadecimal value - the official LDraw colors are listed when no match is found.

Only the part and submodel lines that match the request are rewritten - every other line is kept as is, line endings included.
Stray ' . . .' tails left on meta lines by earlier versions of L²CU are repaired along the way.

Modifications are written to a timestamped copy of the model file ('[model]-modified-[timestamp].[extension]') unless the overwrite option is selected.

### 'download'

The 'download' function lets you download the LDraw parts library. This is especially useful for quick updates or if you're getting started.

You can download:

- the complete 'official' LDraw parts library archive - saved as 'ldraw.zip'
- the complete 'unofficial' LDraw parts library archive - saved as 'ldrawunf.zip'

LeoCAD reads the parts library archive directly - no extraction needed.

### 'list'

The 'list' option was the initial project script that started L²CU over 6 years ago.

This (now) function was built as a need to replace the 'mklist.exe' utility that is found and packaged with the base LDraw parts library archive.
It serves the exact same purpose: parse and generate an updated list of all the parts located under the main 'LDraw' directory (within ./LDraw/parts).

The user can create a list that sorts the parts in that directory either by part number or by part description.
Moved parts are skipped - parts with descriptions starting with '_' or '~' are listed last.

This utility comes in handy with the use of editors or other LDraw related application that do not have the ability to generate their own parts index or that rely on the old text based index (parts.lst) to load parts into the editor (i.e.: [MLCAD](http://mlcad.lm-software.com/), which can be run using [Wine](https://www.winehq.org/) when using Linux-based distributions).

More modern or cutting-edge editors now generate a cached dynamic index or database on startup and do not require the list generated by this function anymore.

To find examples that make use of L²CU, or to simply browse my models, you can visit my [Blog](https://mechablocks.com) which is hosted at [GitHub](https://github.com/nathaneltitane/mechablocks) as well.

### Links:

- [Blender](https://www.blender.org) - The free and open source 3D creation suite
- [LDraw](https://www.LDraw.org) - The open standard for LEGO CAD
- [mechablocks](https://mechablocks.com) - Where Lego meets Linux
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

### Projects:

[![GitHub Repo stars](https://img.shields.io/github/stars/nathaneltitane/dextop?style=for-the-badge&logo=gnubash&logoColor=ffffff&label=DEXTOP)](https://github.com/nathaneltitane/dextop)

[![GitHub Repo stars](https://img.shields.io/github/stars/nathaneltitane/frobulator?style=for-the-badge&logo=gnubash&logoColor=ffffff&label=FROBULATOR)](https://github.com/nathaneltitane/frobulator)

[![GitHub Repo stars](https://img.shields.io/github/stars/nathaneltitane/gutengrab?style=for-the-badge&logo=gnubash&logoColor=ffffff&label=GutenGrab)](https://github.com/nathaneltitane/gutengrab)

[![GitHub Repo stars](https://img.shields.io/github/stars/nathaneltitane/l2cu?style=for-the-badge&logo=gnubash&logoColor=ffffff&label=L²CU)](https://github.com/nathaneltitane/l2cu)

[![GitHub Repo stars](https://img.shields.io/github/stars/nathaneltitane/terminal?style=for-the-badge&logo=gnubash&logoColor=ffffff&label=TERMINAL)](https://github.com/nathaneltitane/terminal)

[![GitHub Repo stars](https://img.shields.io/github/stars/nathaneltitane/mechablocks?style=for-the-badge&logo=gnubash&logoColor=ffffff&label=MECHA%20//%20BLOCKS)](https://github.com/nathaneltitane/mechablocks)

[![GitHub Repo stars](https://img.shields.io/github/stars/nathaneltitane/pixtrm?style=for-the-badge&logo=gnubash&logoColor=ffffff&label=PIXTRM)](https://github.com/nathaneltitane/pixtrm)

[![GitHub Repo stars](https://img.shields.io/github/stars/nathaneltitane/nathaneltitane?style=for-the-badge&logo=gnubash&logoColor=ffffff&label=NATHANEL%20%2b%20TITANE)](https://github.com/nathaneltitane/nathaneltitane)

[![GitHub Repo stars](https://img.shields.io/github/stars/nathaneltitane/pewpewprints?style=for-the-badge&logo=gnubash&logoColor=ffffff&label=PEW%21%20PEW%21%20PRINTS)](https://github.com/nathaneltitane/pewpewprints)

---

[[ L²CU // Project Page ]](https://github.com/nathaneltitane/l2cu) [ Version // 2026-10-05 ]

### Enjoying L²CU? Buy me a coffee to show your appreciation!

[![Donate](https://img.shields.io/badge/Paypal-2f343f.svg?style=for-the-badge&logo=paypal&label=Donate)](https://www.paypal.com/donate?hosted_button_id=ZW3CDCANHJCWJ)
