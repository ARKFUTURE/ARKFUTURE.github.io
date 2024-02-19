import os
import hashlib
import csv
import io
import sys

sys.stdout = io.TextIOWrapper(sys.stdout.buffer,encoding='utf-8')

def get_md5(file_path):
    with open(file_path, 'rb') as f:
        md5 = hashlib.md5()
        while True:
            data = f.read(8192)
            if not data:
                break
            md5.update(data)
    return md5.hexdigest()

def traverse_directory(path):
    result = []
    for root, dirs, files in os.walk(path):
        for file in files:
            file_path = os.path.join(root, file)
            relative_path = os.path.relpath(file_path, path)
            dir_name, file_name = os.path.split(relative_path)
            file_md5 = get_md5(file_path)
            result.append((dir_name, file_name, file_md5))
    return result

def export_to_csv(data, output_file):
    with open(output_file, 'w', newline='') as f:
        writer = csv.writer(f)
        writer.writerow(['目录名', '文件名', 'MD5值'])
        writer.writerows(data)

if __name__ == '__main__':
    path = os.getcwd()
    output_file = 'res.csv'
    data = traverse_directory(path)
    export_to_csv(data, output_file)
    print("已完成")
