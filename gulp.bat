@echo off
REM Use custom node as old project...
set "NODE_VERSION=17.6.0"
set "NVM_SYMLINK=%NVM_HOME%\v%NODE_VERSION%"

REM Temporarily add the specific Node version to PATH
set "PATH=%NVM_SYMLINK%;%PATH%"

REM Call gulp.cmd which will use the node from PATH
call node_modules\.bin\gulp.cmd %*