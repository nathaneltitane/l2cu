###### git:ldraw | L2CU
###### LDraw Linux Command line Utilities (L2CU)

This project aims at providing user running Linux-based distribution with the tools to handle LDraw related batch operations on multiple models and/or project files at a time.

It is mostly centered around the use of the BASH shell and opearates using minimal dependencies.

The utilities verify the presence of the required applications and other dependencies before proceeding but the user may wish to build or install the following requirements prior to using these scripts for a more streamlined experience:

- [LDView - Travis Cobb's real-time 3D viewer for displaying LDraw models] (http://ldview.sourceforge.net/)
- [ldview (a.k.a. ldview-osmesa - the command line version of the LDView renderer)] (http://ldview.sourceforge.net/)
- [LeoCAD - Leonardo Zide's multiplatform LDraw compatible model editor] (http://leocad.org/trac)

L2CU is split into 5 utilities that each handle a specific task, or set of tasks relative to a type of operation relative to the LDraw parts system or LDraw based digital Lego models (ldr) or model assemblies (mpd).

###### [make-list] (https://github.com/nathaneltitane/ldraw/blob/master/make-list)

'make-List' was built as a need to replace the 'mklist.exe' utility that is found and packaged with the base LDraw package.
It serves the exact same function, which is to parse and generate an updated list of all the parts located under the main 'ldraw' directory (within Ldraw/parts).
The user can create a list that either parses and sorts the content of that directory by part number or by description.
This utility comes in handy with the use of editors or other LDraw related application that do not have the ability to generate their own parts index or that rely on such a text based index to parse the Ldraw parts directory contents.

###### [model-export] (https://github.com/nathaneltitane/ldraw/blob/master/model-export)

'model-export', as its name implies, serves as a batch LDraw model file exporter, that can generate (with the use of leocad and blender) 3ds, wavefront (as obj and mtl within a zip archive) and blend compatible and optimized 3D files of the selected LDraw model(s).

Those exported formats can be used to then upload the models online for showcasing or presentation, using WebGL based services such as Sketchfab.

###### [model-modify] (https://github.com/nathaneltitane/ldraw/blob/master/model-modify)

'model-modify' serves as a bulk editing tool to enable batch editing and modification of LDraw based digital Lego model files and projects.

It can be extremely helpful in the case of massive model updates or adjustments that would normally be done manually through the LDraw model editor.

It uses stream editing to find and replace the appropriate string elements from the known syntax of the LDraw file specification.

The user can modify any ldr or mpd file in one of three ways:
- modify any specific color for another (color option)
- modify any specific part for another (part option)
- modify the color of a specific part to any other color for that same part (bind option)

###### [model-render] (https://github.com/nathaneltitane/ldraw/blob/master/model-render)

'model-render' enables the user to generate preset high defintion renders of the selected LDraw model files or projects (using ldview) as the main rendering engine.

The user is required to specify the latitude and longitude parameters of the camera as well as a file saving suffix to register the coordinates as a viewing angle to the file name:

Defaults (as array): coordinates=("latitude,longitude") view=("Current View File Suffix")

coordinates=(
  "30,-135"
  "30,45"
  "30,180"
  "30,0"
)

view=(
	"Quarter Back"
	"Quarter Front"
	"Back"
	"Front"
)

Please refer to LDView's help manual to get you started on setting up your LDview/ldview preferences to generate the renderings using the visual settings and angles of your choice.

###### [model-upload] (https://github.com/nathaneltitane/ldraw/blob/master/model-upload)

'model-upload' is a complementary utility to 'model-export'. It enables the user to batch upload the exported and optimized 3D formats to [Sketchfab] (https://sketchfab.com) for public or private hosting and viewing of the selected models.

This utility is extremly useful in the case of multiple unique model uploads (new) or model updates, which would normally take minutes per model, and thus making several updates or uploads a daunting task.

The user must already be registered to the Sketchfab services and obtain the [API token] (https://sketchfab.com/settings/password) needed to enable communication with the hosting servers, for uploading, updating and setting environment and camera parameters to the uploaded files.

The utility also warns of the limitation of free subscription accounts: the model file size limit is set to 50Mb. If and when possible, the exported format will be compressed to limit the file size and prevent any errors while uploading.

An example of the output from both 'model-export' and 'model-upload' can be seen [here] (https://sketchfab.com/nathaneltitane/models): the models are optimized and fused single-object blend files exported from either mpd or ldr formats and uploaded or updated on a regular basis.
