package main

Camera :: struct {
	pos:       Vec2,
	transform: Mat4,
	zoom:      f32,
	rotation:  f32,
	dirty:     bool,
}

camera_init :: proc(pos: Vec2 = {0, 0}) -> Camera {
	return {pos = pos, zoom = 1, rotation = 0, dirty = true}
}
