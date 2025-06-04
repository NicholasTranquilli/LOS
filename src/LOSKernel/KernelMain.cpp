int GetPixel(int x, int y)
{
    return x + (y - 1) * 320;
}

void SetPixel(int x, int y, unsigned char color)
{
    unsigned char* vga = (unsigned char*)0xA0000;
    vga[GetPixel(x, y)] = color;
}

int i_pow(int x, int factor)
{
    int result = 1;
    for (int i = 0; i < factor; i++)
        result *= x;

    return result;
}

extern "C" void kernel_main() 
{
    unsigned char* vga = (unsigned char*)0xA0000;

    // Cool broken TV lookin background
    for (int i = 0; i < 320 * 200; ++i) {
        vga[i] = (i % 256) * 12;
    }

    // How to draw a lemon with a face tutorial...

    int r = 40;         // vertical radius of the lemon in pixels
    int d = r * 2;      // vertical diameter of the lemon

    int boxSize = d * 2;   // Size of the Square around the face

    int mx = 160;       // Center X coordinate
    int my = 100;       // Center Y coordinate

    // Draw Square
    for (int i = 0; i < boxSize; i++)
        for (int j = 0; j < boxSize; j++)
            SetPixel(mx - (boxSize / 2) + j, my - (boxSize / 2) + i, 15);

    // Draw Eyes
    for (int i = -1; i <= 1; i += 2)
        SetPixel(mx + i * (r/4), my - (r/4), 0);

    // Draw Smile 1 / 2
    for (int i = (r / 2); i > 0; i--)
    {
        int x = mx - i;
        int y = my + (r / 2) - i_pow(i, 2) / r;
        SetPixel(x, y, 0);
    }

    // Draw Smile 2 / 2
    for (int i = 0; i < (r / 2); i++)
    {
        int x = mx + i;
        int y = my + (r / 2) - i_pow(i, 2) / r;
        SetPixel(x, y, 0);
    }

    // Draw Parabola Outline 1/4
    for (int i = r; i > 0; i--)
    {
        int x = mx - i;
        int y = my - r + i_pow(i, 2) / r;
        SetPixel(x, y, 0);
    }

    // Draw Parabola Outline 2/4
    for (int i = 0; i < r; i++)
    {
        int x = mx + i;
        int y = my - r + i_pow(i, 2) / r;
        SetPixel(x, y, 0);
    }

    // Draw Parabola Outline 3/4
    for (int i = r; i > 0; i--)
    {
        int x = mx - i;
        int y = my + r - i_pow(i, 2) / r;
        SetPixel(x, y, 0);
    }

    // Draw Parabola Outline 4/4
    for (int i = 0; i <= r; i++)
    {
        int x = mx + i;
        int y = my + r - i_pow(i, 2) / r;
        SetPixel(x, y, 0);
    }

    // Definitely could have done this with just 2 big parabolas
    // Same with smile, could have been just 1
    // Oh well, when life gives you lemons... make extra work for yourself?

    while (1) {}
}
