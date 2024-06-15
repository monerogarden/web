import os
import re

def list_subfolders_and_files(base_folder):
    subfolders_files = {}
    for subdir, _, files in os.walk(base_folder):
        if subdir == base_folder:
            continue
        files = [f for f in files if f.endswith('.md')]
        files.sort()
        if files:
            subfolders_files[subdir] = files
    return subfolders_files

def remove_existing_links(content):
    """
    This function removes the previously added navigation links with HTML <a> tags.
    """
    pattern = re.compile(r'(\n\n<p align=\'center\' style=\'margin-top: 1\.5em;\'>.*?</p>\n)', re.DOTALL)
    return re.sub(pattern, '', content)

def add_navigation_links(subfolder, files):
    """
    This function adds navigation links to each file in the given subfolder.
    """
    for i, file in enumerate(files):
        file_path = os.path.join(subfolder, file)
        
        # Open the file to read the content and remove existing links
        with open(file_path, 'r+') as f:
            content = f.read()
            content = remove_existing_links(content)
            
            # Prepare navigation links
            next_link = f'<a href="./{files[i+1]}">Next ►</a>' if i < len(files) - 1 else ""
            prev_link = f'<a href="./{files[i-1]}">◄ Previous</a>' if i > 0 else ""
            nav_links = f"\n\n<p align='center' style='margin-top: 1.5em;'><span style='margin-right: 1em;'>{prev_link}</span> <span style='color: #ff774d;'>/</span> <span style='margin-left: 1em;'>{next_link}</span></p>\n"
            
            # Move to the beginning of the file to write updated content
            f.seek(0)
            f.write(content)
            f.truncate()
        
        # Open the file again in append mode to add new navigation links
        with open(file_path, 'a') as f:
            f.write(nav_links)

def process_folder(base_folder):
    subfolders_files = list_subfolders_and_files(base_folder)
    for subfolder, files in subfolders_files.items():
        add_navigation_links(subfolder, files)

if __name__ == "__main__":
    base_folder = "content"
    process_folder(base_folder)
