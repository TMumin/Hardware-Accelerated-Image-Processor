from PIL import Image, ImageOps

img = Image.open("test.jpg").convert("RGB")
img = ImageOps.fit(img, (320, 240), Image.LANCZOS)  # crop to 4:3, then resize

# preview with the same 4-bit-per-channel color the board will use
preview = img.point(lambda v: (v >> 4) * 17)
preview.save("preview.png")

with open("image.mem", "w") as f:
    for y in range(240):
        for x in range(320):
            r, g, b = img.getpixel((x, y))
            f.write(f"{(r >> 4):X}{(g >> 4):X}{(b >> 4):X}\n")