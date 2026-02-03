#!/bin/bash

echo "Setting up FastGS environment..."
echo

cd "$(dirname "$0")"

echo "Running uv sync..."
uv sync

if [ $? -ne 0 ]; then
    echo "uv sync failed!"
    exit 1
fi

echo
echo "Installing packages from submodules directory using uv pip install..."
echo

cd submodules

echo "Installing diff-gaussian-rasterization_fastgs..."
uv pip install ./diff-gaussian-rasterization_fastgs --no-build-isolation 

if [ $? -ne 0 ]; then
    echo "Installation of diff-gaussian-rasterization_fastgs failed!"
    exit 1
fi

echo
echo "Installing fused-ssim..."
uv pip install ./fused-ssim --no-build-isolation 

if [ $? -ne 0 ]; then
    echo "Installation of fused-ssim failed!"
    exit 1
fi

echo
echo "Installing simple-knn..."
uv pip install ./simple-knn --no-build-isolation 

if [ $? -ne 0 ]; then
    echo "Installation of simple-knn failed!"
    exit 1
fi

echo
echo "Setup completed successfully!"
