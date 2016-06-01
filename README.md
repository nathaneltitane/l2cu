# git:ldraw | L2CU
# LDraw Linux Command line Utilities (L2CU)

This project aims at providing user running Linux-based distribution with the tools to handle LDraw related batch operations on multiple models and/or project files at a time.

L2CU is split into 5 utilities that each handle a specific task, or set of tasks relative to a type of operation relative to the LDraw parts system or LDraw based digital Lego models (ldr) or model assemblies (mpd).

# make-list

'make-List' was built as a need to replace the 'mklist.exe' utility that is found and packaged with the base LDraw package.
It serves the exact same function, which is to parse and generate an updated list of all the parts located under the main 'ldraw' directory (within Ldraw/parts).
The user can create a list that either parses and sorts the content of that directory by part number or by description.
This utility comes in handy with the use of editors or other LDraw related application that do not have the ability to generate their own parts index or that rely on such a text based index to parse the Ldraw parts directory contents.

# model-export

'model-export', as its name implies, serves as a batch LDraw model file exporter, that can generate (with the use of leocad and blender) 3ds, wavefront (as obj and mtl within a zip archive) and blend compatible and optimized 3D files of the selected LDraw model(s).

Those exported formats can be used to then upload the models online for showcasing or presentation, using WebGL based services such as Sketchfab.

# model-modify
