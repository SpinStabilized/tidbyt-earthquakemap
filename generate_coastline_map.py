"""Earthquake Map utility to generate maps.

This source needs to be better documented and cleaned up. Save for future
release.
"""
from PIL import Image, ImageDraw
import json
import math

coastline_map = 'data/earth-coastlines-10km.geo.json'

def map_projection(longitude, latitude, screen_width=64, screen_height=32):
    """Project's a map longitude/latitude to screen coordinates.

    Args:
        longitude: A map coordinate longitude
        latitude: A map coordinate latitude
        screen_width: size of the screen/image to project to
        screen_height: height of the screen/image to project to

    Returns:
        An (x, y) tuple in the screen/image pixel coordinates
    """
    radius = screen_width / (2 * math.pi)
    longitude_radians = math.radians(longitude + 180)
    latitude_radians = math.radians(latitude)

    x = longitude_radians * radius
    y_from_eq = radius * math.log(math.tan(math.pi / 4 + latitude_radians / 2))
    y = screen_height / 2 - y_from_eq
    return int(x), int(y)

def main():
    with open(coastline_map, 'r') as coastline_json_file:
        coastline_data = json.load(coastline_json_file)

    coastline_geometries = coastline_data['geometries'][0]['coordinates']

    map_image = Image.new('RGB', (64, 32), color=0)
    map_drawing = ImageDraw.Draw(map_image)

    for polygon in coastline_geometries:
        scaled_points = [map_projection(c[0], c[1]) for c in polygon[0]]
        if len(set(scaled_points)) > 20:
            map_drawing.polygon(scaled_points, outline=(64,64,64))

    pixel_array = list(map_image.getdata())
    map_image.close()

    pixel_array = [0 if pixel == (0, 0, 0) else 1 for pixel in pixel_array]

    pixel_array = [pixel_array[i:i+64] for i in range(0, len(pixel_array)-1, 64)]

    for row in pixel_array:
        print(f'{row},')

if __name__ == '__main__':
    main()
