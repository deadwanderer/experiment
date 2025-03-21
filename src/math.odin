package main

import "core:math"
import "core:math/linalg"

// Types
Vec2 :: linalg.Vector2f32
Vec3 :: linalg.Vector3f32
Vec4 :: linalg.Vector4f32
Mat4 :: linalg.Matrix4x4f32

Vec2i :: [2]int
Vec3i :: [3]int

// Vector ops
normalize :: linalg.vector_normalize
cross :: linalg.vector_cross3

// Matrix ops
look_at :: linalg.matrix4_look_at_f32
perspective :: linalg.matrix4_perspective_f32
orthographic :: linalg.matrix_ortho3d_f32

// Math ops
sin :: math.sin_f32
cos :: math.cos_f32
radians :: math.to_radians_f32
