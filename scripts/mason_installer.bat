@echo off

echo Installing mason_cli
dart pub global activate mason_cli

echo Initializing mason
mason init

echo Adding brick: config_updater
mason add config_updater --path bricks/config_updater

echo Running brick: config_updater
mason make config_updater --on-conflict overwrite

echo All commands executed successfully!