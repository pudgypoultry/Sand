// GENERATED FILE -- DO NOT EDIT.
//
// Translated from screen.vert by tools/gen_wgsl.sh (glslangValidator -DSAND_WEB, then naga).
// Edit screen.vert and re-run that script instead; edits here are overwritten and, worse,
// silently diverge from the shader the desktop build uses.
//
// source-sha256: 772e22eb2f40c1be67ba9c968dbb979aca95108e438b46975987c6448f479607

struct gl_PerVertex {
    @builtin(position) gl_Position: vec4<f32>,
    gl_PointSize: f32,
    gl_ClipDistance: array<f32, 1>,
}

struct VertexOutput {
    @builtin(position) gl_Position: vec4<f32>,
    @location(0) member: vec2<f32>,
}

var<private> positions: array<vec2<f32>, 6>;
var<private> uvs: array<vec2<f32>, 6>;
var<private> unnamed: gl_PerVertex = gl_PerVertex(vec4<f32>(0f, 0f, 0f, 1f), 1f, array<f32, 1>());
var<private> gl_VertexIndex_1: i32;
var<private> outUV: vec2<f32>;

fn main_1() {
    positions = array<vec2<f32>, 6>(vec2<f32>(-1f, -1f), vec2<f32>(1f, -1f), vec2<f32>(-1f, 1f), vec2<f32>(1f, -1f), vec2<f32>(1f, 1f), vec2<f32>(-1f, 1f));
    uvs = array<vec2<f32>, 6>(vec2<f32>(0f, 0f), vec2<f32>(1f, 0f), vec2<f32>(0f, 1f), vec2<f32>(1f, 0f), vec2<f32>(1f, 1f), vec2<f32>(0f, 1f));
    let _e20 = gl_VertexIndex_1;
    let _e22 = positions[_e20];
    unnamed.gl_Position = vec4<f32>(_e22.x, _e22.y, 0f, 1f);
    let _e27 = gl_VertexIndex_1;
    let _e29 = uvs[_e27];
    outUV = _e29;
    return;
}

@vertex 
fn main(@builtin(vertex_index) gl_VertexIndex: u32) -> VertexOutput {
    gl_VertexIndex_1 = i32(gl_VertexIndex);
    main_1();
    let _e7 = unnamed.gl_Position.y;
    unnamed.gl_Position.y = -(_e7);
    let _e9 = unnamed.gl_Position;
    let _e10 = outUV;
    return VertexOutput(_e9, _e10);
}
