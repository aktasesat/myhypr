import os
import shutil
import logging
from datetime import datetime

# Setup configuration
SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
REPO_ROOT = os.path.dirname(SCRIPT_DIR)
LOG_FILE = os.path.join(SCRIPT_DIR, "backup.log")

# Setup logging
logging.basicConfig(
    filename=LOG_FILE,
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    datefmt='%Y-%m-%d %H:%M:%S'
)

console_handler = logging.StreamHandler()
console_handler.setLevel(logging.INFO)
formatter = logging.Formatter('%(asctime)s - %(levelname)s - %(message)s')
console_handler.setFormatter(formatter)
logging.getLogger().addHandler(console_handler)

def backup_file(source, dest):
    try:
        if not os.path.exists(source):
            logging.warning(f"Source file not found: {source}")
            return False
        
        # Create parent directories if they don't exist
        os.makedirs(os.path.dirname(dest), exist_ok=True)
        
        shutil.copy2(source, dest, follow_symlinks=True)
        logging.info(f"Successfully backed up file: {source} -> {dest}")
        return True
    except Exception as e:
        logging.error(f"Failed to backup file {source}: {str(e)}")
        return False

def backup_dir(source, dest):
    try:
        if not os.path.exists(source):
            logging.warning(f"Source directory not found: {source}")
            return False
            
        # If destination exists, we need to handle it. copytree with dirs_exist_ok=True (Python 3.8+)
        # If we want to be clean, maybe we should remove dest first? 
        # But 'updating' usually implies overwriting. 
        # dirs_exist_ok=True allows overwriting.
        
        if os.path.exists(dest):
             shutil.rmtree(dest) # Remove old directory to ensure clean state (no stale files)
             
        shutil.copytree(source, dest, symlinks=False, ignore_dangling_symlinks=True, dirs_exist_ok=True)
        logging.info(f"Successfully backed up directory: {source} -> {dest}")
        return True
    except Exception as e:
        logging.error(f"Failed to backup directory {source}: {str(e)}")
        return False

def main():
    logging.info("Starting configuration backup...")
    
    # Define mappings (Source -> Destination relative to repo root)
    # Source is expanded from user home.
    # Destination is relative to REPO_ROOT.
    
    home = os.path.expanduser("~")
    
    # Folder mappings
    dirs_to_backup = {
        os.path.join(home, ".config/foot"): "foot",
        os.path.join(home, ".config/hypr"): "hypr",
        os.path.join(home, ".config/nvim"): "nvim",
        os.path.join(home, ".config/rofi"): "rofi",
        os.path.join(home, ".config/waybar"): "waybar",
    }

    # File mappings
    files_to_backup = {
        os.path.join(home, ".config/fish/config.fish"): "config.fish",
        os.path.join(home, ".config/mimeapps.list"): "mimeapps.list"
    }
    
    success_count = 0
    fail_count = 0
    
    # Backup Directories
    for source, relative_dest in dirs_to_backup.items():
        dest = os.path.join(REPO_ROOT, relative_dest)
        if backup_dir(source, dest):
            success_count += 1
        else:
            fail_count += 1
            
    # Backup Files
    for source, relative_dest in files_to_backup.items():
        dest = os.path.join(REPO_ROOT, relative_dest)
        # Check alternative locations if primary fails?
        # For now, implemented as requested.
        
        if "mimeapps.list" in source and not os.path.exists(source):
             # Fallback for mimeapp.list typo if user really has that
             alt_source = os.path.join(home, ".config/mimeapp.list")
             if os.path.exists(alt_source):
                 logging.info(f"Context: Found {alt_source} instead of mimeapps.list")
                 source = alt_source
        
        if backup_file(source, dest):
            success_count += 1
        else:
            fail_count += 1

    logging.info(f"Backup completed. Success: {success_count}, Failed: {fail_count}")
    print(f"\nBackup finished. Check {LOG_FILE} for details.")

if __name__ == "__main__":
    main()
