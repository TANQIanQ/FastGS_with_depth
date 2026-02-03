@echo off
echo Setting up FastGS environment...
echo.

cd /d "%~dp0"

echo Running uv sync...
uv sync

if %errorlevel% neq 0 (
    echo uv sync failed!
    pause
    exit /b %errorlevel%
)

echo.
echo Installing packages from submodules directory using uv pip install...
echo.

cd submodules

echo Installing diff-gaussian-rasterization_fastgs...
uv pip install ./diff-gaussian-rasterization_fastgs --no-build-isolation

if %errorlevel% neq 0 (
    echo Installation of diff-gaussian-rasterization_fastgs failed!
    pause
    exit /b %errorlevel%
)

echo.
echo Installing fused-ssim...
uv pip install ./fused-ssim --no-build-isolation

if %errorlevel% neq 0 (
    echo Installation of fused-ssim failed!
    pause
    exit /b %errorlevel%
)

echo.
echo Installing simple-knn...
uv pip install ./simple-knn --no-build-isolation

if %errorlevel% neq 0 (
    echo Installation of simple-knn failed!
    pause
    exit /b %errorlevel%
)

echo.
echo Setup completed successfully!
pause
