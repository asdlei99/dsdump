# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.14

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /Applications/CMake.app/Contents/bin/cmake

# The command to remove a file.
RM = /Applications/CMake.app/Contents/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /Users/lolgrep/code/xref/llvm

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /Users/lolgrep/code/xref

# Include any dependencies generated for this target.
include tools/llvm-cat/CMakeFiles/llvm-cat.dir/depend.make

# Include the progress variables for this target.
include tools/llvm-cat/CMakeFiles/llvm-cat.dir/progress.make

# Include the compile flags for this target's objects.
include tools/llvm-cat/CMakeFiles/llvm-cat.dir/flags.make

tools/llvm-cat/CMakeFiles/llvm-cat.dir/llvm-cat.cpp.o: tools/llvm-cat/CMakeFiles/llvm-cat.dir/flags.make
tools/llvm-cat/CMakeFiles/llvm-cat.dir/llvm-cat.cpp.o: llvm/tools/llvm-cat/llvm-cat.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/lolgrep/code/xref/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object tools/llvm-cat/CMakeFiles/llvm-cat.dir/llvm-cat.cpp.o"
	cd /Users/lolgrep/code/xref/tools/llvm-cat && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/llvm-cat.dir/llvm-cat.cpp.o -c /Users/lolgrep/code/xref/llvm/tools/llvm-cat/llvm-cat.cpp

tools/llvm-cat/CMakeFiles/llvm-cat.dir/llvm-cat.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/llvm-cat.dir/llvm-cat.cpp.i"
	cd /Users/lolgrep/code/xref/tools/llvm-cat && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/lolgrep/code/xref/llvm/tools/llvm-cat/llvm-cat.cpp > CMakeFiles/llvm-cat.dir/llvm-cat.cpp.i

tools/llvm-cat/CMakeFiles/llvm-cat.dir/llvm-cat.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/llvm-cat.dir/llvm-cat.cpp.s"
	cd /Users/lolgrep/code/xref/tools/llvm-cat && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/lolgrep/code/xref/llvm/tools/llvm-cat/llvm-cat.cpp -o CMakeFiles/llvm-cat.dir/llvm-cat.cpp.s

# Object files for target llvm-cat
llvm__cat_OBJECTS = \
"CMakeFiles/llvm-cat.dir/llvm-cat.cpp.o"

# External object files for target llvm-cat
llvm__cat_EXTERNAL_OBJECTS =

bin/llvm-cat: tools/llvm-cat/CMakeFiles/llvm-cat.dir/llvm-cat.cpp.o
bin/llvm-cat: tools/llvm-cat/CMakeFiles/llvm-cat.dir/build.make
bin/llvm-cat: lib/libLLVMIRReader.a
bin/llvm-cat: lib/libLLVMBitReader.a
bin/llvm-cat: lib/libLLVMBitWriter.a
bin/llvm-cat: lib/libLLVMCore.a
bin/llvm-cat: lib/libLLVMSupport.a
bin/llvm-cat: lib/libLLVMAsmParser.a
bin/llvm-cat: lib/libLLVMAnalysis.a
bin/llvm-cat: lib/libLLVMProfileData.a
bin/llvm-cat: lib/libLLVMObject.a
bin/llvm-cat: lib/libLLVMBitReader.a
bin/llvm-cat: lib/libLLVMCore.a
bin/llvm-cat: lib/libLLVMRemarks.a
bin/llvm-cat: lib/libLLVMMCParser.a
bin/llvm-cat: lib/libLLVMMC.a
bin/llvm-cat: lib/libLLVMBinaryFormat.a
bin/llvm-cat: lib/libLLVMDebugInfoCodeView.a
bin/llvm-cat: lib/libLLVMDebugInfoMSF.a
bin/llvm-cat: lib/libLLVMSupport.a
bin/llvm-cat: lib/libLLVMDemangle.a
bin/llvm-cat: tools/llvm-cat/CMakeFiles/llvm-cat.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/Users/lolgrep/code/xref/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable ../../bin/llvm-cat"
	cd /Users/lolgrep/code/xref/tools/llvm-cat && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/llvm-cat.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
tools/llvm-cat/CMakeFiles/llvm-cat.dir/build: bin/llvm-cat

.PHONY : tools/llvm-cat/CMakeFiles/llvm-cat.dir/build

tools/llvm-cat/CMakeFiles/llvm-cat.dir/clean:
	cd /Users/lolgrep/code/xref/tools/llvm-cat && $(CMAKE_COMMAND) -P CMakeFiles/llvm-cat.dir/cmake_clean.cmake
.PHONY : tools/llvm-cat/CMakeFiles/llvm-cat.dir/clean

tools/llvm-cat/CMakeFiles/llvm-cat.dir/depend:
	cd /Users/lolgrep/code/xref && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/lolgrep/code/xref/llvm /Users/lolgrep/code/xref/llvm/tools/llvm-cat /Users/lolgrep/code/xref /Users/lolgrep/code/xref/tools/llvm-cat /Users/lolgrep/code/xref/tools/llvm-cat/CMakeFiles/llvm-cat.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : tools/llvm-cat/CMakeFiles/llvm-cat.dir/depend
