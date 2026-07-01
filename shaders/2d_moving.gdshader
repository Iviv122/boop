shader_type canvas_item;

uniform float offset;

void vertex() {
    VERTEX.x += step(0,-1.0*(VERTEX.y))*offset;
}

void fragment() {
}
