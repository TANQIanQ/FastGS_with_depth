import os
from PIL import Image
from pathlib import Path

def resize_image(image_path, max_size=256):
    with Image.open(image_path) as img:
        width, height = img.size
        
        if width > height:
            new_width = max_size
            new_height = int(height * max_size / width)
        else:
            new_height = max_size
            new_width = int(width * max_size / height)
        
        img_resized = img.resize((new_width, new_height), Image.LANCZOS)
        img_resized.save(image_path)
        print(f"Resized {image_path.name}: {width}x{height} -> {new_width}x{new_height}")

def resize_images_in_directory(directory_path, max_size=256):
    directory = Path(directory_path)
    images_dir = directory / "images"
    
    if not images_dir.exists():
        print(f"Images directory not found: {images_dir}")
        return
    
    image_extensions = {'.jpg', '.jpeg', '.png', '.bmp', '.tiff', '.webp'}
    image_files = [f for f in images_dir.iterdir() if f.suffix.lower() in image_extensions]
    
    print(f"\nProcessing {len(image_files)} images in {images_dir}...")
    
    for image_file in sorted(image_files):
        try:
            resize_image(image_file, max_size)
        except Exception as e:
            print(f"Error processing {image_file.name}: {e}")

if __name__ == "__main__":
    datasets = [
        r"d:\code\ECCV\data\tandt_db\tandt\train",
        r"d:\code\ECCV\data\tandt_db\tandt\truck"
    ]
    
    print("Resizing images to max dimension 256...")
    
    for dataset in datasets:
        resize_images_in_directory(dataset, max_size=256)
    
    print("\nAll images resized successfully!")
