#!/usr/bin/env python3

import os
import bpy
context = bpy.context

# prepare scene #

for obj in context.scene.objects:
	obj.select = True

bpy.ops.object.delete()

# read file path from file #

with open("/tmp/model_file", "r") as file:
	export_model = file.read().rstrip()

# import #

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
