import os

for home, dirs, files in os.walk("alist-encrypt/node-proxy/src"):
    for filename in files:
        with open(os.path.join(home, filename), 'r') as f:
            lines = f.readlines()
        for i, line in enumerate(lines):
            if "process.cwd()" in line:
                lines[i] = line.replace('process.cwd()', '"/data/adb/modules/Alist-Encrypt/dist"')
        with open(os.path.join(home, filename), 'w') as f:
            f.writelines(lines)