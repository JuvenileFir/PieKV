# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.16

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
CMAKE_SOURCE_DIR = /home/bwb/PieKV/FlexibleKV_previous_version

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/bwb/PieKV/FlexibleKV_previous_version/build

# Include any dependencies generated for this target.
include CMakeFiles/flexiblekv.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/flexiblekv.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/flexiblekv.dir/flags.make

CMakeFiles/flexiblekv.dir/fkv.c.o: CMakeFiles/flexiblekv.dir/flags.make
CMakeFiles/flexiblekv.dir/fkv.c.o: ../fkv.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/bwb/PieKV/FlexibleKV_previous_version/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object CMakeFiles/flexiblekv.dir/fkv.c.o"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/flexiblekv.dir/fkv.c.o   -c /home/bwb/PieKV/FlexibleKV_previous_version/fkv.c

CMakeFiles/flexiblekv.dir/fkv.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/flexiblekv.dir/fkv.c.i"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/bwb/PieKV/FlexibleKV_previous_version/fkv.c > CMakeFiles/flexiblekv.dir/fkv.c.i

CMakeFiles/flexiblekv.dir/fkv.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/flexiblekv.dir/fkv.c.s"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/bwb/PieKV/FlexibleKV_previous_version/fkv.c -o CMakeFiles/flexiblekv.dir/fkv.c.s

CMakeFiles/flexiblekv.dir/flow_controler.c.o: CMakeFiles/flexiblekv.dir/flags.make
CMakeFiles/flexiblekv.dir/flow_controler.c.o: ../flow_controler.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/bwb/PieKV/FlexibleKV_previous_version/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building C object CMakeFiles/flexiblekv.dir/flow_controler.c.o"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/flexiblekv.dir/flow_controler.c.o   -c /home/bwb/PieKV/FlexibleKV_previous_version/flow_controler.c

CMakeFiles/flexiblekv.dir/flow_controler.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/flexiblekv.dir/flow_controler.c.i"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/bwb/PieKV/FlexibleKV_previous_version/flow_controler.c > CMakeFiles/flexiblekv.dir/flow_controler.c.i

CMakeFiles/flexiblekv.dir/flow_controler.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/flexiblekv.dir/flow_controler.c.s"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/bwb/PieKV/FlexibleKV_previous_version/flow_controler.c -o CMakeFiles/flexiblekv.dir/flow_controler.c.s

CMakeFiles/flexiblekv.dir/shm.c.o: CMakeFiles/flexiblekv.dir/flags.make
CMakeFiles/flexiblekv.dir/shm.c.o: ../shm.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/bwb/PieKV/FlexibleKV_previous_version/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building C object CMakeFiles/flexiblekv.dir/shm.c.o"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/flexiblekv.dir/shm.c.o   -c /home/bwb/PieKV/FlexibleKV_previous_version/shm.c

CMakeFiles/flexiblekv.dir/shm.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/flexiblekv.dir/shm.c.i"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/bwb/PieKV/FlexibleKV_previous_version/shm.c > CMakeFiles/flexiblekv.dir/shm.c.i

CMakeFiles/flexiblekv.dir/shm.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/flexiblekv.dir/shm.c.s"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/bwb/PieKV/FlexibleKV_previous_version/shm.c -o CMakeFiles/flexiblekv.dir/shm.c.s

CMakeFiles/flexiblekv.dir/basic_hash.c.o: CMakeFiles/flexiblekv.dir/flags.make
CMakeFiles/flexiblekv.dir/basic_hash.c.o: ../basic_hash.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/bwb/PieKV/FlexibleKV_previous_version/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Building C object CMakeFiles/flexiblekv.dir/basic_hash.c.o"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/flexiblekv.dir/basic_hash.c.o   -c /home/bwb/PieKV/FlexibleKV_previous_version/basic_hash.c

CMakeFiles/flexiblekv.dir/basic_hash.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/flexiblekv.dir/basic_hash.c.i"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/bwb/PieKV/FlexibleKV_previous_version/basic_hash.c > CMakeFiles/flexiblekv.dir/basic_hash.c.i

CMakeFiles/flexiblekv.dir/basic_hash.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/flexiblekv.dir/basic_hash.c.s"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/bwb/PieKV/FlexibleKV_previous_version/basic_hash.c -o CMakeFiles/flexiblekv.dir/basic_hash.c.s

CMakeFiles/flexiblekv.dir/partition.c.o: CMakeFiles/flexiblekv.dir/flags.make
CMakeFiles/flexiblekv.dir/partition.c.o: ../partition.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/bwb/PieKV/FlexibleKV_previous_version/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_5) "Building C object CMakeFiles/flexiblekv.dir/partition.c.o"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/flexiblekv.dir/partition.c.o   -c /home/bwb/PieKV/FlexibleKV_previous_version/partition.c

CMakeFiles/flexiblekv.dir/partition.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/flexiblekv.dir/partition.c.i"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/bwb/PieKV/FlexibleKV_previous_version/partition.c > CMakeFiles/flexiblekv.dir/partition.c.i

CMakeFiles/flexiblekv.dir/partition.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/flexiblekv.dir/partition.c.s"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/bwb/PieKV/FlexibleKV_previous_version/partition.c -o CMakeFiles/flexiblekv.dir/partition.c.s

CMakeFiles/flexiblekv.dir/cuckoo.c.o: CMakeFiles/flexiblekv.dir/flags.make
CMakeFiles/flexiblekv.dir/cuckoo.c.o: ../cuckoo.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/bwb/PieKV/FlexibleKV_previous_version/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_6) "Building C object CMakeFiles/flexiblekv.dir/cuckoo.c.o"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/flexiblekv.dir/cuckoo.c.o   -c /home/bwb/PieKV/FlexibleKV_previous_version/cuckoo.c

CMakeFiles/flexiblekv.dir/cuckoo.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/flexiblekv.dir/cuckoo.c.i"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/bwb/PieKV/FlexibleKV_previous_version/cuckoo.c > CMakeFiles/flexiblekv.dir/cuckoo.c.i

CMakeFiles/flexiblekv.dir/cuckoo.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/flexiblekv.dir/cuckoo.c.s"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/bwb/PieKV/FlexibleKV_previous_version/cuckoo.c -o CMakeFiles/flexiblekv.dir/cuckoo.c.s

CMakeFiles/flexiblekv.dir/table.cpp.o: CMakeFiles/flexiblekv.dir/flags.make
CMakeFiles/flexiblekv.dir/table.cpp.o: ../table.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/bwb/PieKV/FlexibleKV_previous_version/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_7) "Building CXX object CMakeFiles/flexiblekv.dir/table.cpp.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/flexiblekv.dir/table.cpp.o -c /home/bwb/PieKV/FlexibleKV_previous_version/table.cpp

CMakeFiles/flexiblekv.dir/table.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/flexiblekv.dir/table.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/bwb/PieKV/FlexibleKV_previous_version/table.cpp > CMakeFiles/flexiblekv.dir/table.cpp.i

CMakeFiles/flexiblekv.dir/table.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/flexiblekv.dir/table.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/bwb/PieKV/FlexibleKV_previous_version/table.cpp -o CMakeFiles/flexiblekv.dir/table.cpp.s

CMakeFiles/flexiblekv.dir/basic_log.c.o: CMakeFiles/flexiblekv.dir/flags.make
CMakeFiles/flexiblekv.dir/basic_log.c.o: ../basic_log.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/bwb/PieKV/FlexibleKV_previous_version/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_8) "Building C object CMakeFiles/flexiblekv.dir/basic_log.c.o"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/flexiblekv.dir/basic_log.c.o   -c /home/bwb/PieKV/FlexibleKV_previous_version/basic_log.c

CMakeFiles/flexiblekv.dir/basic_log.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/flexiblekv.dir/basic_log.c.i"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/bwb/PieKV/FlexibleKV_previous_version/basic_log.c > CMakeFiles/flexiblekv.dir/basic_log.c.i

CMakeFiles/flexiblekv.dir/basic_log.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/flexiblekv.dir/basic_log.c.s"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/bwb/PieKV/FlexibleKV_previous_version/basic_log.c -o CMakeFiles/flexiblekv.dir/basic_log.c.s

CMakeFiles/flexiblekv.dir/slab_store.c.o: CMakeFiles/flexiblekv.dir/flags.make
CMakeFiles/flexiblekv.dir/slab_store.c.o: ../slab_store.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/bwb/PieKV/FlexibleKV_previous_version/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_9) "Building C object CMakeFiles/flexiblekv.dir/slab_store.c.o"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/flexiblekv.dir/slab_store.c.o   -c /home/bwb/PieKV/FlexibleKV_previous_version/slab_store.c

CMakeFiles/flexiblekv.dir/slab_store.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/flexiblekv.dir/slab_store.c.i"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/bwb/PieKV/FlexibleKV_previous_version/slab_store.c > CMakeFiles/flexiblekv.dir/slab_store.c.i

CMakeFiles/flexiblekv.dir/slab_store.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/flexiblekv.dir/slab_store.c.s"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/bwb/PieKV/FlexibleKV_previous_version/slab_store.c -o CMakeFiles/flexiblekv.dir/slab_store.c.s

# Object files for target flexiblekv
flexiblekv_OBJECTS = \
"CMakeFiles/flexiblekv.dir/fkv.c.o" \
"CMakeFiles/flexiblekv.dir/flow_controler.c.o" \
"CMakeFiles/flexiblekv.dir/shm.c.o" \
"CMakeFiles/flexiblekv.dir/basic_hash.c.o" \
"CMakeFiles/flexiblekv.dir/partition.c.o" \
"CMakeFiles/flexiblekv.dir/cuckoo.c.o" \
"CMakeFiles/flexiblekv.dir/table.cpp.o" \
"CMakeFiles/flexiblekv.dir/basic_log.c.o" \
"CMakeFiles/flexiblekv.dir/slab_store.c.o"

# External object files for target flexiblekv
flexiblekv_EXTERNAL_OBJECTS =

libflexiblekv.a: CMakeFiles/flexiblekv.dir/fkv.c.o
libflexiblekv.a: CMakeFiles/flexiblekv.dir/flow_controler.c.o
libflexiblekv.a: CMakeFiles/flexiblekv.dir/shm.c.o
libflexiblekv.a: CMakeFiles/flexiblekv.dir/basic_hash.c.o
libflexiblekv.a: CMakeFiles/flexiblekv.dir/partition.c.o
libflexiblekv.a: CMakeFiles/flexiblekv.dir/cuckoo.c.o
libflexiblekv.a: CMakeFiles/flexiblekv.dir/table.cpp.o
libflexiblekv.a: CMakeFiles/flexiblekv.dir/basic_log.c.o
libflexiblekv.a: CMakeFiles/flexiblekv.dir/slab_store.c.o
libflexiblekv.a: CMakeFiles/flexiblekv.dir/build.make
libflexiblekv.a: CMakeFiles/flexiblekv.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/bwb/PieKV/FlexibleKV_previous_version/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_10) "Linking CXX static library libflexiblekv.a"
	$(CMAKE_COMMAND) -P CMakeFiles/flexiblekv.dir/cmake_clean_target.cmake
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/flexiblekv.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/flexiblekv.dir/build: libflexiblekv.a

.PHONY : CMakeFiles/flexiblekv.dir/build

CMakeFiles/flexiblekv.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/flexiblekv.dir/cmake_clean.cmake
.PHONY : CMakeFiles/flexiblekv.dir/clean

CMakeFiles/flexiblekv.dir/depend:
	cd /home/bwb/PieKV/FlexibleKV_previous_version/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/bwb/PieKV/FlexibleKV_previous_version /home/bwb/PieKV/FlexibleKV_previous_version /home/bwb/PieKV/FlexibleKV_previous_version/build /home/bwb/PieKV/FlexibleKV_previous_version/build /home/bwb/PieKV/FlexibleKV_previous_version/build/CMakeFiles/flexiblekv.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/flexiblekv.dir/depend

