import time
import requests
import sys

f = open("data/cubelist", "r")
get_list = True
get_json = False
if len(sys.argv) > 1:
    arg = sys.argv[1]
    if arg == 'json':
        get_json = True
        List = False
    elif arg == 'both':
        get_json = True

cubes = f.readlines()
f.close()
print(cubes)

for cube in cubes:
    cube = cube[:-1]
    print("downloading " +cube)
    if get_json:
        response =requests.get("https://cubecobra.com/cube/api/cubeJSON/" + cube)
        print("received " + str(response))
        cube_data = response.json()
        q_file = open("data/cubes/" + cube + ".json", "w")
        q_file.write(str(cube_data))
        q_file.close()
        time.sleep(1)
    if get_list:
        response =requests.get("https://cubecobra.com/cube/api/cubelist/" + cube)
        print("received " + str(response))
        cube_data = response.text
        q_file = open("data/cubes/" + cube + ".txt", "w")
        q_file.write(str(cube_data))
        q_file.close()
        time.sleep(1)
print("done")