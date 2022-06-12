#version 430

// input/output
layout(local_size_x = 32, local_size_y = 32, local_size_z = 1) in;
layout(rgba32f, binding = 0) uniform image2D img_output;


#ifndef COLORPALLETE_INCLUDED
#define COLORPALLETE_INCLUDED
#endif


// Returns a color based on the index
vec4 GetColor(int numIterations, vec4 color) {	
    uint index = uint(mod(numIterations, 16));
	
    switch (index)
	{
		case 0:
		{
			color[0] = 66.0f / 255.0f;
			color[1] = 30.0f / 255.0f;
			color[2] = 15.0f / 255.0f;

			break;
		}
		case 1:
		{
			color[0] = 25.0f / 255.0f;
			color[1] = 7.0f / 255.0f;
			color[2] = 26.0f / 255.0f;
			break;
		}
		case 2:
		{
			color[0] = 9.0f / 255.0f;
			color[1] = 1.0f / 255.0f;
			color[2] = 47.0f / 255.0f;
			break;
		}

		case 3:
		{
			color[0] = 4.0f / 255.0f;
			color[1] = 4.0f / 255.0f;
			color[2] = 73.0f / 255.0f;
			break;
		}
		case 4:
		{
			color[0] = 0.0f / 255.0f;
			color[1] = 7.0f / 255.0f;
			color[2] = 100.0f / 255.0f;
			break;
		}
		case 5:
		{
			color[0] = 12.0f / 255.0f;
			color[1] = 44.0f / 255.0f;
			color[2] = 138.0f / 255.0f;
			break;
		}
		case 6:
		{
			color[0] = 24.0f / 255.0f;
			color[1] = 82.0f / 255.0f;
			color[2] = 177.0f / 255.0f;
			break;
		}
		case 7:
		{
			color[0] = 57.0f / 255.0f;
			color[1] = 125.0f / 255.0f;
			color[2] = 209.0f / 255.0f;
			break;
		}
		case 8:
		{
			color[0] = 134.0f / 255.0f;
			color[1] = 181.0f / 255.0f;
			color[2] = 229.0f / 255.0f;
			break;
		}
		case 9:
		{
			color[0] = 211.0f / 255.0f;
			color[1] = 236.0f / 255.0f;
			color[2] = 248.0f / 255.0f;
			break;
		}
		case 10:
		{
			color[0] = 241.0f / 255.0f;
			color[1] = 233.0f / 255.0f;
			color[2] = 191.0f / 255.0f;
			break;
		}
		case 11:
		{
			color[0] = 248.0f / 255.0f;
			color[1] = 201.0f / 255.0f;
			color[2] = 95.0f / 255.0f;
			break;
		}
		case 12:
		{
			color[0] = 255.0f / 255.0f;
			color[1] = 170.0f / 255.0f;
			color[2] = 0.0f / 255.0f;
			break;
		}
		case 13:
		{
			color[0] = 204.0f / 255.0f;
			color[1] = 128.0f / 255.0f;
			color[2] = 0.0f / 255.0f;
			break;
		}
		case 14:
		{
			color[0] = 153.0f / 255.0f;
			color[1] = 87.0f / 255.0f;
			color[2] = 0.0f / 255.0f;
			break;
		}
		case 15:
		{
			color[0] = 106.0f / 255.0f;
			color[1] = 52.0f / 255.0f;
			color[2] = 3.0f / 255.0f;
			break;
		}
	}
	
    return color;
}

// Fractal variables
uint maxIterations = 255;
double re_s = -2;
double re_e = 1;
double im_s = -1.1;
double im_e = 1.1;


void main() {

    ivec3 id = ivec3(gl_GlobalInvocationID.xyz);

    ivec2 screen_size = imageSize(img_output);
    int width = screen_size.x;
    int height = screen_size.y;

    double c_re, c_im;
    double re, im;
    double re2, im2;

    re = 0;
    im = 0;
    c_re = re_s + (double(id.x) / width) * (re_e - re_s);
    c_im = im_s + (double(id.y) / height) * (im_e - im_s);

    int numIterations = 0;
    vec4 color = {0.0, 0.0, 0.0, 1.0};

    for (int i = 0; i < maxIterations; i++)
    {
        re2 = re * re;
        im2 = im * im;
        if (re2 + im2 > 4)
        {
            break;
        }
        else
        {
            im = (2 * re * im) + c_im;
            re = (re2 - im2) + c_re;
            numIterations++;
        }
    }

    // Assign color based on numIterations
    if (numIterations != maxIterations)
    {
        color = GetColor(numIterations, color);
    }

    imageStore(img_output, ivec2(id.xy), color);
}