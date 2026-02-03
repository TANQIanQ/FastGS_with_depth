@echo off
echo Training FastGS on train and truck datasets...
echo.

echo Training on train dataset...
uv run python train.py -s d:\code\ECCV\data\tandt_db\tandt\train  --densification_interval 500 --optimizer_type default --test_iterations 30000 --highfeature_lr 0.042 --grad_abs_thresh 0.0015 --dense 0.01 --mult 0.7

if %errorlevel% neq 0 (
    echo Training on train dataset failed!
    pause
    exit /b %errorlevel%
)

echo.
echo Training on truck dataset...
uv run python train.py -s d:\code\ECCV\data\tandt_db\tandt\truck  --densification_interval 500 --optimizer_type default --test_iterations 30000 --highfeature_lr 0.04 --grad_abs_thresh 0.0009 --mult 0.7

if %errorlevel% neq 0 (
    echo Training on truck dataset failed!
    pause
    exit /b %errorlevel%
)

echo.
echo Rendering train dataset...
uv run python render.py -m output/train --skip_train --mult 0.7

if %errorlevel% neq 0 (
    echo Rendering train dataset failed!
    pause
    exit /b %errorlevel%
)

echo.
echo Rendering truck dataset...
uv run python render.py -m output/truck --skip_train --mult 0.7

if %errorlevel% neq 0 (
    echo Rendering truck dataset failed!
    pause
    exit /b %errorlevel%
)

echo.
echo Computing metrics for train dataset...
uv run python metrics.py -m output/train

if %errorlevel% neq 0 (
    echo Metrics for train dataset failed!
    pause
    exit /b %errorlevel%
)

echo.
echo Computing metrics for truck dataset...
uv run python metrics.py -m output/truck

if %errorlevel% neq 0 (
    echo Metrics for truck dataset failed!
    pause
    exit /b %errorlevel%
)

echo.
echo All tasks completed successfully!
pause
