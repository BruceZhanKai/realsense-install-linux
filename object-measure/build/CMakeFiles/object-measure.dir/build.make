# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.5

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
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/ubuntu/github/realsense-install-linux/object-measure

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/ubuntu/github/realsense-install-linux/object-measure/build

# Include any dependencies generated for this target.
include CMakeFiles/object-measure.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/object-measure.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/object-measure.dir/flags.make

CMakeFiles/object-measure.dir/object-measure.cpp.o: CMakeFiles/object-measure.dir/flags.make
CMakeFiles/object-measure.dir/object-measure.cpp.o: object-measure.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/ubuntu/github/realsense-install-linux/object-measure/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/object-measure.dir/object-measure.cpp.o"
	/usr/bin/c++   $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/object-measure.dir/object-measure.cpp.o -c /home/ubuntu/github/realsense-install-linux/object-measure/build/object-measure.cpp

CMakeFiles/object-measure.dir/object-measure.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/object-measure.dir/object-measure.cpp.i"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/ubuntu/github/realsense-install-linux/object-measure/build/object-measure.cpp > CMakeFiles/object-measure.dir/object-measure.cpp.i

CMakeFiles/object-measure.dir/object-measure.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/object-measure.dir/object-measure.cpp.s"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/ubuntu/github/realsense-install-linux/object-measure/build/object-measure.cpp -o CMakeFiles/object-measure.dir/object-measure.cpp.s

CMakeFiles/object-measure.dir/object-measure.cpp.o.requires:

.PHONY : CMakeFiles/object-measure.dir/object-measure.cpp.o.requires

CMakeFiles/object-measure.dir/object-measure.cpp.o.provides: CMakeFiles/object-measure.dir/object-measure.cpp.o.requires
	$(MAKE) -f CMakeFiles/object-measure.dir/build.make CMakeFiles/object-measure.dir/object-measure.cpp.o.provides.build
.PHONY : CMakeFiles/object-measure.dir/object-measure.cpp.o.provides

CMakeFiles/object-measure.dir/object-measure.cpp.o.provides.build: CMakeFiles/object-measure.dir/object-measure.cpp.o


# Object files for target object-measure
object__measure_OBJECTS = \
"CMakeFiles/object-measure.dir/object-measure.cpp.o"

# External object files for target object-measure
object__measure_EXTERNAL_OBJECTS =

object-measure: CMakeFiles/object-measure.dir/object-measure.cpp.o
object-measure: CMakeFiles/object-measure.dir/build.make
object-measure: /usr/local/lib/libopencv_videostab.so.3.4.4
object-measure: /usr/local/lib/libopencv_objdetect.so.3.4.4
object-measure: /usr/local/lib/libopencv_ml.so.3.4.4
object-measure: /usr/local/lib/libopencv_photo.so.3.4.4
object-measure: /usr/local/lib/libopencv_superres.so.3.4.4
object-measure: /usr/local/lib/libopencv_stitching.so.3.4.4
object-measure: /usr/local/lib/libopencv_dnn.so.3.4.4
object-measure: /usr/local/lib/libopencv_shape.so.3.4.4
object-measure: /usr/local/lib/libglfw.so.3.2
object-measure: /usr/lib/x86_64-linux-gnu/libGLU.so
object-measure: /usr/lib/x86_64-linux-gnu/libGL.so
object-measure: /usr/local/lib/libopencv_calib3d.so.3.4.4
object-measure: /usr/local/lib/libopencv_features2d.so.3.4.4
object-measure: /usr/local/lib/libopencv_flann.so.3.4.4
object-measure: /usr/local/lib/libopencv_highgui.so.3.4.4
object-measure: /usr/local/lib/libopencv_videoio.so.3.4.4
object-measure: /usr/local/lib/libopencv_imgcodecs.so.3.4.4
object-measure: /usr/local/lib/libopencv_video.so.3.4.4
object-measure: /usr/local/lib/libopencv_imgproc.so.3.4.4
object-measure: /usr/local/lib/libopencv_core.so.3.4.4
object-measure: CMakeFiles/object-measure.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/ubuntu/github/realsense-install-linux/object-measure/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable object-measure"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/object-measure.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/object-measure.dir/build: object-measure

.PHONY : CMakeFiles/object-measure.dir/build

CMakeFiles/object-measure.dir/requires: CMakeFiles/object-measure.dir/object-measure.cpp.o.requires

.PHONY : CMakeFiles/object-measure.dir/requires

CMakeFiles/object-measure.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/object-measure.dir/cmake_clean.cmake
.PHONY : CMakeFiles/object-measure.dir/clean

CMakeFiles/object-measure.dir/depend:
	cd /home/ubuntu/github/realsense-install-linux/object-measure/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/ubuntu/github/realsense-install-linux/object-measure /home/ubuntu/github/realsense-install-linux/object-measure /home/ubuntu/github/realsense-install-linux/object-measure/build /home/ubuntu/github/realsense-install-linux/object-measure/build /home/ubuntu/github/realsense-install-linux/object-measure/build/CMakeFiles/object-measure.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/object-measure.dir/depend

