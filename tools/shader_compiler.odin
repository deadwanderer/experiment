package tools

import "core:c/libc"
import "core:fmt"
import "core:os"
import "core:path/filepath"
import "core:strings"

ShaderType :: enum {
	None,
	Vertex,
	Fragment,
	Compute,
}

main :: proc() {
	curr_dir := os.get_current_directory()
	if strings.ends_with(curr_dir, "tools") || strings.ends_with(curr_dir, "bin") {
		os.change_directory("..")
		curr_dir = os.get_current_directory()
	}
	// fmt.println(curr_dir)
	shader_dir := filepath.join({curr_dir, "assets", "shaders"})
	if !os.is_dir(shader_dir) {
		fmt.eprintln("Shader dir does not exist!")
		return
	}
	output_dir := filepath.join({curr_dir, "bin", "shaders"})
	if !os.is_dir(output_dir) {
		os.make_directory(output_dir)
	}

	shd_dir_hnd, dir_err := os.open(shader_dir)
	shader_files, err := os.read_dir(shd_dir_hnd, -1)

	// fmt.println(len(shader_files))

	shd_sb := strings.builder_make()
	strings.write_string(&shd_sb, "package main\n")
	strings.write_string(&shd_sb, "ShaderType :: enum {\n")
	strings.write_string(&shd_sb, "	Vertex,\n")
	strings.write_string(&shd_sb, "	Fragment,\n")
	strings.write_string(&shd_sb, "	Compute,\n")
	strings.write_string(&shd_sb, "}\n")
	strings.write_string(&shd_sb, "Shader_Data::struct{\n")
	strings.write_string(&shd_sb, "\ttype: ShaderType,\n")
	strings.write_string(&shd_sb, "\tdxil: []byte,\n")
	strings.write_string(&shd_sb, "\tspv:  []byte,\n")
	strings.write_string(&shd_sb, "}\n")
	for file in shader_files {
		// fmt.println(file.name)
		if !strings.ends_with(file.name, ".hlsl") {continue}
		shader_type: ShaderType = .None
		if strings.contains(file.name, ".vert.") {
			shader_type = .Vertex
		} else if strings.contains(file.name, ".frag.") {
			shader_type = .Fragment
		} else if strings.contains(file.name, ".comp.") {
			shader_type = .Compute
		} else {
			fmt.eprintfln("%s not a valid shader filename", file.name)
		}
		// fmt.println(shader_type)

		if shader_type != .None {
			new_name := file.name[:len(file.name) - 5]
			// fmt.println(new_name)
			cmd := fmt.tprintf(
				"%s %s -o %s",
				filepath.join(
					{curr_dir, "tools", "shadercross.exe"},
					allocator = context.temp_allocator,
				),
				file.fullpath,
				filepath.join(
					{
						output_dir,
						strings.concatenate(
							{new_name, ".spv"},
							allocator = context.temp_allocator,
						),
					},
					allocator = context.temp_allocator,
				),
			)
			libc.system(strings.unsafe_string_to_cstring(cmd))
			cmd = fmt.tprintf(
				"%s %s -o %s",
				filepath.join(
					{curr_dir, "tools", "shadercross.exe"},
					allocator = context.temp_allocator,
				),
				file.fullpath,
				filepath.join(
					{
						output_dir,
						strings.concatenate(
							{new_name, ".dxil"},
							allocator = context.temp_allocator,
						),
					},
					allocator = context.temp_allocator,
				),
			)
			libc.system(strings.unsafe_string_to_cstring(cmd))

			stripped_name, _ := strings.replace(
				new_name,
				".",
				"_",
				-1,
				allocator = context.temp_allocator,
			)
			strings.write_string(
				&shd_sb,
				fmt.tprintf(
					"%v := Shader_Data {{\n",
					strings.to_snake_case(stripped_name, allocator = context.temp_allocator),
				),
			)
			strings.write_string(&shd_sb, fmt.tprintf("\ttype = .%v,\n", shader_type))
			strings.write_string(
				&shd_sb,
				fmt.tprintf("\tdxil = #load(\"../bin/shaders/%v.dxil\"),\n", new_name),
			)
			strings.write_string(
				&shd_sb,
				fmt.tprintf("\tspv = #load(\"../bin/shaders/%v.spv\"),\n", new_name),
			)
			strings.write_string(&shd_sb, "}\n")
		} else {
			fmt.println("Why are we here?")
		}
	}
	shader_file_output_path := filepath.join(
		{curr_dir, "src", "shader_data.odin"},
		allocator = context.temp_allocator,
	)

	os.write_entire_file(shader_file_output_path, transmute([]u8)(strings.to_string(shd_sb)))
}
